# $Id$
#
# BioPerl module for Bio::DB::SoapEUtilities::FetchAdaptor::seq
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

Bio::DB::SoapEUtilities::FetchAdaptor::seq - Fetch adaptor for 'seq'
efetch SOAP messages

=head1 SYNOPSIS

Imported by L<Bio::DB::SoapEUtilities::FetchAdaptor> as required.

=head1 DESCRIPTION

Returns an iterator over L<Bio::Seq> or L<Bio::Seq::RichSeq> objects,
depending on the the return type of the C<efetch>. A standard
C<efetch> to a sequence database will return a GenBank SOAP result;
this will be parsed into rich sequence objects:

 my $fac = Bio::DB::SoapEUtilities->new;
 my $seqio = $fac->efetch(-db => 'protein', -id => 730439)->run(-auto_adapt=>1);
 my $seq = $seqio->next_seq;
 $seq->species->binomial; # returns 'Bacillus caldolyticus'

An C<efetch> with C<-rettype => 'fasta'> will be parsed into
L<Bio::Seq> objects (VERY much faster):

 $seqio = $fac->efetch( -rettype => 'fasta' )->run(-auto_adapt=>1);
 $seq = $seqio->next_seq;
 $seq->species; # undef
 $seq->desc; # kitchen sink

To find out the object type returned:
 
 $class = $seqio->obj_class;

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

=head1 CONTRIBUTORS

Much inspiration from L<Bio::SeqIO> and family.

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

# Let the code begin...

package Bio::DB::SoapEUtilities::FetchAdaptor::seq;
use strict;

use Bio::Root::Root;
use Bio::Annotation::Collection;
use Bio::Annotation::Comment;
use Bio::Annotation::DBLink;
use Bio::Annotation::Reference;
use Bio::Annotation::SimpleValue;
use Bio::Factory::FTLocationFactory;
use Bio::SeqFeature::Generic;
use Bio::Seq::SeqBuilder;
use Bio::Seq::SeqFactory;
use Bio::Species;

use base qw(Bio::DB::SoapEUtilities::FetchAdaptor Bio::Root::Root);

our %VALID_ALPHABET = (
    'AA' => 'protein',
    'DNA' => 'dna',
    'RNA' => 'rna'
);

our %TYPE_XLT = (
    'Bio::Seq' => ['TSeqSet','TSeq'],
    'Bio::Seq::RichSeq' => ['GBSet', 'GBSeq']
    );

sub _initialize {
    my ($self, @args) = @_;
    $self->SUPER::_initialize(@args);
    my ($builder, $seqfac ) = $self->_rearrange( [qw(SEQBUILDER
                                                     SEQFACTORY)], @args );
    # choose rich or simple seq based on result

    my ($t) = keys %{$self->result->som->method};
    for ($t) {
	/^GB/ && do {
	    $t = 'GB'; # genbank info
	    $self->{'_obj_class'} = ($seqfac ? $seqfac->type : 'Bio::Seq::RichSeq');
	    last;
	};
	/^T/ && do {
	    $t = 'T'; # fasta info
	    $self->{'_obj_class'} = ($seqfac ? $seqfac->type : 'Bio::Seq');
	    last;
	};
	$self->throw("FetchAdaptor::seq : unrecognized result elt type '$t', can't parse");
    }
    
    $self->{'_builder'} = $builder || Bio::Seq::SeqBuilder->new();
    $self->{'_builder'}->sequence_factory( 
	$seqfac || Bio::Seq::SeqFactory->new( -type => $self->{'_obj_class'} )
	);
    $self->{'_locfac'} = Bio::Factory::FTLocationFactory->new();
    $self->{'_idx'} = 1;
    1;
}

sub rewind { shift->{'_idx'} = 1 }

sub obj_class { shift->{'_obj_class'} }

sub builder { shift->{'_builder'} };

sub locfac { shift->{'_locfac'} };

