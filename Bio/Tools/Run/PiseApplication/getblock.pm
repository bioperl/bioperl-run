
=head1 NAME

Bio::Tools::Run::PiseApplication::getblock

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::getblock

      Bioperl class for:

	BLIMPS	getblock - fetch a block from Blocks database (Wallace & Henikoff)

	References:

		J.C. Wallace and S. Henikoff, PATMAT: a searching and extraction program for sequence, pattern and block queries and databases, CABIOS, 8:3, p. 249-254 (1992).

		Steven Henikoff and Jorja G. Henikoff, Automated assembly of protein blocks for database searching, Nucleic Acids Research, 19:23, p. 6565-6572. (1991)


      Parameters:


		getblock (String)
			

		dbs (String)
			

		query (String)
			query (Accession Nr)

=cut

#'
package Bio::Tools::Run::PiseApplication::getblock;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $getblock = Bio::Tools::Run::PiseApplication::getblock->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::getblock object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $getblock = $factory->program('getblock');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::getblock.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/getblock.pm

    $self->{COMMAND}   = "getblock";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "BLIMPS";

    $self->{DESCRIPTION}   = "getblock - fetch a block from Blocks database";

    $self->{AUTHORS}   = "Wallace & Henikoff";

    $self->{DOCLINK}   = "http://bioweb.pasteur.fr/docs/gensoft-aa.html#BLIMPS";

    $self->{REFERENCE}   = [

         "J.C. Wallace and S. Henikoff, PATMAT: a searching and extraction program for sequence, pattern and block queries and databases, CABIOS, 8:3, p. 249-254 (1992).",

         "Steven Henikoff and Jorja G. Henikoff, Automated assembly of protein blocks for database searching, Nucleic Acids Research, 19:23, p. 6565-6572. (1991)",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"getblock",
	"dbs",
	"query",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"getblock",
	"dbs",
	"query", 	# query (Accession Nr)

    ];

    $self->{TYPE}  = {
	"getblock" => 'String',
	"dbs" => 'String',
	"query" => 'String',

    };

    $self->{FORMAT}  = {
	"getblock" => {
		"perl" => '"getblock"',
	},
	"dbs" => {
		"perl" => ' " /local/gensoft/lib/blimps/db/blocks.dat /local/gensoft/lib/blimps/db/" ',
	},
	"query" => {
		"perl" => '" $value"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"getblock" => 0,
	"dbs" => 2,
	"query" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"getblock",
	"query",
	"dbs",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"getblock" => 1,
	"dbs" => 1,
	"query" => 0,

    };

    $self->{ISCOMMAND}  = {
	"getblock" => 1,
	"dbs" => 0,
	"query" => 0,

    };

    $self->{ISMANDATORY}  = {
	"getblock" => 0,
	"dbs" => 0,
	"query" => 1,

    };

    $self->{PROMPT}  = {
	"getblock" => "",
	"dbs" => "",
	"query" => "query (Accession Nr)",

    };

    $self->{ISSTANDOUT}  = {
	"getblock" => 0,
	"dbs" => 0,
	"query" => 0,

    };

    $self->{VLIST}  = {

    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {

    };

    $self->{PRECOND}  = {
	"getblock" => { "perl" => '1' },
	"dbs" => { "perl" => '1' },
	"query" => { "perl" => '1' },

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
	"getblock" => 0,
	"dbs" => 0,
	"query" => 0,

    };

    $self->{ISSIMPLE}  = {
	"getblock" => 0,
	"dbs" => 0,
	"query" => 1,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/getblock.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

