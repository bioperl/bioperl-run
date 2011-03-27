# $Id$
#
# BioPerl module for Bio::DB::SoapEUtilities::GQueryAdaptor
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

Bio::DB::SoapEUtilities::GQueryAdaptor - Handle for Entrez SOAP GlobalQuery items

=head1 SYNOPSIS

 my $fac = Bio::DB::SoapEUtilities->new();
 # run a query, returning a GQueryAdaptor
 my $queries = $fac->egquery( -term => 'BRCA and human' )->run(-auto_adapt=>1);
 # all databases with hits
 my @dbs = $queries->found_in_dbs;
 # queries by database
 my $prot_count = $queries->query_by_db('prot')->count;
 # iterate over gquery
 while ( my $q = $queries->next_query ) {
    my $db = $q->db;
    my $count = $q->count;
    my $status = $q->status;
 }

=head1 DESCRIPTION

This adaptor provides an iterator (C<next_query()>) and other
convenience functions for parsing NCBI Entrez EUtility C<egquery>
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

package Bio::DB::SoapEUtilities::GQueryAdaptor;
use strict;

# Object preamble - inherits from Bio::Root::Root

use Bio::Root::Root;

use base qw(Bio::Root::Root );

=head2 new

 Title   : new
 Usage   : my $obj = new Bio::DB::SoapEUtilities::GQueryAdaptor();
 Function: Builds a new Bio::DB::SoapEUtilities::GQueryAdaptor object
 Returns : an instance of Bio::DB::SoapEUtilities::GQueryAdaptor
 Args    :

=cut

sub new {
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    my ($result) = $self->_rearrange([qw(RESULT)], @args);
    $self->throw("GQueryAdaptor requires a SoapEUtilities::Result argument")
	unless $result;
    $self->throw("GQueryAdaptor only works with egquery results") unless
	$result->util eq 'egquery';
    $self->{'_result'} = $result;
    $self->{'_query_by_db'} = {};
    $self->{'_idx'} = 1;
    return $self;
}

sub result { shift->{'_result'} }

=head2 next_query()

 Title   : next_query
 Usage   : 
 Function: return the next global query from the attached Result
 Returns : 
 Args    : 

=cut

sub next_query {
    my $self = shift;
#    my $stem = "//Body/".$self->result->result_type."/[".$self->{'_idx'}."]";
    # not consistent, kludge as follows:
    my $stem = "//eGQueryResult/[".$self->{'_idx'}."]";
    my $som = $self->result->som;
    return unless $som->valueof($stem);
    my ($ret, %params);
    my $get = sub { $som->valueof("$stem/".shift) };
    my $toplev = $get->('');
    my $get_tl = sub { $toplev->{ shift @_ } };
    
    $params{'-term'} = $som->valueof("//Term");

    my $names = [];
    $params{'-count'} = $get_tl->('Count');
    $params{'-db'} = $get_tl->('DbName');
    $params{'-status'} = $get_tl->('Status');

    my $class = ref($self)."::gquery";
    $ret = $class->new(%params);
    $self->{_query_by_db}->{$params{'-db'}} = $ret;
    ($self->{'_idx'})++;
    return $ret;
}

sub next_obj { shift->next_query(@_) }

sub rewind { shift->{'_idx'} = 1; };

=head2 found_in_dbs()

 Title   : found_in_dbs
 Usage   : 
 Function: Return list of db names containing hits for 
           the query term
 Returns : array of scalar strings
 Args    : none

=cut

sub found_in_dbs {
    my $self = shift;
    return @{$self->{'_found_in_dbs'}} if $self->{'_found_in_dbs'};
    my $som = $self->result->som;
    $self->{'_found_in_dbs'} = [];
    foreach ($som->valueof("//eGQueryResult/*")) {
	push @{$self->{'_found_in_dbs'}}, $_->{'DbName'} if
	    $_->{'Count'};
    }
    return @{$self->{'_found_in_dbs'}};
}

=head2 query_by_db()

 Title   : query_by_db
 Usage   : 
 Function: get gquery object by db name
 Returns : 
 Args    : db name (scalar string)

=cut

sub query_by_db {
    my $self = shift;
    my $db = shift;

    $self->throw("db must be specified") unless $db;
    return $self->{_query_by_db}->{$db} if $self->{_query_by_db}->{$db};
    my $som = $self->result->som;
    my $i;
    for ($i = 1; my $val = $som->valueof("//eGQueryResult/[$i]/DbName"); $i++) {
	last if $val eq $db;
    }
    my $curidx = $self->{_idx};
    my $query;
    {
	local $self->{_idx} = $i;
        $query = $self->next_query;
    }
    return $query;
}
    
1; 

####
package Bio::DB::SoapEUtilities::GQueryAdaptor::gquery;
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