sub next_obj {
    my $self = shift;
    my $t = $TYPE_XLT{$$self{_obj_class}};
    
    my $stem = "//$$t[0]/[".$self->{'_idx'}."]";
    my $som = $self->result->som;
    my $seqid;
    return unless defined $som->valueof("$stem");

    my $get = sub { $som->valueof("$stem/$$t[1]_".shift) };
    # speed up (?) by caching top-level data hash
    my $toplev = $som->valueof("$stem");
    my $get_tl = sub { $toplev->{"$$t[1]_".shift} };

    my %params = (-verbose => $self->verbose);

    if ($t->[0] =~ /^T/) {
	$params{'-display_id'} = $get_tl->('accver');
	$params{'-primary_id'} = $get_tl->('gi');
	$params{'-length'} = $get_tl->('length');
	$params{'-desc'} = $get_tl->('defline');
	$params{'-seq'} = $get_tl->('sequence');
	$params{'-alphabet'} = $get_tl->('seqtype') || undef;
	$self->builder->add_slot_value(%params);
	($self->{_idx})++;
	if ( !$self->builder->want_object ) { # skip 
	    $self->builder->make_object;
	    goto &next_obj;
	}
	else {
	    return $self->builder->make_object;
	}
    }
    elsif ($t->[0] =~ /^GB/) {
	# source, id, alphabet
	$params{'-display_id'} = $get_tl->('locus');
	$params{'-length'} = $get_tl->('length');
	$get_tl->('moltype') =~ /(AA|[DR]NA)/;
	$params{'-alphabet'} = $VALID_ALPHABET{$1} || '';
	
	# molecule, division, dates
	$params{'-molecule'} = $get_tl->('moltype');
	$params{'-is_circular'} = ($get_tl->('topology') eq 'circular');
	$params{'-division'} = $get->('division');
	$params{'-dates'} = [$get_tl->('create-date'), $get_tl->('update-date')];

	$self->builder->add_slot_value(%params);
	%params = ();
	
	if ( !$self->builder->want_object ) { # skip this
	    $self->builder->make_object;
	    ($self->{_idx})++;
	    goto &next_obj;
	}
	
	# accessions, version, pid, description
	$get_tl->('accession-version') =~ /.*\.([0-9]+)$/;
	$params{'-version'} = $params{'-seq_version'} = $1;
	my @secondary_ids;
	my @ids = $get->('other-seqids/GBSeqid');
	foreach (@ids) {
	    /^gi\|([0-9]+)/ && do {
		$seqid = $params{'-primary_id'} = $1;
		$params{'-accession_number'} = $_; # correct?
		next;
	    };
	    do { # else
		push @secondary_ids, $_;
		next;
	    };
	}
	$params{'-secondary_accessions'} = \@secondary_ids;
	
	$params{'-desc'} = $get->('definition');
	
	# sequence 
	if ( $self->builder->want_slot('seq')) {
	    $params{'-seq'} = $get->('sequence');
	}
	
	# keywords
	if ($get->('keywords')) {
	    my @kw;
	    foreach my $kw ($som->valueof("$stem/GBSeq_keywords/*")) {
		push @kw, $kw;
	    }
	    $params{'-keywords'} = join(' ',@kw);
	}
	
	$self->builder->add_slot_value(%params);
	%params = ();    
	
	my $ann;
	# annotations
	if ($self->builder->want_slot('annotation')) {
	    $ann = Bio::Annotation::Collection->new();
	    # references
	    if ($get->('references')) {
		$ann->add_Annotation('reference', $_) 
		    for _read_references($stem,$som);
	    }
	    
	    # comment
	    if ($get_tl->('comment')) {
		$ann->add_Annotation('comment', 
				     Bio::Annotation::Comment->new(
					 -tagname => 'comment',
					 -text => $get_tl->('comment')
				     )
		    );
	    }
	    # project
	    if ( $get_tl->('project') ) {
		$ann->add_Annotation('project',
				     Bio::Annotation::SimpleValue->new(
					 -value => $get_tl->('project')
				     )
		    );
	    }
	    # contig
	    if ($get_tl->('contig')) {
		$ann->add_Annotation('contig',
				     Bio::Annotation::SimpleValue->new(
					 -value => $get_tl->('contig')
				     )
		    );
	    }
	    
	    # dblink
	    if ($get_tl->('source-db')) {
		_read_db_source($ann, $get);
	    } 
	    
	    $self->builder->add_slot_value(-annotation => $ann);
	}

	# features
	my $feats;
	if ($self->builder->want_slot('features')) {
	    $feats = _read_features($stem,$som,$self->locfac,$get);
	    $self->builder->add_slot_value(
		-features => $feats
		);
	}
	
	# organism data
	if ( $self->builder->want_slot('species') && $get_tl->('source') ) {
	    my $sp = _read_species($get);
	    if ($sp && !$sp->ncbi_taxid) {
		my ($src) = grep { $_->primary_tag eq 'source' } @$feats;
		if ($src) {
		    foreach my $val ($src->get_tag_values('db_xref')) {
			$sp->ncbi_taxid(substr($val,6)) if index($val,"taxon:") == 0;
		    }
		}
	    }
	    $self->builder->add_slot_value( -species => $sp );
	}
    }
    else {
	$self->throw("FetchAdaptor::seq : unrecognized result elt type '$t', can't parse");
    }
    
    ($self->{_idx})++;
    return $self->builder->make_object;
}

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

    $sci_name = $get->('organism') || return;

    # parse out organelle, common name, abbreviated name if present;
    # this should catch everything, but falls back to
    # entire GBSeq_taxonomy element just in case
    if ($get->('source') =~ m{^
		              (mitochondrion|chloroplast|plastid)?
		              \s*(.*?)
		              \s*(?: \( (.*?) \) )?\.?
		              $}xms ) { 
        ($organelle, $abbr_name, $common) = ($1, $2, $3); # optional
    } else {
        $abbr_name = $get->('source'); # nothing caught; this is a backup!
    }

    # Convert data in classification lines into classification array.
    my @class = split(/; /, $get->('taxonomy'));

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
    my $src = $get->('source');
    return unless ($species || $genus) and 
	!grep { $_ eq $src } @unkn_names;

    # Bio::Species array needs array in Species -> Kingdom direction
    push(@class, $sci_name);
    @class = reverse @class;

    my $make = Bio::Species->new();
    $make->scientific_name($sci_name);
    $make->classification(@class) if @class > 0;
    $make->common_name( $common ) if $common;
    $make->name('abbreviated', $abbr_name) if $abbr_name;
    $make->organelle($organelle) if $organelle;

    return $make;
}

