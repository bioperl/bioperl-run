
=head1 NAME

Bio::Tools::Run::PiseApplication::con_filter

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::con_filter

      Bioperl class for:

	CONSENSUS	con-filter - filters consensus ouput (Hertz, Stormo)

      Parameters:


		con_filter (String)
			

		consensus_results (InFile)
			consensus results file
			pipe: consensus_results

		header (Excl)
			Heading (-nh or -oh)

=cut

#'
package Bio::Tools::Run::PiseApplication::con_filter;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $con_filter = Bio::Tools::Run::PiseApplication::con_filter->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::con_filter object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $con_filter = $factory->program('con_filter');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::con_filter.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/con_filter.pm

    $self->{COMMAND}   = "con_filter";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "CONSENSUS";

    $self->{DESCRIPTION}   = "con-filter - filters consensus ouput";

    $self->{AUTHORS}   = "Hertz, Stormo";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"con_filter",
	"consensus_results",
	"header",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"con_filter",
	"consensus_results", 	# consensus results file
	"header", 	# Heading (-nh or -oh)

    ];

    $self->{TYPE}  = {
	"con_filter" => 'String',
	"consensus_results" => 'InFile',
	"header" => 'Excl',

    };

    $self->{FORMAT}  = {
	"con_filter" => {
		"perl" => '"con-filter "',
	},
	"consensus_results" => {
		"perl" => '" $value"',
	},
	"header" => {
		"perl" => '($value)? " $value" : ""',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"con_filter" => 0,
	"consensus_results" => 2,
	"header" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"con_filter",
	"header",
	"consensus_results",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"con_filter" => 1,
	"consensus_results" => 0,
	"header" => 0,

    };

    $self->{ISCOMMAND}  = {
	"con_filter" => 1,
	"consensus_results" => 0,
	"header" => 0,

    };

    $self->{ISMANDATORY}  = {
	"con_filter" => 0,
	"consensus_results" => 1,
	"header" => 0,

    };

    $self->{PROMPT}  = {
	"con_filter" => "",
	"consensus_results" => "consensus results file",
	"header" => "Heading (-nh or -oh)",

    };

    $self->{ISSTANDOUT}  = {
	"con_filter" => 0,
	"consensus_results" => 0,
	"header" => 0,

    };

    $self->{VLIST}  = {

	"header" => ['-nh','-nh: do not print the output heading','-oh','-oh: print only the output heading',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {

    };

    $self->{PRECOND}  = {
	"con_filter" => { "perl" => '1' },
	"consensus_results" => { "perl" => '1' },
	"header" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"consensus_results" => {
		 "consensus_results" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"con_filter" => 0,
	"consensus_results" => 0,
	"header" => 0,

    };

    $self->{ISSIMPLE}  = {
	"con_filter" => 0,
	"consensus_results" => 1,
	"header" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/con_filter.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

