
=head1 NAME

Bio::Tools::Run::PiseApplication::redata

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::redata

      Bioperl class for:

	REDATA	Search REBASE for enzyme name, references, suppliers etc. (EMBOSS)

      Parameters:


		redata (String)


		init (String)


		input (Paragraph)
			input Section

		enzyme (String)
			Restriction enzyme name (-enzyme)

		output (Paragraph)
			output Section

		isoschizomers (Switch)
			Show isoschizomers (-isoschizomers)

		references (Switch)
			Show references (-references)

		suppliers (Switch)
			Show suppliers (-suppliers)

		outfile (OutFile)
			outfile (-outfile)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::redata;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $redata = Bio::Tools::Run::PiseApplication::redata->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::redata object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $redata = $factory->program('redata');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::redata.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/redata.pm

    $self->{COMMAND}   = "redata";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "REDATA";

    $self->{DESCRIPTION}   = "Search REBASE for enzyme name, references, suppliers etc. (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "nucleic:restriction",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/redata.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"redata",
	"init",
	"input",
	"output",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"redata",
	"init",
	"input", 	# input Section
	"enzyme", 	# Restriction enzyme name (-enzyme)
	"output", 	# output Section
	"isoschizomers", 	# Show isoschizomers (-isoschizomers)
	"references", 	# Show references (-references)
	"suppliers", 	# Show suppliers (-suppliers)
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"redata" => 'String',
	"init" => 'String',
	"input" => 'Paragraph',
	"enzyme" => 'String',
	"output" => 'Paragraph',
	"isoschizomers" => 'Switch',
	"references" => 'Switch',
	"suppliers" => 'Switch',
	"outfile" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"input" => {
	},
	"enzyme" => {
		"perl" => '" -enzyme=$value"',
	},
	"output" => {
	},
	"isoschizomers" => {
		"perl" => '($value)? "" : " -noisoschizomers"',
	},
	"references" => {
		"perl" => '($value)? "" : " -noreferences"',
	},
	"suppliers" => {
		"perl" => '($value)? "" : " -nosuppliers"',
	},
	"outfile" => {
		"perl" => '" -outfile=$value"',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"redata" => {
		"perl" => '"redata"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"init" => -10,
	"enzyme" => 1,
	"isoschizomers" => 2,
	"references" => 3,
	"suppliers" => 4,
	"outfile" => 5,
	"auto" => 6,
	"redata" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"input",
	"output",
	"redata",
	"enzyme",
	"isoschizomers",
	"references",
	"suppliers",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"input" => 0,
	"enzyme" => 0,
	"output" => 0,
	"isoschizomers" => 0,
	"references" => 0,
	"suppliers" => 0,
	"outfile" => 0,
	"auto" => 1,
	"redata" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"input" => 0,
	"enzyme" => 0,
	"output" => 0,
	"isoschizomers" => 0,
	"references" => 0,
	"suppliers" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"input" => 0,
	"enzyme" => 1,
	"output" => 0,
	"isoschizomers" => 0,
	"references" => 0,
	"suppliers" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"input" => "input Section",
	"enzyme" => "Restriction enzyme name (-enzyme)",
	"output" => "output Section",
	"isoschizomers" => "Show isoschizomers (-isoschizomers)",
	"references" => "Show references (-references)",
	"suppliers" => "Show suppliers (-suppliers)",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"input" => 0,
	"enzyme" => 0,
	"output" => 0,
	"isoschizomers" => 0,
	"references" => 0,
	"suppliers" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

	"input" => ['enzyme',],
	"output" => ['isoschizomers','references','suppliers','outfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"enzyme" => 'BamHI',
	"isoschizomers" => '1',
	"references" => '1',
	"suppliers" => '1',
	"outfile" => 'outfile.out',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"enzyme" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"isoschizomers" => { "perl" => '1' },
	"references" => { "perl" => '1' },
	"suppliers" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"auto" => { "perl" => '1' },

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
	"init" => 0,
	"input" => 0,
	"enzyme" => 0,
	"output" => 0,
	"isoschizomers" => 0,
	"references" => 0,
	"suppliers" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"input" => 0,
	"enzyme" => 1,
	"output" => 0,
	"isoschizomers" => 0,
	"references" => 0,
	"suppliers" => 0,
	"outfile" => 1,
	"auto" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"enzyme" => [
		"Enter the name of the restrcition enzyme that you wish to get details of. The names often have a \'I\' in them - this is a capital \'i\', not a \'1\' or an \'l\'. The names are case-indeppendent (\'AaeI\' is the same as \'aaei\')",
	],
	"isoschizomers" => [
		"Show other enzymes with this specificity. (Isoschizomers)",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/redata.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

