
=head1 NAME

Bio::Tools::Run::PiseApplication::prodom

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::prodom

      Bioperl class for:

	ProDom	PRODOM Protein Domain Database (Sonnhammer & Kahn)

	References:

		Sonnhammer ELL and Kahn D. The modular arrangement of proteins as Inferred from Analysis of Homology. Protein Science 3:482-492 (1994).


      Parameters:


		prodom (Excl)
			Prodom program

		entry_name (String)
			Entry name of a known protein

		family_number (String)
			(or) Family number

=cut

#'
package Bio::Tools::Run::PiseApplication::prodom;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $prodom = Bio::Tools::Run::PiseApplication::prodom->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::prodom object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $prodom = $factory->program('prodom');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::prodom.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/prodom.pm

    $self->{COMMAND}   = "prodom";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "ProDom";

    $self->{DESCRIPTION}   = "PRODOM Protein Domain Database";

    $self->{AUTHORS}   = "Sonnhammer & Kahn";

    $self->{REFERENCE}   = [

         "Sonnhammer ELL and Kahn D. The modular arrangement of proteins as Inferred from Analysis of Homology. Protein Science 3:482-492 (1994).",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"prodom",
	"entry_name",
	"family_number",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"prodom", 	# Prodom program
	"entry_name", 	# Entry name of a known protein
	"family_number", 	# (or) Family number

    ];

    $self->{TYPE}  = {
	"prodom" => 'Excl',
	"entry_name" => 'String',
	"family_number" => 'String',

    };

    $self->{FORMAT}  = {
	"prodom" => {
		"perl" => '"$value"',
	},
	"entry_name" => {
		"perl" => '" $value"',
	},
	"family_number" => {
		"perl" => '" $value"',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"prodom" => 1,
	"entry_name" => 2,
	"family_number" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"prodom",
	"entry_name",
	"family_number",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"prodom" => 0,
	"entry_name" => 0,
	"family_number" => 0,

    };

    $self->{ISCOMMAND}  = {
	"prodom" => 1,
	"entry_name" => 0,
	"family_number" => 0,

    };

    $self->{ISMANDATORY}  = {
	"prodom" => 1,
	"entry_name" => 1,
	"family_number" => 1,

    };

    $self->{PROMPT}  = {
	"prodom" => "Prodom program",
	"entry_name" => "Entry name of a known protein",
	"family_number" => "(or) Family number",

    };

    $self->{ISSTANDOUT}  = {
	"prodom" => 0,
	"entry_name" => 0,
	"family_number" => 0,

    };

    $self->{VLIST}  = {

	"prodom" => ['askdom','askdom: Query ProDom for the domain organization of a known protein','fetchmul','fetchmul: Fetch a Domain Family','fetchcon','fetchcon: Fetch a Domain Family Consensus Sequence',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"prodom" => 'askdom',

    };

    $self->{PRECOND}  = {
	"prodom" => { "perl" => '1' },
	"entry_name" => {
		"perl" => '$prodom eq "askdom"',
	},
	"family_number" => {
		"perl" => '$prodom ne "askdom"',
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
	"prodom" => 0,
	"entry_name" => 0,
	"family_number" => 0,

    };

    $self->{ISSIMPLE}  = {
	"prodom" => 0,
	"entry_name" => 1,
	"family_number" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"prodom" => [
		"You can also perform a Blast search on the prodom database (see various Blast forms on this server).",
	],
	"entry_name" => [
		"Query ProDom for the domain organization of a known protein, given its entry name",
	],
	"family_number" => [
		"Family number which description or consensus sequence you want by fetchmul or fetchcon.",
		"Family numbers can be given by a first query to askdom.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/prodom.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

