
=head1 NAME

Bio::Tools::Run::PiseApplication::drawpyr

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::drawpyr

      Bioperl class for:

	Pyramids	drawpyr - pyramidal analysis tool for sequence  clustering (JC AUDE)

      Parameters:


		drawpyr (String)
			

		infile (InFile)
			Pyramidal representations file (.pyr or .pyt)
			pipe: pyramid_file

		image_format (Excl)
			Image format (-F)

		qual (Switch)
			Display quality information (-Q)

		out_file (OutFile)
			

		res (Results)
			

=cut

#'
package Bio::Tools::Run::PiseApplication::drawpyr;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $drawpyr = Bio::Tools::Run::PiseApplication::drawpyr->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::drawpyr object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $drawpyr = $factory->program('drawpyr');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::drawpyr.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/drawpyr.pm

    $self->{COMMAND}   = "drawpyr";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Pyramids";

    $self->{DESCRIPTION}   = "drawpyr - pyramidal analysis tool for sequence  clustering";

    $self->{AUTHORS}   = "JC AUDE";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"drawpyr",
	"infile",
	"image_format",
	"qual",
	"out_file",
	"res",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"drawpyr",
	"infile", 	# Pyramidal representations file (.pyr or .pyt)
	"image_format", 	# Image format (-F)
	"qual", 	# Display quality information (-Q)
	"out_file",
	"res",

    ];

    $self->{TYPE}  = {
	"drawpyr" => 'String',
	"infile" => 'InFile',
	"image_format" => 'Excl',
	"qual" => 'Switch',
	"out_file" => 'OutFile',
	"res" => 'Results',

    };

    $self->{FORMAT}  = {
	"drawpyr" => {
		"seqlab" => 'drawpyr',
		"perl" => '"drawpyr"',
	},
	"infile" => {
		"perl" => '" $value"',
	},
	"image_format" => {
		"perl" => '" -F $value"',
	},
	"qual" => {
		"perl" => '($value)? " -Q" : ""',
	},
	"out_file" => {
		"perl" => '" image"',
	},
	"res" => {
	},

    };

    $self->{FILENAMES}  = {
	"res" => '*.gif *.*ps *.fig',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"drawpyr" => 0,
	"infile" => 3,
	"image_format" => 2,
	"qual" => 1,
	"out_file" => 4,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"drawpyr",
	"res",
	"qual",
	"image_format",
	"infile",
	"out_file",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"drawpyr" => 1,
	"infile" => 0,
	"image_format" => 0,
	"qual" => 0,
	"out_file" => 1,
	"res" => 0,

    };

    $self->{ISCOMMAND}  = {
	"drawpyr" => 1,
	"infile" => 0,
	"image_format" => 0,
	"qual" => 0,
	"out_file" => 0,
	"res" => 0,

    };

    $self->{ISMANDATORY}  = {
	"drawpyr" => 0,
	"infile" => 1,
	"image_format" => 0,
	"qual" => 0,
	"out_file" => 0,
	"res" => 0,

    };

    $self->{PROMPT}  = {
	"drawpyr" => "",
	"infile" => "Pyramidal representations file (.pyr or .pyt)",
	"image_format" => "Image format (-F)",
	"qual" => "Display quality information (-Q)",
	"out_file" => "",
	"res" => "",

    };

    $self->{ISSTANDOUT}  = {
	"drawpyr" => 0,
	"infile" => 0,
	"image_format" => 0,
	"qual" => 0,
	"out_file" => 0,
	"res" => 0,

    };

    $self->{VLIST}  = {

	"image_format" => ['GIF','gif','PS','Postscript','EPS','Encapsulated postscript','GW3','gif for web usage [800x1200]','FIG','fig (Xfig 3.1 format)',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"image_format" => 'GIF',
	"qual" => '0',
	"out_file" => 'image',

    };

    $self->{PRECOND}  = {
	"drawpyr" => { "perl" => '1' },
	"infile" => { "perl" => '1' },
	"image_format" => { "perl" => '1' },
	"qual" => { "perl" => '1' },
	"out_file" => { "perl" => '1' },
	"res" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"infile" => {
		 "pyramid_file" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"drawpyr" => 0,
	"infile" => 0,
	"image_format" => 0,
	"qual" => 0,
	"out_file" => 0,
	"res" => 0,

    };

    $self->{ISSIMPLE}  = {
	"drawpyr" => 1,
	"infile" => 1,
	"image_format" => 1,
	"qual" => 0,
	"out_file" => 0,
	"res" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/drawpyr.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

