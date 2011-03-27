# $Id$
#
# BioPerl module for Bio::DB::SoapEUtilities::LinkAdaptor
#
# Please direct questions and support issues to <bioperl-l@bioperl.org>
#
# Cared for by Mark A. Jensen <maj -at- fortinbras -dot- us>
#
# Copyright Mark A. Jensen
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::DB::SoapEUtilities::LinkAdaptor - Handle for Entrez SOAP LinkSets

=head1 SYNOPSIS

 my $fac = Bio::DB::SoapEUtilities->new();
 # run a query, returning a LinkAdaptor
 $fac->elink( -db => 'nucleotide',
              -dbfrom => 'protein',
              -id => [qw(828392 790 470338)]);
 my $links = $fac->elink->run( -auto_adapt => 1);
 # get the linked ids corresponding to the submitted ids
 # (may be arrays if multiple crossrefs, or undef if none)
 my @nucids = $links->id_map(828392);
 # iterate over linksets
 while ( my $ls = $links->next_linkset ) {
    my @from_ids = $ls->submitted_ids;
    my @to_ids = $ls->ids;
    my $from_db = $ls->db_from;
    my $to_db = $ls->db_to;
 }

=head1 DESCRIPTION

This adaptor provides an iterator (C<next_linkset()>) and other
convenience functions for parsing NCBI Entrez EUtility C<elink>
SOAP results.

=head1 SEE ALSO

L<Bio::DB::SoapEUtilities>

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support

Please direct usage questions or support issues to the mailing list:

L<bioperl-l@bioperl.org>

rather than to the module maintainer directly. Many experienced and
reponsive experts will be able look at the problem and quickly
address it. Please include a thorough description of the problem
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
the web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Mark A. Jensen

Email maj -at- fortinbras -dot- us

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

# Let the code begin...

package Bio::DB::SoapEUtilities::LinkAdaptor;
use strict;
use warnings;

# Object preamble - inherits from Bio::Root::Root

use Bio::Root::Root;

use base qw(Bio::Root::Root );

=head2 new

 Title   : new
 Usage   : my $obj = new Bio::DB::SoapEUtilities::LinkAdaptor();
 Function: Builds a new Bio::DB::SoapEUtilities::LinkAdaptor object
 Returns : an instance of Bio::DB::SoapEUtilities::LinkAdaptor
 Args    :

=cut

sub new {
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    my ($result) = $self->_rearrange([qw(RESULT)], @args);
    $self->throw("LinkAdaptor requires a SoapEUtilities::Result argument")
	unless $result;
    $self->throw("LinkAdaptor only works with elink results") unless
	$result->util eq 'elink';
    $self->{'_result'} = $result;
    $self->{'_idx'} = 1;
    return $self;
}

sub result { shift->{'_result'} }

=head2 next_linkset()

 Title   : next_linkset
 Usage   : 
 Function: return the next LinkSet from the attached Result
 Returns : 
 Args    : 

=cut

sub next_linkset {
    my $self = shift;
    my $stem = "//Body/".$self->result->result_type."/[".$self->{'_idx'}."]";
    return unless $self->result->som and $self->result->som->valueof($stem);
    my $som = $self->result->som;
    my ($ret, %params);
    my $get = sub { $som->valueof("$stem/".shift) };
    
    $params{'-db_from'} = $get->('DbFrom');
    $params{'-db_to'} = $get->('LinkSetDb/DbTo');
    $params{'-link_name'} = $get->('LinkSetDb/LinkName');
    $params{'-submitted_ids'} = [$get->('IdList/*')];
    $params{'-ids'} = [$get->('LinkSetDb/Link/*')];
    $params{'-webenv'} = $get->('WebEnv');
    my $class = ref($self)."::linkset";
    $ret = $class->new(%params);
    ($self->{'_idx'})++;
    return $ret;
}

sub next_obj { shift->next_linkset(@_) }

sub rewind { shift->{'_idx'} = 1; };

=head2 id_map()

 Title   : id_map
 Usage   : $to_id = $adaptor->id_map($from_id)
 Function: Return 'to-database' ids corresponding to
           given specified 'from-database' or
           submitted ids
 Returns : array of scalars (to-database ids or arrayrefs of ids)
 Args    : array of scalars (from-database ids)

=cut

sub id_map {
    my $self = shift;
    my @from_ids = @_;
    my $som = $self->result->som;
    my $stem = "//Body/".$self->result->result_type."/";
    if (!defined $self->{'_id_map'}) {
	my $h = {};
	for (my $i=1; $som->valueof($stem."[$i]"); $i++) {
	    # note this assumes that in the elink query, 
	    # ids were provided individually (not as a comma-sep
	    # list). This is the standard behavior for elink 
	    # in SoapEUtilities.
	    my @to_ids = $som->valueof($stem."[$i]/LinkSetDb/Link/*");
	    $$h{$som->valueof($stem."[$i]/IdList/[1]")} =
		(@to_ids == 1 ? $to_ids[0] : \@to_ids);
	}
	$self->{'_id_map'} = $h;
    }
    return @{$self->{'_id_map'}}{@from_ids};
}

package Bio::DB::SoapEUtilities::LinkAdaptor::linkset;
use strict;
use warnings;

use base qw(Bio::Root::Root);

sub new {
    my ($class, @args) = @_;
    my $self = $class->SUPER::new(@args);
    my %args = @args;
    $self->_set_from_args( \%args,
			   -methods => [map { /^-?(.*)/ } keys %args],
			   -create => 1,
			   -code =>
			   'my $self = shift; 
                            my $d = shift;
                            my $k = \'_\'.$method;
                            $self->{$k} = $d if $d;
                            return (ref $self->{$k} eq \'ARRAY\') ?
                                   @{$self->{$k}} : $self->{$k};'

	);
    return $self;
}

1;
