
=head1 NAME

Bio::Tools::Run::PiseApplication::readnexus

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::readnexus

      Bioperl class for:

	readnexus	Convert NEXUS files into fasta/mega format (W. Fischer)

      Parameters:


		readnexus (String)


		seq (Sequence)
			Nexus File
			pipe: nexus_file

		fastafile (Results)

			pipe: readseq_ok_alig

		megfile (Results)


		outformat (Excl)
			Output format

=cut

#'
package Bio::Tools::Run::PiseApplication::readnexus;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $readnexus = Bio::Tools::Run::PiseApplication::readnexus->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::readnexus object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $readnexus = $factory->program('readnexus');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::readnexus.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/readnexus.pm

    $self->{COMMAND}   = "readnexus";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "readnexus";

    $self->{DESCRIPTION}   = "Convert NEXUS files into fasta/mega format";

    $self->{AUTHORS}   = "W. Fischer";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"readnexus",
	"seq",
	"fastafile",
	"megfile",
	"outformat",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"readnexus",
	"seq", 	# Nexus File
	"fastafile",
	"megfile",
	"outformat", 	# Output format

    ];

    $self->{TYPE}  = {
	"readnexus" => 'String',
	"seq" => 'Sequence',
	"fastafile" => 'Results',
	"megfile" => 'Results',
	"outformat" => 'Excl',

    };

    $self->{FORMAT}  = {
	"readnexus" => {
		"seqlab" => 'readnexus',
		"perl" => '"readnexus"',
	},
	"seq" => {
		"perl" => '" $value"',
	},
	"fastafile" => {
	},
	"megfile" => {
	},
	"outformat" => {
		"perl" => '($value)? " $value" : ""',
	},

    };

    $self->{FILENAMES}  = {
	"fastafile" => '*.fasta',
	"megfile" => '*.meg',

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"readnexus" => 0,
	"seq" => 2,
	"outformat" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"readnexus",
	"fastafile",
	"megfile",
	"outformat",
	"seq",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"readnexus" => 1,
	"seq" => 0,
	"fastafile" => 0,
	"megfile" => 0,
	"outformat" => 0,

    };

    $self->{ISCOMMAND}  = {
	"readnexus" => 1,
	"seq" => 0,
	"fastafile" => 0,
	"megfile" => 0,
	"outformat" => 0,

    };

    $self->{ISMANDATORY}  = {
	"readnexus" => 0,
	"seq" => 1,
	"fastafile" => 0,
	"megfile" => 0,
	"outformat" => 0,

    };

    $self->{PROMPT}  = {
	"readnexus" => "",
	"seq" => "Nexus File",
	"fastafile" => "",
	"megfile" => "",
	"outformat" => "Output format",

    };

    $self->{ISSTANDOUT}  = {
	"readnexus" => 0,
	"seq" => 0,
	"fastafile" => 0,
	"megfile" => 0,
	"outformat" => 0,

    };

    $self->{VLIST}  = {

	"outformat" => ['-f','fasta (-f)','-m','mega (-m)',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outformat" => '-f',

    };

    $self->{PRECOND}  = {
	"readnexus" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"fastafile" => { "perl" => '1' },
	"megfile" => { "perl" => '1' },
	"outformat" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"fastafile" => {
		 '1' => "readseq_ok_alig",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seq" => {
		 "nexus_file" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"readnexus" => 0,
	"seq" => 0,
	"fastafile" => 0,
	"megfile" => 0,
	"outformat" => 0,

    };

    $self->{ISSIMPLE}  = {
	"readnexus" => 1,
	"seq" => 1,
	"fastafile" => 0,
	"megfile" => 0,
	"outformat" => 1,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/readnexus.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

