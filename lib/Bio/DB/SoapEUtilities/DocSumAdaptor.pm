# $Id$
#
# BioPerl module for Bio::DB::SoapEUtilities::DocSumAdaptor
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

Bio::DB::SoapEUtilities::DocSumAdaptor - Handle for Entrez SOAP DocSums

=head1 SYNOPSIS

 my $fac = Bio::DB::SoapEUtilities->new();
 # run a query, returning a DocSumAdaptor
 my $docs = $fac->esummary( -db => 'taxonomy',
                            -id => 527031 )->run(-auto_adapt=>1);
 # iterate over docsums
 while (my $d = $docs->next_docsum) {
    @available_items = $docsum->item_names;
    # any available item can be called as an accessor
    # from the docsum object...watch your case...
    $sci_name = $d->ScientificName;
    $taxid = $d->TaxId;
 }

=head1 DESCRIPTION

This adaptor provides an iterator (C<next_docsum()>) and other
convenience functions for parsing NCBI Entrez EUtility C<esummary>
SOAP results.

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


package Bio::DB::SoapEUtilities::DocSumAdaptor;
use strict;

# Object preamble - inherits from Bio::Root::Root

use Bio::Root::Root;

use base qw(Bio::Root::Root );

=head2 new

 Title   : new
 Usage   : my $obj = new Bio::DB::SoapEUtilities::DocSumAdaptor();
 Function: Builds a new Bio::DB::SoapEUtilities::DocSumAdaptor object
 Returns : an instance of Bio::DB::SoapEUtilities::DocSumAdaptor
 Args    :

=cut

sub new {
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    my ($result) = $self->_rearrange([qw(RESULT)], @args);
    $self->throw("DocSumAdaptor requires a SoapEUtilities::Result argument")
	unless $result;
    $self->throw("DocSumAdaptor only works with elink results") unless
	$result->util eq 'esummary';
    $self->{'_result'} = $result;
    $self->{'_idx'} = 1;
    return $self;
}

sub result { shift->{'_result'} }

=head2 next_docsum()

 Title   : next_docsum
 Usage   : 
 Function: return the next DocSum from the attached Result
 Returns : 
 Args    : 

=cut

sub next_docsum {
    my $self = shift;
    my $stem = "//Body/".$self->result->result_type."/[".$self->{'_idx'}."]";
    my $som = $self->result->som;
    return unless $som->valueof($stem);
    my ($ret, %params);
    my $get = sub { $som->valueof("$stem/".shift) };
    
    $params{'-id'} = $get->('Id');

    my $names = [];
    for (my $i = 1; my $data = $som->dataof("$stem/[$i]"); $i++) {
	if ( $data->value and $data->value !~ /^\s*$/) {
	    my $name = $data->attr->{'Name'};
	    next unless $name;
	    my $content = $som->valueof("$stem/[$i]/ItemContent");
	    unless (defined $content) {
		next unless $som->dataof("$stem/[$i]/Item");
		my $h = {};
		_traverse_items("$stem/[$i]", $som, $h);
		$content = $h;
	    }
	    push @$names, $name;
	    $params{$name} = $content;
	}
    }
    $params{'_item_names'} = $names;
    my $class = ref($self)."::docsum";
    $ret = $class->new(%params);
    ($self->{'_idx'})++;
    return $ret;
}

sub next_obj { shift->next_docsum(@_) }

sub rewind { shift->{'_idx'} = 1; };

sub _traverse_items {
    my ($stem, $som, $h) = @_;
    for (my $i = 1; my $data = $som->dataof($stem."/[$i]"); $i++) {
	my $name = $data->attr->{'Name'};
	next unless $name;
	if ($name =~ /Type$/) {
	    # clip out this node
	    _traverse_items("$stem/[$i]", $som, $h);
	}
	else {
	    my $content = $som->valueof("$stem/[$i]/ItemContent");
	    if ($content) {
		$$h{$name} = $content;
	    }
	    else {
		$$h{$name} = {};
		_traverse_items("$stem/[$i]", $som, $$h{$name});
	    }
	}
    }
    return;
}

1; 

####
package Bio::DB::SoapEUtilities::DocSumAdaptor::docsum;
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
                            return (ref($self->{$k}) eq \'ARRAY\' ?
                                   @{$self->{$k}} : $self->{$k});'

	);
    return $self;
}

=head2 item_names()

 Title   : item_names
 Usage   : @accs = $docsum->item_names
 Function: Return a list of items accessible from the 
           object
 Returns : array of scalar strings
 Args    : none

=cut

sub item_names { my $a = shift->{'__item_names'} ; return @$a if $a }
    
1;
