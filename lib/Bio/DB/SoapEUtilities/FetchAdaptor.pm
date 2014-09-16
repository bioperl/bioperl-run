# $Id$
#
# BioPerl module for Bio::DB::SoapEUtilities::FetchAdaptor
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

Bio::DB::SoapEUtilities::FetchAdaptor - Conversion of Entrez SOAP messages to BioPerl objects

=head1 SYNOPSIS

 $fac = Bio::DB::SoapEUtilities->new();
 $soap_result = $fac->efetch( -db => 'protein', -id => 2597988 );
 $adp = Bio::DB::SoapEUtilities::FetchAdaptor(
         -result => $soap_result,
         -type => 'seq'
        );
 while ( $gb_seq = $adp->next_obj ) {
    # do stuff
 }

=head1 DESCRIPTION

C<FetchAdaptor> is the base class of a system, modeled after
L<Bio::SeqIO>, to parse SOAP responses from the NCBI Entrez C<efetch>
utility into germane BioPerl objects.

The user will rarely need to instantiate a C<FetchAdaptor> with
L<Bio::DB::SoapEUtilities::Result> object as in the L</SYNOPSIS>. It
usually suffices to use the C<-auto_adapt> parameter in the factory
C<run()> method:

 my $fac = Bio::DB::SoapEUtilities->new();
 my $taxio = $fac->efetch(-db => 'taxonomy', -id => 1394)->run(-auto_adapt=>1);
 my $sp = $taxio->next_species; # Bio::Species objects
 my $seqio = $fac->efetch(-db => 'protein', -id => 730439)->run(-auto_adapt=>1);
 my $seq = $seqio->next_seq; # Bio::Seq::RichSeq objects

=head1 SEE ALSO

L<Bio::DB::SoapEUtilities>, C<FetchAdaptor> subclasses

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

package Bio::DB::SoapEUtilities::FetchAdaptor;
use strict;

use Bio::Root::Root;

use base qw(Bio::Root::Root );

=head2 new

 Title   : new
 Usage   : my $obj = new Bio::DB::SoapEUtilities::FetchAdaptor();
 Function: Builds a new Bio::DB::SoapEUtilities::FetchAdaptor object
 Returns : an instance of Bio::DB::SoapEUtilities::FetchAdaptor
 Args    : named arguments
           -som => $soap_som_object (soap message)
           -type => $type ( optional, forces loading of $type adaptor )

=cut

sub new {
    my ($class,@args) = @_;
    $class = ref($class) || $class;
    if ($class =~ /.*?::FetchAdaptor::(\S+)/) {
	my $self = $class->SUPER::new(@args);
	$self->_initialize(@args);
	return $self;
    }
    else {
	my %args = @args;
	my $result = $args{'-result'} || $args{'-RESULT'};
	$class->throw("Bio::DB::SoapEUtilities::Result argument required") unless $result;
	$class->throw("RESULT argument must be a Bio::DB::SoapEUtilities::Result object") unless
	ref($result) eq 'Bio::DB::SoapEUtilities::Result';
	# identify the correct adaptor module to load using Result info
	my $type ||= $result->fetch_type;
	$class->throw("Can't determine fetch type for this result")
	    unless $type;
	# $type ultimately contains a FetchAdaptor subclass
	return unless( $class->_load_adaptor($type, $result) );
	return "Bio::DB::SoapEUtilities::FetchAdaptor::$type"->new(@args);
    }
}

=head2 _initialize()

 Title   : _initialize
 Usage   : 
 Function: 
 Returns : 
 Args    : 

=cut

sub _initialize {
    my $self = shift;
    my @args = @_;
    my ($result, $type) = $self->_rearrange([qw( RESULT TYPE )], @args);
    $self->throw("Bio::DB::SoapEUtilities::Result argument required") unless $result;
    $self->throw("RESULT argument must be a Bio::DB::SoapEUtilities::Result object") unless
	ref($result) eq 'Bio::DB::SoapEUtilities::Result';
    $self->{'_type'} = $type || $result->fetch_type;
    $self->{'_result'} = $result;
    1;
}

=head2 _load_adaptor()

 Title   : _load_adaptor
 Usage   : 
 Function: loads a FetchAdaptor subclass
 Returns : 
 Args    : adaptor type (subclass name)

=cut

sub _load_adaptor {
    my ($class, $type, $result) = @_;
    return unless $type;
    # specials
    for ($result->fetch_type) {
	$_ eq 'seq' && do {
	    $_[1] = $type = 'species' if $result->fetch_db and 
		$result->fetch_db eq 'taxonomy';
	    last;
	};
	# else, leave $type alone
    }
    my $module = "Bio::DB::SoapEUtilities::FetchAdaptor::".$type;
    my $ok;
    eval {
	$ok = $class->_load_module($module);
    };
    for ($@) {
	/^$/ && do {
	    return $ok;
	};
	/Can't locate/ && do {
	    $class->throw("Fetch adaptor for '$type' not found");
	};
	do { # else 
	    $class->throw("Error in fetch adaptor for '$type' : $@");
	};
    }
}

=head2 obj_class()

 Title   : obj_class
 Usage   : $adaptor->obj_class
 Function: Returns the fully qualified BioPerl classname
           of the objects returned by next_obj()
 Returns : scalar string (class name)
 Args    : none

=cut

sub obj_class { shift->throw_not_implemented }

=head2 next_obj()

 Title   : next_obj
 Usage   : $obj = $adaptor->next_obj
 Function: Returns the next parsed BioPerl object from the 
           adaptor
 Returns : object of class obj_class()
 Args    : none

=cut

sub next_obj { shift->throw_not_implemented }

=head2 rewind()

 Title   : rewind
 Usage   : 
 Function: Rewind the adaptor's iterator
 Returns : 
 Args    : none

=cut

sub rewind { shift->throw_not_implemented }

=head2 result()

 Title   : result
 Usage   : 
 Function: contains the SoapEUtilities::Result object
 Returns : Bio::DB::SoapEUtilities::Result object
 Args    : none

=cut

sub result { shift->{'_result'} }

=head2 type()

 Title   : type
 Usage   : 
 Function: contains the fetch type of this adaptor
 Returns : 
 Args    : 

=cut

sub type { shift->{'_type'} }
1;
