
=head1 NAME

Bio::Tools::Run::PiseApplication::primo

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::primo

      Bioperl class for:

	PRIMO	A primer design tool (Kupfer, Li)

      Parameters:


		primo (String)
			

		input_file_name (InFile)
			Sequence data

		all (String)
			

		cover (Switch)
			cover template with walking-primers on both strands (-cover)

		print (Switch)
			print formatted/annotated sequence to log file (-print)

		regions_file (InFile)
			Regions file (-read)

		qual_file (InFile)
			Quality datafile file

		repeats_file (InFile)
			Repeats file

		oligo_file (InFile)
			Oligo file

		rf (String)
			

		qf (String)
			

		results_files (Results)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::primo;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $primo = Bio::Tools::Run::PiseApplication::primo->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::primo object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $primo = $factory->program('primo');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::primo.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/primo.pm

    $self->{COMMAND}   = "primo";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "PRIMO";

    $self->{DESCRIPTION}   = "A primer design tool";

    $self->{AUTHORS}   = "Kupfer, Li";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"primo",
	"input_file_name",
	"all",
	"cover",
	"print",
	"regions_file",
	"qual_file",
	"repeats_file",
	"oligo_file",
	"rf",
	"qf",
	"results_files",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"primo",
	"input_file_name", 	# Sequence data
	"all",
	"cover", 	# cover template with walking-primers on both strands (-cover)
	"print", 	# print formatted/annotated sequence to log file (-print)
	"regions_file", 	# Regions file (-read)
	"qual_file", 	# Quality datafile file
	"repeats_file", 	# Repeats file
	"oligo_file", 	# Oligo file
	"rf",
	"qf",
	"results_files",

    ];

    $self->{TYPE}  = {
	"primo" => 'String',
	"input_file_name" => 'InFile',
	"all" => 'String',
	"cover" => 'Switch',
	"print" => 'Switch',
	"regions_file" => 'InFile',
	"qual_file" => 'InFile',
	"repeats_file" => 'InFile',
	"oligo_file" => 'InFile',
	"rf" => 'String',
	"qf" => 'String',
	"results_files" => 'Results',

    };

    $self->{FORMAT}  = {
	"primo" => {
		"perl" => '"primo"',
	},
	"input_file_name" => {
		"perl" => '" $value"',
	},
	"all" => {
		"perl" => '" -all"',
	},
	"cover" => {
		"perl" => '($value)? " -cover" : ""',
	},
	"print" => {
		"perl" => '($value)? " -print" : ""',
	},
	"regions_file" => {
		"perl" => '($value)? " -read $input_file_name" : ""',
	},
	"qual_file" => {
		"perl" => '($value)? "" : " -noqual"',
	},
	"repeats_file" => {
		"perl" => ' ($value)? "ln -s $value human.rep; " : ""',
	},
	"oligo_file" => {
		"perl" => ' ($value)? "ln -s $value oligo.screen; " : ""',
	},
	"rf" => {
		"perl" => '"ln -s $regions_file $input_file_name.regions; "',
	},
	"qf" => {
		"perl" => '"ln -s $qual_file $input_file_name.qual; "',
	},
	"results_files" => {
	},

    };

    $self->{FILENAMES}  = {
	"results_files" => '*.log *.primers',

    };

    $self->{SEQFMT}  = {
	"input_file_name" => [8],

    };

    $self->{GROUP}  = {
	"primo" => 0,
	"input_file_name" => 1,
	"all" => 10,
	"cover" => 10,
	"print" => 10,
	"regions_file" => 10,
	"qual_file" => 10,
	"repeats_file" => -10,
	"oligo_file" => -10,
	"rf" => -10,
	"qf" => -10,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"rf",
	"qf",
	"repeats_file",
	"oligo_file",
	"primo",
	"results_files",
	"input_file_name",
	"all",
	"cover",
	"print",
	"regions_file",
	"qual_file",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"primo" => 1,
	"input_file_name" => 0,
	"all" => 1,
	"cover" => 0,
	"print" => 0,
	"regions_file" => 0,
	"qual_file" => 0,
	"repeats_file" => 0,
	"oligo_file" => 0,
	"rf" => 1,
	"qf" => 1,
	"results_files" => 0,

    };

    $self->{ISCOMMAND}  = {
	"primo" => 1,
	"input_file_name" => 0,
	"all" => 0,
	"cover" => 0,
	"print" => 0,
	"regions_file" => 0,
	"qual_file" => 0,
	"repeats_file" => 0,
	"oligo_file" => 0,
	"rf" => 0,
	"qf" => 0,
	"results_files" => 0,

    };

    $self->{ISMANDATORY}  = {
	"primo" => 0,
	"input_file_name" => 1,
	"all" => 0,
	"cover" => 0,
	"print" => 0,
	"regions_file" => 0,
	"qual_file" => 0,
	"repeats_file" => 0,
	"oligo_file" => 0,
	"rf" => 0,
	"qf" => 0,
	"results_files" => 0,

    };

    $self->{PROMPT}  = {
	"primo" => "",
	"input_file_name" => "Sequence data",
	"all" => "",
	"cover" => "cover template with walking-primers on both strands (-cover)",
	"print" => "print formatted/annotated sequence to log file (-print)",
	"regions_file" => "Regions file (-read)",
	"qual_file" => "Quality datafile file",
	"repeats_file" => "Repeats file",
	"oligo_file" => "Oligo file",
	"rf" => "",
	"qf" => "",
	"results_files" => "",

    };

    $self->{ISSTANDOUT}  = {
	"primo" => 0,
	"input_file_name" => 0,
	"all" => 0,
	"cover" => 0,
	"print" => 0,
	"regions_file" => 0,
	"qual_file" => 0,
	"repeats_file" => 0,
	"oligo_file" => 0,
	"rf" => 0,
	"qf" => 0,
	"results_files" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"oligo_file" => 'Name    Oligo\noligo1  GAGGCAGGAGAATGGCAC	',

    };

    $self->{PRECOND}  = {
	"primo" => { "perl" => '1' },
	"input_file_name" => { "perl" => '1' },
	"all" => { "perl" => '1' },
	"cover" => { "perl" => '1' },
	"print" => {
		"perl" => '! $cover',
	},
	"regions_file" => { "perl" => '1' },
	"qual_file" => { "perl" => '1' },
	"repeats_file" => { "perl" => '1' },
	"oligo_file" => { "perl" => '1' },
	"rf" => {
		"perl" => '$regions_file',
	},
	"qf" => {
		"perl" => '$qual_file',
	},
	"results_files" => { "perl" => '1' },

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
	"primo" => 0,
	"input_file_name" => 0,
	"all" => 0,
	"cover" => 0,
	"print" => 0,
	"regions_file" => 0,
	"qual_file" => 0,
	"repeats_file" => 0,
	"oligo_file" => 0,
	"rf" => 0,
	"qf" => 0,
	"results_files" => 0,

    };

    $self->{ISSIMPLE}  = {
	"primo" => 0,
	"input_file_name" => 1,
	"all" => 0,
	"cover" => 0,
	"print" => 0,
	"regions_file" => 0,
	"qual_file" => 0,
	"repeats_file" => 0,
	"oligo_file" => 0,
	"rf" => 0,
	"qf" => 0,
	"results_files" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"repeats_file" => [
		"See the file http://bioweb.pasteur.fr/docs/doc-gensoft/primo/example//human.rep.bac for an example.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/primo.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

