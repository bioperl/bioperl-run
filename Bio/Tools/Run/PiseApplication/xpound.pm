
=head1 NAME

Bio::Tools::Run::PiseApplication::xpound

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::xpound

      Bioperl class for:

	Xpound	software for exon trapping (Thomas & Skolnick)

	References:

		A probabilistic model for detecting coding regions in DNA sequences.  Alun Thomas and Mark H Skolnick,  IMA Journal of Mathematics Applied in Medicine and Biology, 1994, 11, 149-160.


      Parameters:


		xpound (String)


		seq (Sequence)
			DNA sequence File

		outfile (OutFile)


		report_options (Paragraph)
			Report options

		report (Switch)
			Reports regions of bases for which the probability of coding is high (xreport)

		cut_off (Integer)
			Cut off value for report

		min_length (Integer)
			Minimum length value for report

		report_file (OutFile)
			Report file

		postscript_options (Paragraph)
			Postscript options

		postscript (Switch)
			Produces a file of graphs in PostScript format (xpscript)

		orientation (Excl)
			Orientation

		rows (Integer)
			Rows of plots per page (-r)

		columns (Integer)
			Columns of plots per page (-c)

		high (Integer)
			Draw a line at this level (-hi)

		low (Integer)
			Draw a line at this level (-hi)

		psfile (OutFile)
			PostScript file

		result (InFile)


=cut

