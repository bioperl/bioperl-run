
=head1 NAME

Bio::Tools::Run::PiseApplication::dialign2

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::dialign2

      Bioperl class for:

	DIALIGN	DNA and protein sequence alignment based on segment-to-segment comparison (Morgenstern, Dress, Werner)

	References:

		B. Morgenstern (1999). DIALIGN 2: improvement of the segment-to-segment approach to multiple sequence alignment. Bioinformatics 15, 211 - 218.


      Parameters:


		dialign2 (String)


		sequence (Sequence)
			Sequences
			pipe: seqsfile

		protein_dna (Excl)
			Nucleic acid or protein alignment

		dialign_opt (Paragraph)
			Others options

		threshold (Float)
			Threshold

		translation (Switch)
			Translation of nucleotide diagonals into peptide diagonals (DNA)

		max_simil (Integer)
			Maximum number of * characters representing degree similarity

		output_options (Paragraph)
			Output options

		fasta (Switch)
			Alignment in fasta format

		ali (Results)


=cut

#'
package Bio::Tools::Run::PiseApplication::dialign2;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $dialign2 = Bio::Tools::Run::PiseApplication::dialign2->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::dialign2 object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $dialign2 = $factory->program('dialign2');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::dialign2.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dialign2.pm

    $self->{COMMAND}   = "dialign2";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "DIALIGN";

    $self->{DESCRIPTION}   = "DNA and protein sequence alignment based on segment-to-segment comparison";

    $self->{CATEGORIES}   =  [  

         "alignment:multiple",
  ];

    $self->{AUTHORS}   = "Morgenstern, Dress, Werner";

    $self->{REFERENCE}   = [

         "B. Morgenstern (1999). DIALIGN 2: improvement of the segment-to-segment approach to multiple sequence alignment. Bioinformatics 15, 211 - 218.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"dialign2",
	"sequence",
	"protein_dna",
	"dialign_opt",
	"output_options",
	"ali",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"dialign2",
	"sequence", 	# Sequences
	"protein_dna", 	# Nucleic acid or protein alignment
	"dialign_opt", 	# Others options
	"threshold", 	# Threshold
	"translation", 	# Translation of nucleotide diagonals into peptide diagonals (DNA)
	"max_simil", 	# Maximum number of * characters representing degree similarity
	"output_options", 	# Output options
	"fasta", 	# Alignment in fasta format
	"ali",

    ];

    $self->{TYPE}  = {
	"dialign2" => 'String',
	"sequence" => 'Sequence',
	"protein_dna" => 'Excl',
	"dialign_opt" => 'Paragraph',
	"threshold" => 'Float',
	"translation" => 'Switch',
	"max_simil" => 'Integer',
	"output_options" => 'Paragraph',
	"fasta" => 'Switch',
	"ali" => 'Results',

    };

    $self->{FORMAT}  = {
	"dialign2" => {
		"seqlab" => 'dialign2',
		"perl" => '"dialign2"',
	},
	"sequence" => {
		"perl" => '" $value" ',
	},
	"protein_dna" => {
		"perl" => '($value eq "n")? " -n" : "" ',
	},
	"dialign_opt" => {
	},
	"threshold" => {
		"perl" => '(defined $value && $value != $vdef)? " -thr $value" : "" ',
	},
	"translation" => {
		"perl" => '($protein_dna eq "n" && $value)? "t" : "" ',
	},
	"max_simil" => {
		"perl" => '($value && $value != $vdef)? " -pln $value" : "" ',
	},
	"output_options" => {
	},
	"fasta" => {
		"perl" => '($value)? " -fa" : "" ',
	},
	"ali" => {
	},

    };

    $self->{FILENAMES}  = {
	"ali" => '*.ali *.fa',

    };

    $self->{SEQFMT}  = {
	"sequence" => [1,8,4],

    };

    $self->{GROUP}  = {
	"dialign2" => 0,
	"sequence" => 100,
	"protein_dna" => 3,
	"dialign_opt" => 7,
	"threshold" => 7,
	"translation" => 4,
	"max_simil" => 7,
	"output_options" => 7,
	"fasta" => 7,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"dialign2",
	"ali",
	"protein_dna",
	"translation",
	"threshold",
	"dialign_opt",
	"max_simil",
	"output_options",
	"fasta",
	"sequence",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"dialign2" => 1,
	"sequence" => 0,
	"protein_dna" => 0,
	"dialign_opt" => 0,
	"threshold" => 0,
	"translation" => 0,
	"max_simil" => 0,
	"output_options" => 0,
	"fasta" => 0,
	"ali" => 0,

    };

    $self->{ISCOMMAND}  = {
	"dialign2" => 1,
	"sequence" => 0,
	"protein_dna" => 0,
	"dialign_opt" => 0,
	"threshold" => 0,
	"translation" => 0,
	"max_simil" => 0,
	"output_options" => 0,
	"fasta" => 0,
	"ali" => 0,

    };

    $self->{ISMANDATORY}  = {
	"dialign2" => 0,
	"sequence" => 1,
	"protein_dna" => 1,
	"dialign_opt" => 0,
	"threshold" => 0,
	"translation" => 0,
	"max_simil" => 0,
	"output_options" => 0,
	"fasta" => 0,
	"ali" => 0,

    };

    $self->{PROMPT}  = {
	"dialign2" => "",
	"sequence" => "Sequences",
	"protein_dna" => "Nucleic acid or protein alignment",
	"dialign_opt" => "Others options",
	"threshold" => "Threshold",
	"translation" => "Translation of nucleotide diagonals into peptide diagonals (DNA)",
	"max_simil" => "Maximum number of * characters representing degree similarity",
	"output_options" => "Output options",
	"fasta" => "Alignment in fasta format",
	"ali" => "",

    };

    $self->{ISSTANDOUT}  = {
	"dialign2" => 0,
	"sequence" => 0,
	"protein_dna" => 0,
	"dialign_opt" => 0,
	"threshold" => 0,
	"translation" => 0,
	"max_simil" => 0,
	"output_options" => 0,
	"fasta" => 0,
	"ali" => 0,

    };

    $self->{VLIST}  = {

	"protein_dna" => ['p','p: protein','n','n: nucleic',],
	"dialign_opt" => ['threshold','translation','max_simil',],
	"output_options" => ['fasta',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"protein_dna" => 'p',
	"threshold" => '0.0',
	"translation" => '0',
	"max_simil" => '5',
	"fasta" => '0',

    };

    $self->{PRECOND}  = {
	"dialign2" => { "perl" => '1' },
	"sequence" => { "perl" => '1' },
	"protein_dna" => { "perl" => '1' },
	"dialign_opt" => { "perl" => '1' },
	"threshold" => { "perl" => '1' },
	"translation" => { "perl" => '1' },
	"max_simil" => { "perl" => '1' },
	"output_options" => { "perl" => '1' },
	"fasta" => { "perl" => '1' },
	"ali" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"sequence" => {
		 "seqsfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"dialign2" => 0,
	"sequence" => 0,
	"protein_dna" => 0,
	"dialign_opt" => 0,
	"threshold" => 0,
	"translation" => 0,
	"max_simil" => 0,
	"output_options" => 0,
	"fasta" => 0,
	"ali" => 0,

    };

    $self->{ISSIMPLE}  = {
	"dialign2" => 1,
	"sequence" => 1,
	"protein_dna" => 1,
	"dialign_opt" => 0,
	"threshold" => 0,
	"translation" => 0,
	"max_simil" => 0,
	"output_options" => 0,
	"fasta" => 0,
	"ali" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"sequence" => [
		"Give here the sequences you want to align (you can give more than 2 sequences). The FASTA format is accepted - example:",
		">name1",
		"TACTTTACCCAGTAGTCATGTACAGAGT",
		"ACCGCCTCAATAAAAAGCCTAAGAGTCA",
		">name2",
		"CCCATATGTGTAGAAGTTGCCTCGAGTG",
		"TTTACGCGGGGGCGGGCATTCTTTAAAC",
		"CACGCGGGGGATATTGCGAAACACCCAT",
		"GAGAGAGGGGGGAATGCCCCGTA",
		">name3",
		"ACCTACTCTCCCCCCCCTTTTCCCAACT",
		"ATCTAATCTATTTYCAGGGCGTGGACGG",
		"GGGGG",
	],
	"max_simil" => [
		"The number of `*\' characters below the alignment reflects the degree of local similarity among sequences. More precisely: They represent the sum of `weights\' of diagonals connecting residues at the respective position.",
		"The number of `*\' characters is normalized such that regions of maximum similarity have N `*\' characters per column. N can be specified by the user. By default, N = 5. Note that the number of `*\' characters depicts therelative degree of similarity within an alignment, since in every alignment, the region of maximum similarity gets N `*\' characters.",
	],
	"fasta" => [
		"Be aware that only upper-case letters are regarded to be aligned in fasta output file.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/dialign2.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

