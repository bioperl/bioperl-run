
=head1 NAME

Bio::Tools::Run::PiseApplication::wise2

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::wise2

      Bioperl class for:

	WISE2	comparisons of protein/DNA sequences (E. Birney)

      Parameters:


		wise2 (Excl)
			Wise program

		protein (Sequence)
			Protein sequence File (if no HMM, see help)

		dna (Sequence)
			DNA sequence File

		quiet (String)
			

		dna_options (Paragraph)
			DNA sequence Options

		dna_start (Integer)
			Start position in dna (-u)

		dna_end (Integer)
			End position in dna (-v)

		strand (Excl)
			Strand comparison

		tabs (Switch)
			Report positions as absolute to truncated/reverse sequence (-tabs)

		protein_options (Paragraph)
			Protein comparison Options

		protein_start (Integer)
			Start position in protein (-s)

		protein_end (Integer)
			End position in protein (-t)

		gap (Integer)
			Gap penalty (-g)

		ext (Integer)
			Gap extension penalty (-e)

		HMM_options (Paragraph)
			HMM Options

		hmmer (InFile)
			HMMer file (instead of protein) (-hmmer)
			pipe: hmmfile

		hname (String)
			Name of HMM rather than using the filename (-hname)

		gene_model_options (Paragraph)
			Gene Model Options

		init (Excl)
			Type of match (-init)

		subs (Float)
			Substitution error rate (-subs)

		indel (Float)
			Insertion/deletion error rate (-indel)

		cfreq (Excl)
			Using codon bias or not (-cfreq)

		splice (Excl)
			Using splice model or GT/AG (-splice)

		intron (Excl)
			Use tied model for introns (-intron)

		null (Excl)
			Random Model as synchronous or flat (-null)

		alln (Float)
			Probability of matching a NNN codon (-alln)

		insert (Excl)
			Protein insert model (-insert)

		output_options (Paragraph)
			Output Options

		pretty (Switch)
			Show pretty ascii output (-pretty)

		pseudo (Switch)
			Mark genes with frameshifts as pseudogenes (-pseudo)

		genes (Switch)
			Show gene structure (-genes)

		embl (Switch)
			show EMBL feature format with CDS key (-embl)

		diana (Switch)
			show EMBL feature format with misc_feature key for diana (-diana)

		para (Switch)
			Show parameters (-para)

		sum (Switch)
			Show summary output (-sum)

		cdna (Switch)
			Show cDNA (-cdna)

		trans (Switch)
			Show protein translation (-trans)

		ace (Switch)
			Ace file gene structure (-ace)

		gff (Switch)
			Gene Feature Format file (-gff)

		gener (Switch)
			Raw gene structure (-gener)

		alb (Switch)
			Show logical AlnBlock alignment (-alb)

		pal (Switch)
			Show raw matrix alignment (-pal)

		block (Integer)
			Length of main block in pretty output (-block)

		divide (String)
			divide string for multiple outputs (-divide)

		standard_options (Paragraph)
			Standard Options

		erroroffstd (Switch)
			No warning messages (-erroroffstd)

=cut