#'
package Bio::Tools::Run::PiseApplication::xpound;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $xpound = Bio::Tools::Run::PiseApplication::xpound->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::xpound object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $xpound = $factory->program('xpound');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::xpound.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/xpound.pm

    $self->{COMMAND}   = "xpound";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Xpound";

    $self->{DESCRIPTION}   = "software for exon trapping";

    $self->{AUTHORS}   = "Thomas & Skolnick";

    $self->{REFERENCE}   = [

         "A probabilistic model for detecting coding regions in DNA sequences.  Alun Thomas and Mark H Skolnick,  IMA Journal of Mathematics Applied in Medicine and Biology, 1994, 11, 149-160.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"xpound",
	"seq",
	"outfile",
	"report_options",
	"postscript_options",
	"result",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"xpound",
	"seq", 	# DNA sequence File
	"outfile",
	"report_options", 	# Report options
	"report", 	# Reports regions of bases for which the probability of coding is high (xreport)
	"cut_off", 	# Cut off value for report
	"min_length", 	# Minimum length value for report
	"report_file", 	# Report file
	"postscript_options", 	# Postscript options
	"postscript", 	# Produces a file of graphs in PostScript format (xpscript)
	"orientation", 	# Orientation
	"rows", 	# Rows of plots per page (-r)
	"columns", 	# Columns of plots per page (-c)
	"high", 	# Draw a line at this level (-hi)
	"low", 	# Draw a line at this level (-hi)
	"psfile", 	# PostScript file
	"result",

    ];

    $self->{TYPE}  = {
	"xpound" => 'String',
	"seq" => 'Sequence',
	"outfile" => 'OutFile',
	"report_options" => 'Paragraph',
	"report" => 'Switch',
	"cut_off" => 'Integer',
	"min_length" => 'Integer',
	"report_file" => 'OutFile',
	"postscript_options" => 'Paragraph',
	"postscript" => 'Switch',
	"orientation" => 'Excl',
	"rows" => 'Integer',
	"columns" => 'Integer',
	"high" => 'Integer',
	"low" => 'Integer',
	"psfile" => 'OutFile',
	"result" => 'InFile',

    };

    $self->{FORMAT}  = {
	"xpound" => {
		"seqlab" => 'xpound',
		"perl" => '"xpound"',
	},
	"seq" => {
		"perl" => '" < $value" ',
	},
	"outfile" => {
		"perl" => '" > xpound.out " ',
	},
	"report_options" => {
	},
	"report" => {
		"perl" => '($value)? " ; xreport < xpound.out " : "" ',
	},
	"cut_off" => {
		"perl" => '(defined $value && $value != $vdef )? " $value " : "" ',
	},
	"min_length" => {
		"perl" => '($value && $value != $vdef )? " $value " : "" ',
	},
	"report_file" => {
		"perl" => '($value)? " > $value " : " > xreport.out " ',
	},
	"postscript_options" => {
	},
	"postscript" => {
		"perl" => '($value)? "; xpscript " : "" ',
	},
	"orientation" => {
		"perl" => '($value eq "lanscape")? " -l " : "" ',
	},
	"rows" => {
		"perl" => '($value && $value != $vdef )? " -r $value " : "" ',
	},
	"columns" => {
		"perl" => '($value && $value != $vdef )? " -c $value " : "" ',
	},
	"high" => {
		"perl" => '($value && $value != $vdef )? " -hi $value " : "" ',
	},
	"low" => {
		"perl" => '($value && $value != $vdef )? " -lo $value " : "" ',
	},
	"psfile" => {
		"perl" => '($value)? " > $value" : " > xpound.ps" ',
	},
	"result" => {
		"perl" => ' " xpound.out " ',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {
	"seq" => [13],

    };

    $self->{GROUP}  = {
	"xpound" => 0,
	"seq" => 2,
	"outfile" => 10,
	"report" => 20,
	"cut_off" => 21,
	"min_length" => 22,
	"report_file" => 25,
	"postscript" => 30,
	"orientation" => 31,
	"rows" => 32,
	"columns" => 32,
	"high" => 33,
	"low" => 34,
	"psfile" => 100,
	"result" => 40,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"xpound",
	"report_options",
	"postscript_options",
	"seq",
	"outfile",
	"report",
	"cut_off",
	"min_length",
	"report_file",
	"postscript",
	"orientation",
	"rows",
	"columns",
	"high",
	"low",
	"result",
	"psfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"xpound" => 1,
	"seq" => 0,
	"outfile" => 1,
	"report_options" => 0,
	"report" => 0,
	"cut_off" => 0,
	"min_length" => 0,
	"report_file" => 0,
	"postscript_options" => 0,
	"postscript" => 0,
	"orientation" => 0,
	"rows" => 0,
	"columns" => 0,
	"high" => 0,
	"low" => 0,
	"psfile" => 0,
	"result" => 1,

    };

    $self->{ISCOMMAND}  = {
	"xpound" => 1,
	"seq" => 0,
	"outfile" => 0,
	"report_options" => 0,
	"report" => 0,
	"cut_off" => 0,
	"min_length" => 0,
	"report_file" => 0,
	"postscript_options" => 0,
	"postscript" => 0,
	"orientation" => 0,
	"rows" => 0,
	"columns" => 0,
	"high" => 0,
	"low" => 0,
	"psfile" => 0,
	"result" => 0,

    };

    $self->{ISMANDATORY}  = {
	"xpound" => 0,
	"seq" => 1,
	"outfile" => 0,
	"report_options" => 0,
	"report" => 0,
	"cut_off" => 0,
	"min_length" => 0,
	"report_file" => 0,
	"postscript_options" => 0,
	"postscript" => 0,
	"orientation" => 0,
	"rows" => 0,
	"columns" => 0,
	"high" => 0,
	"low" => 0,
	"psfile" => 0,
	"result" => 0,

    };

    $self->{PROMPT}  = {
	"xpound" => "",
	"seq" => "DNA sequence File",
	"outfile" => "",
	"report_options" => "Report options",
	"report" => "Reports regions of bases for which the probability of coding is high (xreport)",
	"cut_off" => "Cut off value for report",
	"min_length" => "Minimum length value for report",
	"report_file" => "Report file",
	"postscript_options" => "Postscript options",
	"postscript" => "Produces a file of graphs in PostScript format (xpscript)",
	"orientation" => "Orientation",
	"rows" => "Rows of plots per page (-r)",
	"columns" => "Columns of plots per page (-c)",
	"high" => "Draw a line at this level (-hi)",
	"low" => "Draw a line at this level (-hi)",
	"psfile" => "PostScript file",
	"result" => "",

    };

    $self->{ISSTANDOUT}  = {
	"xpound" => 0,
	"seq" => 0,
	"outfile" => 0,
	"report_options" => 0,
	"report" => 0,
	"cut_off" => 0,
	"min_length" => 0,
	"report_file" => 0,
	"postscript_options" => 0,
	"postscript" => 0,
	"orientation" => 0,
	"rows" => 0,
	"columns" => 0,
	"high" => 0,
	"low" => 0,
	"psfile" => 1,
	"result" => 0,

    };

    $self->{VLIST}  = {

	"report_options" => ['report','cut_off','min_length','report_file',],
	"postscript_options" => ['postscript','orientation','rows','columns','high','low','psfile',],
	"orientation" => ['portrait','portrait','lanscape','lanscape',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => 'xpound.out',
	"report" => '1',
	"cut_off" => '0.75',
	"min_length" => '0',
	"report_file" => 'xreport.out',
	"postscript" => '1',
	"orientation" => 'portrait',
	"rows" => '5',
	"columns" => '1',
	"high" => '0.75',
	"low" => '0.5',
	"psfile" => 'xpound.ps',

    };

    $self->{PRECOND}  = {
	"xpound" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"report_options" => { "perl" => '1' },
	"report" => { "perl" => '1' },
	"cut_off" => {
		"perl" => '$report',
	},
	"min_length" => {
		"perl" => '$report',
	},
	"report_file" => {
		"perl" => '$report',
	},
	"postscript_options" => { "perl" => '1' },
	"postscript" => { "perl" => '1' },
	"orientation" => {
		"perl" => '$postscript',
	},
	"rows" => {
		"perl" => '$postscript',
	},
	"columns" => {
		"perl" => '$postscript',
	},
	"high" => {
		"perl" => '$postscript',
	},
	"low" => {
		"perl" => '$postscript',
	},
	"psfile" => {
		"perl" => '$postscript',
	},
	"result" => {
		"perl" => '$postscript',
	},

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
	"xpound" => 0,
	"seq" => 0,
	"outfile" => 0,
	"report_options" => 0,
	"report" => 0,
	"cut_off" => 0,
	"min_length" => 0,
	"report_file" => 0,
	"postscript_options" => 0,
	"postscript" => 0,
	"orientation" => 0,
	"rows" => 0,
	"columns" => 0,
	"high" => 0,
	"low" => 0,
	"psfile" => 0,
	"result" => 0,

    };

    $self->{ISSIMPLE}  = {
	"xpound" => 1,
	"seq" => 1,
	"outfile" => 0,
	"report_options" => 0,
	"report" => 0,
	"cut_off" => 0,
	"min_length" => 0,
	"report_file" => 0,
	"postscript_options" => 0,
	"postscript" => 0,
	"orientation" => 0,
	"rows" => 0,
	"columns" => 0,
	"high" => 0,
	"low" => 0,
	"psfile" => 0,
	"result" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"seq" => [
		"Everything after a % on a line in the input file is ignored. Other than comment xpound expects only white space, which is also ignored, or IUPAC charaters:",
		"A C M G R S V T W Y H K D B N",
		"in upper or lower case. Characters which do not uniquely determine a base, such as N, B, S and so on, are all interpreted as a C.",
		"Xpound will not accept the IUPAC character -, all occurences of which should be stripped from the input file beforehand.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/xpound.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

