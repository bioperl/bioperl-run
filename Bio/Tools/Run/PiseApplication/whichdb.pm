
=head1 NAME

Bio::Tools::Run::PiseApplication::whichdb

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::whichdb

      Bioperl class for:

	WHICHDB	Search all databases for an entry (EMBOSS)

      Parameters:


		whichdb (String)


		init (String)


		entry (String)
			ID or Accession number (-entry)

		get (Switch)
			Retrieve sequences (-get)

		outfile (OutFile)
			outfile (-outfile)

		auto (String)


=cut

#'
package Bio::Tools::Run::PiseApplication::whichdb;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $whichdb = Bio::Tools::Run::PiseApplication::whichdb->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::whichdb object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $whichdb = $factory->program('whichdb');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::whichdb.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/whichdb.pm

    $self->{COMMAND}   = "whichdb";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "WHICHDB";

    $self->{DESCRIPTION}   = "Search all databases for an entry (EMBOSS)";

    $self->{CATEGORIES}   =  [  

         "information",
  ];

    $self->{DOCLINK}   = "http://www.uk.embnet.org/Software/EMBOSS/Apps/whichdb.html";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"whichdb",
	"init",
	"entry",
	"get",
	"outfile",
	"auto",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"whichdb",
	"init",
	"entry", 	# ID or Accession number (-entry)
	"get", 	# Retrieve sequences (-get)
	"outfile", 	# outfile (-outfile)
	"auto",

    ];

    $self->{TYPE}  = {
	"whichdb" => 'String',
	"init" => 'String',
	"entry" => 'String',
	"get" => 'Switch',
	"outfile" => 'OutFile',
	"auto" => 'String',

    };

    $self->{FORMAT}  = {
	"init" => {
		"perl" => ' "" ',
	},
	"entry" => {
		"perl" => '" -entry=$value"',
	},
	"get" => {
		"perl" => '($value)? " -get" : ""',
	},
	"outfile" => {
		"perl" => '($value)? " -outfile=$value" : ""',
	},
	"auto" => {
		"perl" => '" -auto -stdout"',
	},
	"whichdb" => {
		"perl" => '"whichdb"',
	}

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"init" => -10,
	"entry" => 1,
	"get" => 2,
	"outfile" => 3,
	"auto" => 4,
	"whichdb" => 0

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"init",
	"whichdb",
	"entry",
	"get",
	"outfile",
	"auto",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"init" => 1,
	"entry" => 0,
	"get" => 0,
	"outfile" => 0,
	"auto" => 1,
	"whichdb" => 1

    };

    $self->{ISCOMMAND}  = {
	"init" => 0,
	"entry" => 0,
	"get" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISMANDATORY}  = {
	"init" => 0,
	"entry" => 1,
	"get" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{PROMPT}  = {
	"init" => "",
	"entry" => "ID or Accession number (-entry)",
	"get" => "Retrieve sequences (-get)",
	"outfile" => "outfile (-outfile)",
	"auto" => "",

    };

    $self->{ISSTANDOUT}  = {
	"init" => 0,
	"entry" => 0,
	"get" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"get" => '0',

    };

    $self->{PRECOND}  = {
	"init" => { "perl" => '1' },
	"entry" => { "perl" => '1' },
	"get" => { "perl" => '1' },
	"outfile" => {
		"acd" => '@(!$(get))',
	},
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
	"entry" => 0,
	"get" => 0,
	"outfile" => 0,
	"auto" => 0,

    };

    $self->{ISSIMPLE}  = {
	"init" => 0,
	"entry" => 1,
	"get" => 0,
	"outfile" => 0,
	"auto" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/whichdb.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

