
=head1 NAME

Bio::Tools::Run::PiseApplication::plsearch

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::plsearch

      Bioperl class for:

	PLSEARCH	search protein sequences for similarity to AACC patterns (R. Smith & T. Smit)

	References:

		Smith, Randall F. and Temple F. Smith (1990).  Automatic generation of diagnostic sequence patterns from sets of related protein sequences.  Proc. Natl. Acad. Sci. USA 87:118-122.


      Parameters:


		plsearch (String)
			

		type (String)
			

		no_detach (String)
			

		protein (Sequence)
			Protein sequence File

		outfile (OutFile)
			Results file

		max_alignements (Integer)
			Maximum number of alignments

		params (Results)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::plsearch;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $plsearch = Bio::Tools::Run::PiseApplication::plsearch->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::plsearch object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $plsearch = $factory->program('plsearch');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::plsearch.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/plsearch.pm

    $self->{COMMAND}   = "plsearch";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PLSEARCH";

    $self->{DESCRIPTION}   = "search protein sequences for similarity to AACC patterns";

    $self->{CATEGORIES}   =  [  

         "protein:motifs",
  ];

    $self->{AUTHORS}   = "R. Smith & T. Smit";

    $self->{REFERENCE}   = [

         "Smith, Randall F. and Temple F. Smith (1990).  Automatic generation of diagnostic sequence patterns from sets of related protein sequences.  Proc. Natl. Acad. Sci. USA 87:118-122.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"plsearch",
	"type",
	"no_detach",
	"protein",
	"outfile",
	"max_alignements",
	"params",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"plsearch",
	"type",
	"no_detach",
	"protein", 	# Protein sequence File
	"outfile", 	# Results file
	"max_alignements", 	# Maximum number of alignments
	"params",

    ];

    $self->{TYPE}  = {
	"plsearch" => 'String',
	"type" => 'String',
	"no_detach" => 'String',
	"protein" => 'Sequence',
	"outfile" => 'OutFile',
	"max_alignements" => 'Integer',
	"params" => 'Results',

    };

    $self->{FORMAT}  = {
	"plsearch" => {
		"perl" => '"readseq -p -f1 < $protein | IG-to-tbl > tmp; cp tmp $protein; plsearch < params " ',
	},
	"type" => {
		"perl" => '"1\\n" ',
	},
	"no_detach" => {
		"perl" => '"no\\n" ',
	},
	"protein" => {
		"perl" => '`basename $value` ',
	},
	"outfile" => {
		"perl" => '($value)? "$value\\n" : "plsearch.res\\n"',
	},
	"max_alignements" => {
		"perl" => '(defined $value && $value != $vdef)? "$value\\n":"$vdef\\n"',
	},
	"params" => {
	},

    };

    $self->{FILENAMES}  = {
	"params" => 'params',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"plsearch" => 0,
	"type" => 1,
	"no_detach" => 5,
	"protein" => 2,
	"outfile" => 3,
	"max_alignements" => 4,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"plsearch",
	"params",
	"type",
	"protein",
	"outfile",
	"max_alignements",
	"no_detach",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"plsearch" => 1,
	"type" => 1,
	"no_detach" => 1,
	"protein" => 0,
	"outfile" => 0,
	"max_alignements" => 0,
	"params" => 0,

    };

    $self->{ISCOMMAND}  = {
	"plsearch" => 1,
	"type" => 0,
	"no_detach" => 0,
	"protein" => 0,
	"outfile" => 0,
	"max_alignements" => 0,
	"params" => 0,

    };

    $self->{ISMANDATORY}  = {
	"plsearch" => 0,
	"type" => 0,
	"no_detach" => 0,
	"protein" => 1,
	"outfile" => 1,
	"max_alignements" => 0,
	"params" => 0,

    };

    $self->{PROMPT}  = {
	"plsearch" => "",
	"type" => "",
	"no_detach" => "",
	"protein" => "Protein sequence File",
	"outfile" => "Results file",
	"max_alignements" => "Maximum number of alignments",
	"params" => "",

    };

    $self->{ISSTANDOUT}  = {
	"plsearch" => 0,
	"type" => 0,
	"no_detach" => 0,
	"protein" => 0,
	"outfile" => 0,
	"max_alignements" => 0,
	"params" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => 'plsearch.res',
	"max_alignements" => '20',

    };

    $self->{PRECOND}  = {
	"plsearch" => { "perl" => '1' },
	"type" => { "perl" => '1' },
	"no_detach" => { "perl" => '1' },
	"protein" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"max_alignements" => { "perl" => '1' },
	"params" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"plsearch" => 0,
	"type" => 0,
	"no_detach" => 0,
	"protein" => 0,
	"outfile" => 0,
	"max_alignements" => 0,
	"params" => 0,

    };

    $self->{ISSIMPLE}  = {
	"plsearch" => 0,
	"type" => 0,
	"no_detach" => 0,
	"protein" => 1,
	"outfile" => 0,
	"max_alignements" => 0,
	"params" => 0,

    };

    $self->{PARAMFILE}  = {
	"type" => "params",
	"no_detach" => "params",
	"protein" => "params",
	"outfile" => "params",
	"max_alignements" => "params",

    };

    $self->{COMMENT}  = {
	"max_alignements" => [
		"This value sets the maximum, however all matches with SDAM values greater than 4.0 will be displayed regardless of the value specified here.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/plsearch.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

