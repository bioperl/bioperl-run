# $Id$
#
# BioPerl module for Bio::DB::SoapEUtilities::FetchAdaptor::species
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

Bio::DB::SoapEUtilities::FetchAdaptor::species - Fetch adaptor for
'taxonomy' efetch SOAP messages

=head1 SYNOPSIS

Imported by L<Bio::DB::SoapEUtilities::FetchAdaptor> as required.

=head1 DESCRIPTION

Returns an iterator over L<Bio::Species> objects:

 my $fac = Bio::DB::SoapEUtilities->new;
 my $taxio = $fac->efetch(-db => 'taxonomy', -id => 1394)->run(-auto_adapt=>1);
 my $sp = $taxio->next_species;
 $sp->binomial; # returns 'Bacillus caldolyticus'

To find out the object type returned:
 
 $class = $seqio->obj_class; # $class is 'Bio::Species'

as for all L<Bio::DB::SoapEUtilities::FetchAdaptor> objects.

=head1 SEE ALSO

L<Bio::DB::SoapEUtilities>, L<Bio::DB::SoapEUtilities::FetchAdaptor>

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


package Bio::DB::SoapEUtilities::FetchAdaptor::species;
use strict;

# Object preamble - inherits from Bio::Root::Root

use Bio::Root::Root;
use Bio::Species;

use base qw(Bio::DB::SoapEUtilities::FetchAdaptor Bio::Root::Root );

sub _initialize {
    my ($self, @args) = @_;
    $self->SUPER::_initialize(@args);
#    my ($builder, $seqfac ) = $self->_rearrange( [qw(SEQBUILDER
#                                                     SEQFACTORY)], @args );
    $self->{'_obj_class'} = 'Bio::Species' ; 
    $self->{'_idx'} = 1;
    1;
}

sub rewind { shift->{'_idx'} = 1 }

sub obj_class { shift->{'_obj_class'} }

sub next_species { shift->next_obj }

sub next_obj {
    my $self = shift;
    my $stem = "//TaxaSet/[".$self->{'_idx'}."]";
#    my $stem = "//Body/".$self->result->result_type."/[".$self->{'_idx'}."]";
    my $som = $self->result->som;

    return unless defined $som->valueof($stem);
    my $get = sub { $som->valueof("$stem/".shift) };
    my $toplev = $som->valueof("$stem");
    my $get_tl = sub { $toplev->{ shift @_ } };
    my $sp = _read_species($get_tl);
    $self->warn("FetchAdaptor::species - parse error, no Bio::Species returned") unless $sp;
    ($self->{_idx})++;
    return $sp;
}
1;

# mostly ripped from Bio::SeqIO::genbank...

sub _read_species {
    my ($get) = @_;
    
    my @unkn_names = ('other', 'unknown organism', 'not specified', 'not shown',
		      'Unspecified', 'Unknown', 'None', 'unclassified',
		      'unidentified organism', 'not supplied');
    # dictionary of synonyms for taxid 32644
    my @unkn_genus = ('unknown','unclassified','uncultured','unidentified');
    # all above can be part of valid species name

    my( $sub_species, $species, $genus, $sci_name, $common, 
         $abbr_name, $organelle);

    $sci_name = $get->('ScientificName') || return;

# no "source" elt like gb format./maj

    # parse out organelle, common name, abbreviated name if present;
    # this should catch everything, but falls back to
    # entire GBSeq_taxonomy element just in case
#     if ($get->('source') =~ m{^
# 		              (mitochondrion|chloroplast|plastid)?
# 		              \s*(.*?)
# 		              \s*(?: \( (.*?) \) )?\.?
# 		              $}xms ) { 
#         ($organelle, $abbr_name, $common) = ($1, $2, $3); # optional
#     } else {
#         $abbr_name = $get->('source'); # nothing caught; this is a backup!
#     }

#     # Convert data in classification lines into classification array.
    my @class = split(/; /, $get->('Lineage'));

    # do we have a genus?
    my $possible_genus =  quotemeta($class[-1])
       . ($class[-2] ? "|" . quotemeta($class[-2]) : '');
    if ($sci_name =~ /^($possible_genus)/) {
	$genus = $1;
	($species) = $sci_name =~ /^$genus\s+(.+)/;
    }
    else {
	$species = $sci_name;
    }

    # is this organism of rank species or is it lower?
    # (we don't catch everything lower than species, but it doesn't matter -
    # this is just so we abide by previous behaviour whilst not calling a
    # species a subspecies)
    if ($species && $species =~ /subsp\.|var\./) {
	($species, $sub_species) = $species =~ /(.+)\s+((?:subsp\.|var\.).+)/;
    }

    # Don't make a species object if it's empty or "Unknown" or "None"
    # return unless $genus and  $genus !~ /^(Unknown|None)$/oi;
    # Don't make a species object if it belongs to taxid 32644
    my $src = $get->('ScientificName');
    return unless ($species || $genus) and 
	!grep { $_ eq $src } @unkn_names;

    # Bio::Species array needs array in Species -> Kingdom direction
    push(@class, $sci_name);
    @class = reverse @class;

    my $make = Bio::Species->new();
    $make->scientific_name($sci_name);
    $make->classification(@class) if @class > 0;
    $make->common_name( $get->('CommonName'));
    $make->name('abbreviated', $abbr_name) if $abbr_name;
    $make->organelle($organelle) if $organelle;
    $make->ncbi_taxid( $get->('TaxId') );
    $make->division( $get->('Division') );
    return $make;
}

1;