sub next_seq { shift->next_obj }

sub _read_references {
    my ($stem, $som) = @_;
    my @ret;
    for ( my $i = 1; $som->valueof($stem."/GBSeq_references/[$i]"); $i++ ) {
	my $get = sub { 
	    $som->valueof($stem."/GBSeq_references/[$i]/GBReference_".shift ) 
	};
	my %params;
	$params{'-title'} = $get->('title');
	$params{'-pubmed'} = $get->('pubmed');
	$params{'-medline'} = $get->('pubmed');
	$params{'-journal'} = $get->('journal');
	$params{'-comment'} = $get->('remark');
	$params{'-consortium'} = $get->('consortium');

	my $pos = $get->('position');
	$pos and $pos =~ /^([0-9]+)[.]+([0-9]+)$/;
	$params{'-start'} = $1;
	$params{'-end'} = $2;
	$params{'-gb_reference'} = $get->('reference');
	$params{'-authors'} = '';
	foreach my $author ( $get->('authors/*') ) {
	    $params{'-authors'} .= " $author";
	}
	push @ret, Bio::Annotation::Reference->new(
	    -tagname => 'reference',
	    %params);
    }
    return @ret;
}

sub _read_features {
    my ($stem, $som, $locfac, $get_pri) = @_;
    my @ret;
    my $seqid = $get_pri->('primary-accession');

    for ( my $i = 1; $get_pri->("feature-table/[$i]"); $i++ ) {
	my $get = sub { 
	    $som->valueof($stem."/GBSeq_feature-table/[$i]/GBFeature_".shift ) 
	};
	my $loc;
	my $sf = Bio::SeqFeature::Generic->direct_new();
	if ($get->('location')) {
	    # may have to parse GBIntervals instead here...
	    $loc = $locfac->from_string( $get->('location') );
	    if ($seqid && !($loc->is_remote)) {
		$loc->seq_id($seqid);
	    }
	}
	$sf->location($loc);
	$sf->seq_id($seqid);
	$sf->primary_tag($get->('key'));
	$sf->source_tag('EMBL/GenBank/SwissProt');
	# fill other fields using $sf->add_tag_value...
	
	# qualifiers are name => value pairs. add as tags 
	# to this feature
	if ($get->('quals')) {
	    foreach ($get->('quals/*')) {
		$sf->add_tag_value( $_->{'GBQualifier_name'},
				    $_->{'GBQualifier_value'} );
	    }
	}
	if ($get->('partial5')) {
	    $sf->add_tag_value( 'is_partial5', 
				$get->('partial5') eq 'true' ? 1 : 0)
	}
	if ($get->('partial3')) {
	    $sf->add_tag_value( 'is_partial3', 
				$get->('partial3') eq 'true' ? 1 : 0)
	}
	push @ret, $sf;
    }
    return \@ret;
}