#'
package Bio::Tools::Run::PiseApplication::wise2;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $wise2 = Bio::Tools::Run::PiseApplication::wise2->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::wise2 object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $wise2 = $factory->program('wise2');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::wise2.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/wise2.pm

    $self->{COMMAND}   = "wise2";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "WISE2";

    $self->{DESCRIPTION}   = "comparisons of protein/DNA sequences";

    $self->{AUTHORS}   = "E. Birney";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"wise2",
	"protein",
	"dna",
	"quiet",
	"dna_options",
	"protein_options",
	"HMM_options",
	"gene_model_options",
	"output_options",
	"standard_options",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"wise2", 	# Wise program
	"protein", 	# Protein sequence File (if no HMM, see help)
	"dna", 	# DNA sequence File
	"quiet",
	"dna_options", 	# DNA sequence Options
	"dna_start", 	# Start position in dna (-u)
	"dna_end", 	# End position in dna (-v)
	"strand", 	# Strand comparison
	"tabs", 	# Report positions as absolute to truncated/reverse sequence (-tabs)
	"protein_options", 	# Protein comparison Options
	"protein_start", 	# Start position in protein (-s)
	"protein_end", 	# End position in protein (-t)
	"gap", 	# Gap penalty (-g)
	"ext", 	# Gap extension penalty (-e)
	"HMM_options", 	# HMM Options
	"hmmer", 	# HMMer file (instead of protein) (-hmmer)
	"hname", 	# Name of HMM rather than using the filename (-hname)
	"gene_model_options", 	# Gene Model Options
	"init", 	# Type of match (-init)
	"subs", 	# Substitution error rate (-subs)
	"indel", 	# Insertion/deletion error rate (-indel)
	"cfreq", 	# Using codon bias or not (-cfreq)
	"splice", 	# Using splice model or GT/AG (-splice)
	"intron", 	# Use tied model for introns (-intron)
	"null", 	# Random Model as synchronous or flat (-null)
	"alln", 	# Probability of matching a NNN codon (-alln)
	"insert", 	# Protein insert model (-insert)
	"output_options", 	# Output Options
	"pretty", 	# Show pretty ascii output (-pretty)
	"pseudo", 	# Mark genes with frameshifts as pseudogenes (-pseudo)
	"genes", 	# Show gene structure (-genes)
	"embl", 	# show EMBL feature format with CDS key (-embl)
	"diana", 	# show EMBL feature format with misc_feature key for diana (-diana)
	"para", 	# Show parameters (-para)
	"sum", 	# Show summary output (-sum)
	"cdna", 	# Show cDNA (-cdna)
	"trans", 	# Show protein translation (-trans)
	"ace", 	# Ace file gene structure (-ace)
	"gff", 	# Gene Feature Format file (-gff)
	"gener", 	# Raw gene structure (-gener)
	"alb", 	# Show logical AlnBlock alignment (-alb)
	"pal", 	# Show raw matrix alignment (-pal)
	"block", 	# Length of main block in pretty output (-block)
	"divide", 	# divide string for multiple outputs (-divide)
	"standard_options", 	# Standard Options
	"erroroffstd", 	# No warning messages (-erroroffstd)

    ];

    $self->{TYPE}  = {
	"wise2" => 'Excl',
	"protein" => 'Sequence',
	"dna" => 'Sequence',
	"quiet" => 'String',
	"dna_options" => 'Paragraph',
	"dna_start" => 'Integer',
	"dna_end" => 'Integer',
	"strand" => 'Excl',
	"tabs" => 'Switch',
	"protein_options" => 'Paragraph',
	"protein_start" => 'Integer',
	"protein_end" => 'Integer',
	"gap" => 'Integer',
	"ext" => 'Integer',
	"HMM_options" => 'Paragraph',
	"hmmer" => 'InFile',
	"hname" => 'String',
	"gene_model_options" => 'Paragraph',
	"init" => 'Excl',
	"subs" => 'Float',
	"indel" => 'Float',
	"cfreq" => 'Excl',
	"splice" => 'Excl',
	"intron" => 'Excl',
	"null" => 'Excl',
	"alln" => 'Float',
	"insert" => 'Excl',
	"output_options" => 'Paragraph',
	"pretty" => 'Switch',
	"pseudo" => 'Switch',
	"genes" => 'Switch',
	"embl" => 'Switch',
	"diana" => 'Switch',
	"para" => 'Switch',
	"sum" => 'Switch',
	"cdna" => 'Switch',
	"trans" => 'Switch',
	"ace" => 'Switch',
	"gff" => 'Switch',
	"gener" => 'Switch',
	"alb" => 'Switch',
	"pal" => 'Switch',
	"block" => 'Integer',
	"divide" => 'String',
	"standard_options" => 'Paragraph',
	"erroroffstd" => 'Switch',

    };

    $self->{FORMAT}  = {
	"wise2" => {
		"perl" => '"$value"',
	},
	"protein" => {
		"perl" => '($hmmer) ? " $hmmer" : " $protein"',
	},
	"dna" => {
		"perl" => '" $value" ',
	},
	"quiet" => {
		"perl" => '" -silent -quiet" ',
	},
	"dna_options" => {
	},
	"dna_start" => {
		"perl" => '(defined $value) ? " -u $value" : ""',
	},
	"dna_end" => {
		"perl" => '(defined $value) ? " -v $value" : ""',
	},
	"strand" => {
		"perl" => '($value) ? " $value" : ""',
	},
	"tabs" => {
		"perl" => '($value) ? " -tabs" : ""',
	},
	"protein_options" => {
	},
	"protein_start" => {
		"perl" => '(defined $value) ? " -s $value" : ""',
	},
	"protein_end" => {
		"perl" => '(defined $value) ? " -t $value" : ""',
	},
	"gap" => {
		"perl" => '(defined $value && $value != $vdef) ? " -g $value" : ""',
	},
	"ext" => {
		"perl" => '(defined $value && $value != $vdef) ? " -e $value" : ""',
	},
	"HMM_options" => {
	},
	"hmmer" => {
		"perl" => '($value) ? " -hmmer" : ""',
	},
	"hname" => {
		"perl" => '($value) ? " -hname \"$value\"" : ""',
	},
	"gene_model_options" => {
	},
	"init" => {
		"perl" => '($value && $value ne $vdef) ? " -init $value" : ""',
	},
	"subs" => {
		"perl" => '(defined $value && $value != $vdef) ? " -subs $value" : ""',
	},
	"indel" => {
		"perl" => '(defined $value && $value != $vdef) ? " -indel $value" : ""',
	},
	"cfreq" => {
		"perl" => '($value && $value ne $vdef) ? " -cfreq $value" : ""',
	},
	"splice" => {
		"perl" => '($value && $value ne $vdef) ? " -splice $value" : ""',
	},
	"intron" => {
		"perl" => '($value && $value ne $vdef) ? " -intron $value" : ""',
	},
	"null" => {
		"perl" => '($value && $value ne $vdef) ? " -null $value" : ""',
	},
	"alln" => {
		"perl" => '($value && $value != $vdef) ? " -alln $value" : ""',
	},
	"insert" => {
		"perl" => '($value && $value ne $vdef) ? " -insert $value" : ""',
	},
	"output_options" => {
	},
	"pretty" => {
		"perl" => '($value) ? " -pretty" : ""',
	},
	"pseudo" => {
		"perl" => '($value) ? " -pseudo" : ""',
	},
	"genes" => {
		"perl" => '($value) ? " -genes" : ""',
	},
	"embl" => {
		"perl" => '($value) ? " -embl" : ""',
	},
	"diana" => {
		"perl" => '($value) ? " -diana" : ""',
	},
	"para" => {
		"perl" => '($value) ? " -para" : ""',
	},
	"sum" => {
		"perl" => '($value) ? " -sum" : ""',
	},
	"cdna" => {
		"perl" => '($value) ? " -cdna" : ""',
	},
	"trans" => {
		"perl" => '($value) ? " -trans" : ""',
	},
	"ace" => {
		"perl" => '($value) ? " -ace" : ""',
	},
	"gff" => {
		"perl" => '($value) ? " -gff" : ""',
	},
	"gener" => {
		"perl" => '($value) ? " -gener" : ""',
	},
	"alb" => {
		"perl" => '($value) ? " -alb" : ""',
	},
	"pal" => {
		"perl" => '($value) ? " -pal" : ""',
	},
	"block" => {
		"perl" => '($value && $value != $vdef) ? " -block $value" : ""',
	},
	"divide" => {
		"perl" => '($value) ? " -divide \"$value\"" : ""',
	},
	"standard_options" => {
	},
	"erroroffstd" => {
		"perl" => '($value) ? " -erroroffstd" : ""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"protein" => [8],
	"dna" => [8],

    };

    $self->{GROUP}  = {
	"wise2" => 1,
	"protein" => 2,
	"dna" => 3,
	"quiet" => 100,
	"dna_options" => 5,
	"dna_start" => 5,
	"dna_end" => 5,
	"strand" => 5,
	"tabs" => 5,
	"protein_options" => 6,
	"protein_start" => 6,
	"protein_end" => 6,
	"gap" => 6,
	"ext" => 6,
	"HMM_options" => 7,
	"hmmer" => 7,
	"hname" => 7,
	"gene_model_options" => 8,
	"init" => 8,
	"subs" => 8,
	"indel" => 8,
	"cfreq" => 8,
	"splice" => 8,
	"intron" => 8,
	"null" => 8,
	"alln" => 8,
	"insert" => 8,
	"output_options" => 10,
	"pretty" => 10,
	"pseudo" => 10,
	"genes" => 10,
	"embl" => 10,
	"diana" => 10,
	"para" => 10,
	"sum" => 10,
	"cdna" => 10,
	"trans" => 10,
	"ace" => 10,
	"gff" => 10,
	"gener" => 10,
	"alb" => 10,
	"pal" => 10,
	"block" => 10,
	"divide" => 10,
	"standard_options" => 11,
	"erroroffstd" => 11,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"wise2",
	"protein",
	"dna",
	"tabs",
	"dna_options",
	"dna_start",
	"dna_end",
	"strand",
	"protein_options",
	"protein_start",
	"protein_end",
	"gap",
	"ext",
	"hname",
	"HMM_options",
	"hmmer",
	"insert",
	"gene_model_options",
	"init",
	"subs",
	"indel",
	"cfreq",
	"splice",
	"intron",
	"null",
	"alln",
	"divide",
	"output_options",
	"pretty",
	"pseudo",
	"genes",
	"embl",
	"diana",
	"para",
	"sum",
	"cdna",
	"trans",
	"ace",
	"gff",
	"gener",
	"alb",
	"pal",
	"block",
	"standard_options",
	"erroroffstd",
	"quiet",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"wise2" => 0,
	"protein" => 0,
	"dna" => 0,
	"quiet" => 1,
	"dna_options" => 0,
	"dna_start" => 0,
	"dna_end" => 0,
	"strand" => 0,
	"tabs" => 0,
	"protein_options" => 0,
	"protein_start" => 0,
	"protein_end" => 0,
	"gap" => 0,
	"ext" => 0,
	"HMM_options" => 0,
	"hmmer" => 0,
	"hname" => 0,
	"gene_model_options" => 0,
	"init" => 0,
	"subs" => 0,
	"indel" => 0,
	"cfreq" => 0,
	"splice" => 0,
	"intron" => 0,
	"null" => 0,
	"alln" => 0,
	"insert" => 0,
	"output_options" => 0,
	"pretty" => 0,
	"pseudo" => 0,
	"genes" => 0,
	"embl" => 0,
	"diana" => 0,
	"para" => 0,
	"sum" => 0,
	"cdna" => 0,
	"trans" => 0,
	"ace" => 0,
	"gff" => 0,
	"gener" => 0,
	"alb" => 0,
	"pal" => 0,
	"block" => 0,
	"divide" => 0,
	"standard_options" => 0,
	"erroroffstd" => 0,

    };

    $self->{ISCOMMAND}  = {
	"wise2" => 1,
	"protein" => 0,
	"dna" => 0,
	"quiet" => 0,
	"dna_options" => 0,
	"dna_start" => 0,
	"dna_end" => 0,
	"strand" => 0,
	"tabs" => 0,
	"protein_options" => 0,
	"protein_start" => 0,
	"protein_end" => 0,
	"gap" => 0,
	"ext" => 0,
	"HMM_options" => 0,
	"hmmer" => 0,
	"hname" => 0,
	"gene_model_options" => 0,
	"init" => 0,
	"subs" => 0,
	"indel" => 0,
	"cfreq" => 0,
	"splice" => 0,
	"intron" => 0,
	"null" => 0,
	"alln" => 0,
	"insert" => 0,
	"output_options" => 0,
	"pretty" => 0,
	"pseudo" => 0,
	"genes" => 0,
	"embl" => 0,
	"diana" => 0,
	"para" => 0,
	"sum" => 0,
	"cdna" => 0,
	"trans" => 0,
	"ace" => 0,
	"gff" => 0,
	"gener" => 0,
	"alb" => 0,
	"pal" => 0,
	"block" => 0,
	"divide" => 0,
	"standard_options" => 0,
	"erroroffstd" => 0,

    };

    $self->{ISMANDATORY}  = {
	"wise2" => 1,
	"protein" => 0,
	"dna" => 1,
	"quiet" => 0,
	"dna_options" => 0,
	"dna_start" => 0,
	"dna_end" => 0,
	"strand" => 0,
	"tabs" => 0,
	"protein_options" => 0,
	"protein_start" => 0,
	"protein_end" => 0,
	"gap" => 0,
	"ext" => 0,
	"HMM_options" => 0,
	"hmmer" => 0,
	"hname" => 0,
	"gene_model_options" => 0,
	"init" => 0,
	"subs" => 0,
	"indel" => 0,
	"cfreq" => 0,
	"splice" => 0,
	"intron" => 0,
	"null" => 0,
	"alln" => 0,
	"insert" => 0,
	"output_options" => 0,
	"pretty" => 0,
	"pseudo" => 0,
	"genes" => 0,
	"embl" => 0,
	"diana" => 0,
	"para" => 0,
	"sum" => 0,
	"cdna" => 0,
	"trans" => 0,
	"ace" => 0,
	"gff" => 0,
	"gener" => 0,
	"alb" => 0,
	"pal" => 0,
	"block" => 0,
	"divide" => 0,
	"standard_options" => 0,
	"erroroffstd" => 0,

    };

    $self->{PROMPT}  = {
	"wise2" => "Wise program",
	"protein" => "Protein sequence File (if no HMM, see help)",
	"dna" => "DNA sequence File",
	"quiet" => "",
	"dna_options" => "DNA sequence Options",
	"dna_start" => "Start position in dna (-u)",
	"dna_end" => "End position in dna (-v)",
	"strand" => "Strand comparison",
	"tabs" => "Report positions as absolute to truncated/reverse sequence (-tabs)",
	"protein_options" => "Protein comparison Options",
	"protein_start" => "Start position in protein (-s)",
	"protein_end" => "End position in protein (-t)",
	"gap" => "Gap penalty (-g)",
	"ext" => "Gap extension penalty (-e)",
	"HMM_options" => "HMM Options",
	"hmmer" => "HMMer file (instead of protein) (-hmmer)",
	"hname" => "Name of HMM rather than using the filename (-hname)",
	"gene_model_options" => "Gene Model Options",
	"init" => "Type of match (-init)",
	"subs" => "Substitution error rate (-subs)",
	"indel" => "Insertion/deletion error rate (-indel)",
	"cfreq" => "Using codon bias or not (-cfreq)",
	"splice" => "Using splice model or GT/AG (-splice)",
	"intron" => "Use tied model for introns (-intron)",
	"null" => "Random Model as synchronous or flat (-null)",
	"alln" => "Probability of matching a NNN codon (-alln)",
	"insert" => "Protein insert model (-insert)",
	"output_options" => "Output Options",
	"pretty" => "Show pretty ascii output (-pretty)",
	"pseudo" => "Mark genes with frameshifts as pseudogenes (-pseudo)",
	"genes" => "Show gene structure (-genes)",
	"embl" => "show EMBL feature format with CDS key (-embl)",
	"diana" => "show EMBL feature format with misc_feature key for diana (-diana)",
	"para" => "Show parameters (-para)",
	"sum" => "Show summary output (-sum)",
	"cdna" => "Show cDNA (-cdna)",
	"trans" => "Show protein translation (-trans)",
	"ace" => "Ace file gene structure (-ace)",
	"gff" => "Gene Feature Format file (-gff)",
	"gener" => "Raw gene structure (-gener)",
	"alb" => "Show logical AlnBlock alignment (-alb)",
	"pal" => "Show raw matrix alignment (-pal)",
	"block" => "Length of main block in pretty output (-block)",
	"divide" => "divide string for multiple outputs (-divide)",
	"standard_options" => "Standard Options",
	"erroroffstd" => "No warning messages (-erroroffstd)",

    };

    $self->{ISSTANDOUT}  = {
	"wise2" => 0,
	"protein" => 0,
	"dna" => 0,
	"quiet" => 0,
	"dna_options" => 0,
	"dna_start" => 0,
	"dna_end" => 0,
	"strand" => 0,
	"tabs" => 0,
	"protein_options" => 0,
	"protein_start" => 0,
	"protein_end" => 0,
	"gap" => 0,
	"ext" => 0,
	"HMM_options" => 0,
	"hmmer" => 0,
	"hname" => 0,
	"gene_model_options" => 0,
	"init" => 0,
	"subs" => 0,
	"indel" => 0,
	"cfreq" => 0,
	"splice" => 0,
	"intron" => 0,
	"null" => 0,
	"alln" => 0,
	"insert" => 0,
	"output_options" => 0,
	"pretty" => 0,
	"pseudo" => 0,
	"genes" => 0,
	"embl" => 0,
	"diana" => 0,
	"para" => 0,
	"sum" => 0,
	"cdna" => 0,
	"trans" => 0,
	"ace" => 0,
	"gff" => 0,
	"gener" => 0,
	"alb" => 0,
	"pal" => 0,
	"block" => 0,
	"divide" => 0,
	"standard_options" => 0,
	"erroroffstd" => 0,

    };

    $self->{VLIST}  = {

	"wise2" => ['genewise','genewise: protein to genomic DNA.','estwise','estwise: protein to cDNA',],
	"dna_options" => ['dna_start','dna_end','strand','tabs',],
	"strand" => ['-tfor','forward (-tfor)','-trev','reverse (-trev)','-both','both (-both)',],
	"protein_options" => ['protein_start','protein_end','gap','ext',],
	"HMM_options" => ['hmmer','hname',],
	"gene_model_options" => ['init','subs','indel','cfreq','splice','intron','null','alln','insert',],
	"init" => ['default','default','global','global','local','local','wing','wing',],
	"cfreq" => ['model','model','flat','flat',],
	"splice" => ['model','model','flat','flat',],
	"intron" => ['model','model','tied','tied',],
	"null" => ['syn','synchronous','flat','flat',],
	"insert" => ['model','model','flat','flat',],
	"output_options" => ['pretty','pseudo','genes','embl','diana','para','sum','cdna','trans','ace','gff','gener','alb','pal','block','divide',],
	"standard_options" => ['erroroffstd',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"gap" => '12',
	"ext" => '2',
	"init" => 'default',
	"subs" => '1e-5',
	"indel" => '1e-5',
	"cfreq" => 'flat',
	"splice" => 'model',
	"intron" => 'tied',
	"null" => 'syn',
	"alln" => '1.0',
	"insert" => 'flat',
	"pretty" => '1',
	"pseudo" => '0',
	"genes" => '0',
	"embl" => '0',
	"diana" => '0',
	"para" => '1',
	"sum" => '0',
	"cdna" => '0',
	"trans" => '0',
	"ace" => '0',
	"gff" => '0',
	"gener" => '0',
	"alb" => '0',
	"pal" => '0',
	"block" => '50',
	"erroroffstd" => '0',

    };

    $self->{PRECOND}  = {
	"wise2" => { "perl" => '1' },
	"protein" => { "perl" => '1' },
	"dna" => { "perl" => '1' },
	"quiet" => { "perl" => '1' },
	"dna_options" => { "perl" => '1' },
	"dna_start" => { "perl" => '1' },
	"dna_end" => { "perl" => '1' },
	"strand" => { "perl" => '1' },
	"tabs" => { "perl" => '1' },
	"protein_options" => {
		"perl" => '! $hmmer',
	},
	"protein_start" => {
		"perl" => '! $hmmer',
	},
	"protein_end" => {
		"perl" => '! $hmmer',
	},
	"gap" => {
		"perl" => '! $hmmer',
	},
	"ext" => {
		"perl" => '! $hmmer',
	},
	"HMM_options" => { "perl" => '1' },
	"hmmer" => { "perl" => '1' },
	"hname" => { "perl" => '1' },
	"gene_model_options" => { "perl" => '1' },
	"init" => { "perl" => '1' },
	"subs" => { "perl" => '1' },
	"indel" => { "perl" => '1' },
	"cfreq" => {
		"perl" => '$wise eq "genewise"',
	},
	"splice" => {
		"perl" => '$wise2 eq "genewise"',
	},
	"intron" => {
		"perl" => '$wise2 eq "genewise"',
	},
	"null" => { "perl" => '1' },
	"alln" => { "perl" => '1' },
	"insert" => {
		"perl" => '$wise2 eq "genewise"',
	},
	"output_options" => { "perl" => '1' },
	"pretty" => { "perl" => '1' },
	"pseudo" => {
		"perl" => '$wise2 eq "genewise"',
	},
	"genes" => {
		"perl" => '$wise2 eq "genewise"',
	},
	"embl" => {
		"perl" => '$wise2 eq "genewise"',
	},
	"diana" => {
		"perl" => '$wise2 eq "genewise"',
	},
	"para" => { "perl" => '1' },
	"sum" => { "perl" => '1' },
	"cdna" => {
		"perl" => '$wise2 eq "genewise"',
	},
	"trans" => {
		"perl" => '$wise2 eq "genewise"',
	},
	"ace" => {
		"perl" => '$wise2 eq "genewise"',
	},
	"gff" => {
		"perl" => '$wise2 eq "genewise"',
	},
	"gener" => {
		"perl" => '$wise2 eq "genewise"',
	},
	"alb" => { "perl" => '1' },
	"pal" => { "perl" => '1' },
	"block" => { "perl" => '1' },
	"divide" => { "perl" => '1' },
	"standard_options" => { "perl" => '1' },
	"erroroffstd" => { "perl" => '1' },

    };

    $self->{CTRL}  = {
	"protein" => {
		"perl" => {
			'!($hmmer || $protein)' => "You must either give a protein sequence file or an HMMER file",
		},
	},

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"hmmer" => {
		 "hmmfile" => '$hmmer',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"wise2" => 0,
	"protein" => 0,
	"dna" => 0,
	"quiet" => 0,
	"dna_options" => 0,
	"dna_start" => 0,
	"dna_end" => 0,
	"strand" => 0,
	"tabs" => 0,
	"protein_options" => 0,
	"protein_start" => 0,
	"protein_end" => 0,
	"gap" => 0,
	"ext" => 0,
	"HMM_options" => 0,
	"hmmer" => 0,
	"hname" => 0,
	"gene_model_options" => 0,
	"init" => 0,
	"subs" => 0,
	"indel" => 0,
	"cfreq" => 0,
	"splice" => 0,
	"intron" => 0,
	"null" => 0,
	"alln" => 0,
	"insert" => 0,
	"output_options" => 0,
	"pretty" => 0,
	"pseudo" => 0,
	"genes" => 0,
	"embl" => 0,
	"diana" => 0,
	"para" => 0,
	"sum" => 0,
	"cdna" => 0,
	"trans" => 0,
	"ace" => 0,
	"gff" => 0,
	"gener" => 0,
	"alb" => 0,
	"pal" => 0,
	"block" => 0,
	"divide" => 0,
	"standard_options" => 0,
	"erroroffstd" => 0,

    };

    $self->{ISSIMPLE}  = {
	"wise2" => 1,
	"protein" => 1,
	"dna" => 1,
	"quiet" => 0,
	"dna_options" => 0,
	"dna_start" => 0,
	"dna_end" => 0,
	"strand" => 0,
	"tabs" => 0,
	"protein_options" => 0,
	"protein_start" => 0,
	"protein_end" => 0,
	"gap" => 0,
	"ext" => 0,
	"HMM_options" => 0,
	"hmmer" => 0,
	"hname" => 0,
	"gene_model_options" => 0,
	"init" => 0,
	"subs" => 0,
	"indel" => 0,
	"cfreq" => 0,
	"splice" => 0,
	"intron" => 0,
	"null" => 0,
	"alln" => 0,
	"insert" => 0,
	"output_options" => 0,
	"pretty" => 0,
	"pseudo" => 0,
	"genes" => 0,
	"embl" => 0,
	"diana" => 0,
	"para" => 0,
	"sum" => 0,
	"cdna" => 0,
	"trans" => 0,
	"ace" => 0,
	"gff" => 0,
	"gener" => 0,
	"alb" => 0,
	"pal" => 0,
	"block" => 0,
	"divide" => 0,
	"standard_options" => 0,
	"erroroffstd" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"protein" => [
		"You can either give a protein sequence file or an HMMER file (See HMM Options).",
	],

    };

    $self->{SCALEMIN}  = {

    };

    $self->{SCALEMAX}  = {

    };

    $self->{SCALEINC}  = {

    };

    $self->{INFO}  = {

    };

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/wise2.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

