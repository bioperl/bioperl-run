
=head1 NAME

Bio::Tools::Run::PiseApplication::nnssp

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::nnssp

      Bioperl class for:

	NNSSP	Prediction of protein secondary structure by combining nearest-neighbor algorithms and multiple sequence alignment (Salamov & Solovyev)

	References:

		Salamov AA, Solovyev VV (1995) Prediction of protein secondary structure by combinin nearest-neighbr algorithms and multiple sequence alignment. J Mol Biol, 247 : 11-15


      Parameters:


		nnssp (String)


		infile (Sequence)
			Clustalw Alignment File
			pipe: readseq_ok_alig

		seq (String)
			Name of the sequence to analyze

		nnsspfile (Results)


		outfile (OutFile)
			Output File

=cut

#'
package Bio::Tools::Run::PiseApplication::nnssp;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $nnssp = Bio::Tools::Run::PiseApplication::nnssp->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::nnssp object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $nnssp = $factory->program('nnssp');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::nnssp.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/nnssp.pm

    $self->{COMMAND}   = "nnssp";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "NNSSP";

    $self->{DESCRIPTION}   = "Prediction of protein secondary structure by combining nearest-neighbor algorithms and multiple sequence alignment";

    $self->{AUTHORS}   = "Salamov & Solovyev";

    $self->{REFERENCE}   = [

         "Salamov AA, Solovyev VV (1995) Prediction of protein secondary structure by combinin nearest-neighbr algorithms and multiple sequence alignment. J Mol Biol, 247 : 11-15",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"nnssp",
	"infile",
	"seq",
	"nnsspfile",
	"outfile",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"nnssp",
	"infile", 	# Clustalw Alignment File
	"seq", 	# Name of the sequence to analyze
	"nnsspfile",
	"outfile", 	# Output File

    ];

    $self->{TYPE}  = {
	"nnssp" => 'String',
	"infile" => 'Sequence',
	"seq" => 'String',
	"nnsspfile" => 'Results',
	"outfile" => 'OutFile',

    };

    $self->{FORMAT}  = {
	"nnssp" => {
		"perl" => ' "clu2nnssp -I$infile -O$infile.nns -S$seq; nnssp $infile.nns" ',
	},
	"infile" => {
		"perl" => '""',
	},
	"seq" => {
		"perl" => '""',
	},
	"nnsspfile" => {
	},
	"outfile" => {
		"perl" => '" $value"',
	},

    };

    $self->{FILENAMES}  = {
	"nnsspfile" => '*.nns',

    };

    $self->{SEQFMT}  = {
	"infile" => [100],

    };

    $self->{GROUP}  = {
	"nnssp" => 0,
	"infile" => 1,
	"seq" => 1,
	"outfile" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"nnssp",
	"nnsspfile",
	"infile",
	"seq",
	"outfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"nnssp" => 1,
	"infile" => 0,
	"seq" => 0,
	"nnsspfile" => 0,
	"outfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"nnssp" => 1,
	"infile" => 0,
	"seq" => 0,
	"nnsspfile" => 0,
	"outfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"nnssp" => 0,
	"infile" => 1,
	"seq" => 1,
	"nnsspfile" => 0,
	"outfile" => 1,

    };

    $self->{PROMPT}  = {
	"nnssp" => "",
	"infile" => "Clustalw Alignment File",
	"seq" => "Name of the sequence to analyze",
	"nnsspfile" => "",
	"outfile" => "Output File",

    };

    $self->{ISSTANDOUT}  = {
	"nnssp" => 0,
	"infile" => 0,
	"seq" => 0,
	"nnsspfile" => 0,
	"outfile" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => 'nnssp.results',

    };

    $self->{PRECOND}  = {
	"nnssp" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"nnsspfile" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"infile" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"nnssp" => 0,
	"infile" => 0,
	"seq" => 0,
	"nnsspfile" => 0,
	"outfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"nnssp" => 0,
	"infile" => 1,
	"seq" => 1,
	"nnsspfile" => 0,
	"outfile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {

    };

    $self->{SCALEMIN}  = {

    };

    $self->{SCALEMAX}  = {

    };

    $self->{SCALEINC}  = {

    };

    $self->{INFO}  = {

    };

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/nnssp.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