sub _read_db_source {
    my ($ann, $get) = @_;
    my $dbsource = $get->('source-db');
    # ripped mainly from Bio::SeqIO::genbank...
    # deal with UniProKB dbsources
    if( $dbsource =~ 
	s/(UniProt(?:KB)?|swissprot):\s+locus\s+(\S+)\,[^.]+\.\s*// ) {
	$ann->add_Annotation
	    ('dblink',
	     Bio::Annotation::DBLink->new
	     (-primary_id => $2,
	      -database => $1,
	      -tagname => 'dblink'));
	if( $dbsource =~ s/created:\s+([^.]+)\.\s*// ) {
	    $ann->add_Annotation
		('swissprot_dates',
		 Bio::Annotation::SimpleValue->new
		 (-tagname => 'date_created',
		  -value => $1));
	}
	while( $dbsource =~ 
	       s/\s+(sequence|annotation)\s+
                         updated:\s+([^.]+)\.\s*//xg ) {
	    $ann->add_Annotation
		('swissprot_dates',
		 Bio::Annotation::SimpleValue->new
		 (-tagname => 'date_updated',
		  -value => $2));
	}
	$dbsource =~ s/\n/ /g;
	if ( $dbsource =~ s/xrefs:\s+
                                    ((?:\S+,\s+)+\S+)\s+xrefs/xrefs/x ) {
	    # will use $i to determine even or odd
	    # for swissprot the accessions are paired
	    my $i = 0;
	    for my $dbsrc ( split(/,\s+/,$1) ) {
		if( $dbsrc =~ /(\S+)\.(\d+)/ ||
		    $dbsrc =~ /(\S+)/ ) {
		    my ($id,$version) = ($1,$2);
		    $version ='' unless defined $version;
		    my $db;
		    if( $id =~ /^\d\S{3}/) {
			$db = 'PDB';
		    } else {
			$db = ($i++ % 2 ) ? 'GenPept' : 'GenBank';
		    }
		    $ann->add_Annotation
			('dblink',
			 Bio::Annotation::DBLink->new
			 (-primary_id => $id,
			  -version => $version,
			  -database => $db,
			  -tagname => 'dblink'));
		}
	    }
	} 
	elsif ( $dbsource =~ s/xrefs:\s+(.+)\s+xrefs/xrefs/i ) {
	    # download screwed up and ncbi didn't put 
	    # acc in for gi numbers
	    my $i = 0;
	    for my $id ( split(/\,\s+/,$1) ) {
		my ($acc,$db);
		if( $id =~ /gi:\s+(\d+)/ ) {
		    $acc= $1;
		    $db = ($i++ % 2 ) ? 'GenPept' : 'GenBank';
		} elsif( $id =~ /pdb\s+accession\s+(\S+)/ ) {
		    $acc= $1;
		    $db = 'PDB';
		} else {
		    $acc= $id;
		    $db = '';
		}
		$ann->add_Annotation
		    ('dblink',
		     Bio::Annotation::DBLink->new
		     (-primary_id => $acc,
		      -database => $db,
		      -tagname => 'dblink'));
	    }
	} else {
	    warn "Cannot match $dbsource";
	}
	if( $dbsource =~ s/xrefs\s+\(non\-sequence\s+databases\):\s+
			   ((?:\S+,\s+)+\S+)//x ) {
	    for my $id ( split(/\,\s+/,$1) ) {
		my $db;
		# quote from Bio::SeqIO::genbank:
		# this is because GenBank dropped the spaces!!!
		# I'm sure we're not going to get this right
		$db = substr($id,0,index($id,':'));
		$id = substr($id,index($id,':')+1);
		$ann->add_Annotation
		    ('dblink',
		     Bio::Annotation::DBLink->new
		     (-primary_id => $id,
		      -database => $db,
		      -tagname => 'dblink'));
	    }
	}
    }
    else {
	if( $dbsource =~ /^(\S*?):?\s*accession\s+(\S+)\.(\d+)/ ) {
	    my ($db,$id,$version) = ($1,$2,$3);
	    $ann->add_Annotation
		('dblink',
		 Bio::Annotation::DBLink->new
		 (-primary_id => $id,
		  -version => $version,
		  -database => $db || 'GenBank',
		  -tagname => 'dblink'));
	} elsif ( $dbsource =~ /(\S+)([\.:])(\d+)/ ) {
	    my ($id, $db, $version);
	    if ($2 eq ':') {
		($db, $id) = ($1, $3);
	    } else {
		($db, $id, $version) = ('GenBank', $1, $3);
	    }
	    $ann->add_Annotation('dblink',
				 Bio::Annotation::DBLink->new(
				     -primary_id => $id,
				     -version => $version,
				     -database => $db,
				     -tagname => 'dblink')
		);
	} 
	else {
	    warn "Unrecognized DBSOURCE data: $dbsource";
	}
    }
    return 1;
}
1;

__END__

here\'s an example:

PROTEIN

0  HASH(0x439b8a8)
   'GBSet' => HASH(0x439c010)
      'GBSeq' => HASH(0x43a79c8)
         'GBSeq_accession-version' => 'CAA53922.1'
         'GBSeq_comment' => 'On Nov 8, 1997 this sequence version replaced gi:443947.'
         'GBSeq_create-date' => '18-JAN-1994'
         'GBSeq_definition' => 'sonic hedgehog [Mus musculus]'
         'GBSeq_division' => 'ROD'
         'GBSeq_feature-table' => HASH(0x43abf4c)
            'GBFeature' => HASH(0x43b23b4)
               'GBFeature_intervals' => HASH(0x43b800c)
                  'GBInterval' => HASH(0x43b83fc)
                     'GBInterval_accession' => 'CAA53922.1'
                     'GBInterval_from' => 1
                     'GBInterval_to' => 437
               'GBFeature_key' => 'CDS'
               'GBFeature_location' => '1..437'
               'GBFeature_quals' => HASH(0x43b8378)
                  'GBQualifier' => HASH(0x43baeb0)
                     'GBQualifier_name' => 'db_xref'
                     'GBQualifier_value' => 'UniProtKB/Swiss-Prot:Q62226'
         'GBSeq_length' => 437
         'GBSeq_locus' => 'CAA53922'
         'GBSeq_moltype' => 'AA'
         'GBSeq_organism' => 'Mus musculus'
         'GBSeq_other-seqids' => HASH(0x43ab028)
            'GBSeqid' => 'gi|2597988'
         'GBSeq_primary-accession' => 'CAA53922'
         'GBSeq_references' => HASH(0x43abe80)
            'GBReference' => HASH(0x43af1f8)
               'GBReference_authors' => HASH(0x43af3e4)
                  'GBAuthor' => 'McMahon,A.P.'
               'GBReference_journal' => 'Submitted (03-NOV-1997) A.P. McMahon, Harvard University, 16 Divinity Ave., Cambridge, MA 02138, USA'
               'GBReference_position' => '1..437'
               'GBReference_reference' => 3
               'GBReference_title' => 'Direct Submission'
         'GBSeq_sequence' => 'mllllarcflvilassllvcpglacgpgrgfgkrrhpkkltplaykqfipnvaektlgasgryegkitrnserfkeltpnynpdiifkdeentgadrlmtqrckdklnalaisvmnqwpgvklrvtegwdedghhseeslhyegravdittsdrdrskygmlarlaveagfdwvyyeskahihcsvkaensvaaksggcfpgsatvhleqggtklvkdlrpgdrvlaaddqgrllysdfltfldrdegakkvfyvietleprerllltaahllfvaphndsgptpgpsalfasrvrpgqrvyvvaerggdrrllpaavhsvtlreeeagayapltahgtilinrvlascyavieehswahrafapfrlahallaalapartdgggggsipaaqsateargaeptagihwysqllyhigtwlldsetmhplgmavkss'
         'GBSeq_source' => 'Mus musculus (house mouse)'
         'GBSeq_source-db' => 'embl accession X76290.1'
         'GBSeq_taxonomy' => 'Eukaryota; Metazoa; Chordata; Craniata; Vertebrata; Euteleostomi; Mammalia; Eutheria; Euarchontoglires; Glires; Rodentia; Sciurognathi; Muroidea; Muridae; Murinae; Mus'
         'GBSeq_topology' => 'linear'
         'GBSeq_update-date' => '04-NOV-1997'

NUCLEOTIDE

0  HASH(0x42c1a44)
   'GBSet' => HASH(0x42dd728)
      'GBSeq' => HASH(0x44bc2c8)
         'GBSeq_accession-version' => 'NR_029721.1'
         'GBSeq_comment' => 'PROVISIONAL REFSEQ: This record is based on preliminary annotation provided by NCBI staff in collaboration with miRBase. The reference sequence was derived from AL645478.15.; ~Summary: microRNAs (miRNAs) are short (20-24 nt) non-coding RNAs that are involved in post-transcriptional regulation of gene expression in multicellular organisms by affecting both the stability and translation of mRNAs. miRNAs are transcribed by RNA polymerase II as part of capped and polyadenylated primary transcripts (pri-miRNAs) that can be either protein-coding or non-coding. The primary transcript is cleaved by the Drosha ribonuclease III enzyme to produce an approximately 70-nt stem-loop precursor miRNA (pre-miRNA), which is further cleaved by the cytoplasmic Dicer ribonuclease to generate the mature miRNA and antisense miRNA star (miRNA*) products. The mature miRNA is incorporated into a RNA-induced silencing complex (RISC), which recognizes target mRNAs through imperfect base pairing with the miRNA and most commonly results in translational inhibition or destabilization of the target mRNA. The RefSeq represents the predicted microRNA stem-loop. [provided by RefSeq]; ~Sequence Note: This record represents a predicted microRNA stem-loop as defined by miRBase. Some sequence at the 5\' and 3\' ends may not be included in the intermediate precursor miRNA produced by Drosha cleavage.'
         'GBSeq_create-date' => '29-OCT-2009'
         'GBSeq_definition' => 'Mus musculus microRNA 196a-1 (Mir196a-1), microRNA'
         'GBSeq_division' => 'ROD'
         'GBSeq_feature-table' => HASH(0x4579f0c)
            'GBFeature' => HASH(0x457ab6c)
               'GBFeature_intervals' => HASH(0x457fa20)
                  'GBInterval' => HASH(0x45813d0)
                     'GBInterval_accession' => 'NR_029721.1'
                     'GBInterval_from' => 24
                     'GBInterval_to' => 45
               'GBFeature_key' => 'ncRNA'
               'GBFeature_location' => '24..45'
               'GBFeature_quals' => HASH(0x45813e8)
                  'GBQualifier' => HASH(0x4581a90)
                     'GBQualifier_name' => 'db_xref'
                     'GBQualifier_value' => 'MGI:2676860'
         'GBSeq_length' => 102
         'GBSeq_locus' => 'NR_029721'
         'GBSeq_moltype' => 'ncRNA'
         'GBSeq_organism' => 'Mus musculus'
         'GBSeq_other-seqids' => HASH(0x456bea8)
            'GBSeqid' => 'gi|262205520'
         'GBSeq_primary' => 'REFSEQ_SPAN         PRIMARY_IDENTIFIER PRIMARY_SPAN        COMP~1-102               AL645478.15        79764-79865         '
         'GBSeq_primary-accession' => 'NR_029721'
         'GBSeq_references' => HASH(0x45744ac)
            'GBReference' => HASH(0x457ac20)
               'GBReference_authors' => HASH(0x457f36c)
                  'GBAuthor' => 'Tuschl,T.'
               'GBReference_journal' => 'RNA 9 (2), 175-179 (2003)'
               'GBReference_position' => '1..102'
               'GBReference_pubmed' => 12554859
               'GBReference_reference' => 9
               'GBReference_title' => 'New microRNAs from mouse and human'
         'GBSeq_sequence' => 'tgagccgggactgttgagtgaagtaggtagtttcatgttgttgggcctggctttctgaacacaacgacatcaaaccacctgattcatggcagttactgcttc'
         'GBSeq_source' => 'Mus musculus (house mouse)'
         'GBSeq_strandedness' => 'single'
         'GBSeq_taxonomy' => 'Eukaryota; Metazoa; Chordata; Craniata; Vertebrata; Euteleostomi; Mammalia; Eutheria; Euarchontoglires; Glires; Rodentia; Sciurognathi; Muroidea; Muridae; Murinae; Mus'
         'GBSeq_topology' => 'linear'
         'GBSeq_update-date' => '06-JAN-2010'
