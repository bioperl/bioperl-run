# $Id$
#
# BioPerl module for Bio::Tools::Run::Samtools
#
# Please direct questions and support issues to <bioperl-l@bioperl.org>
#
# Cared for by Mark A. Jensen <maj -at- fortinbras -dot- us>
#
# Copyright Mark A. Jensen
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Samtools - a run wrapper for the samtools suite *BETA*

=head1 SYNOPSIS

 # convert a sam to a bam
 $samt = Bio::Tools::Run::Samtools( -command => 'view', 
                                    -sam_input => 1,
                                    -bam_output => 1 );
 $samt->run( -bam => "mysam.sam", -out => "mysam.bam" );
 # sort it
 $samt = Bio::Tools::Run::Samtools( -command => 'sort' );
 $samt->run( -bam => "mysam.bam", -pfx => "mysam.srt" );
 # now create an assembly
 $assy = Bio::IO::Assembly->new( -file => "mysam.srt.bam",
                                 -refdb => "myref.fas" );

=head1 DESCRIPTION

This is a wrapper for running samtools, a suite of large-alignment
reading and manipulation programs available at
L<http://samtools.sourceforge.net/>.

=head1 RUNNING COMMANDS

To run a C<samtools>
command, construct a run factory, specifying the desired command using
the C<-command> argument in the factory constructor, along with
options specific to that command (see L</OPTIONS>):

 $samt = Bio::Tools::Run::Samtools->new( -command => 'view',
                                         -sam_input => 1,
                                         -bam_output => 1);

To execute, use the C<run()> method. Input and output files are
specified in the arguments of C<run()> (see L</FILES>):

 $samt->run( -bam => "mysam.sam", -out => "mysam.bam" );

=head1 OPTIONS

C<samtools> is complex, with many subprograms (commands) and command-line
options and file specs for each. This module attempts to provide
commands and options comprehensively. You can browse the choices like so:

 $samt = Bio::Tools::Run::Samtools->new( -command => 'pileup' );
 # all samtools commands
 @all_commands = $samt->available_parameters('commands'); 
 @all_commands = $samt->available_commands; # alias
 # just for pileup
 @pup_params = $samt->available_parameters('params');
 @pup_switches = $samt->available_parameters('switches');
 @pup_all_options = $samt->available_parameters();

Reasonably mnemonic names have been assigned to the single-letter
command line options. These are the names returned by
C<available_parameters>, and can be used in the factory constructor
like typical BioPerl named parameters.

See L<http://samtools.sourceforge.net/samtools.shtml> for the gory details.

=head1 FILES

When a command requires filenames, these are provided to the
C<run()> method, not the constructor (C<new()>). To see the set of
files required by a command, use C<available_parameters('filespec')>
or the alias C<filespec()>:

  $samt = Bio::Tools::Run::Samtools->new( -command => 'view' );
  @filespec = $samt->filespec;

This example returns the following array:

 bam
 >out

This indicates that the bam/sam file (bam) and the output file (out)
MUST be specified in the C<run()> argument list:

 $samt->run( -bam => 'mysam.sam', -out => 'mysam.cvt' );

If files are not specified per the filespec, text sent to STDOUT and
STDERR is saved and is accessible with C<$bwafac->stdout()> and
C<$bwafac->stderr()>.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support

Please direct usage questions or support issues to the mailing list:

L<bioperl-l@bioperl.org>

rather than to the module maintainer directly. Many experienced and
reponsive experts will be able look at the problem and quickly
address it. Please include a thorough description of the problem
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
the web:

  http://bugzilla.open-bio.org/

=head1 AUTHOR - Mark A. Jensen

Email maj -at- fortinbras -dot- us

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

# Let the code begin...
package Bio::Tools::Run::Samtools;
use strict;
use warnings;
use IPC::Run;
use lib '../../..';
use Bio::Root::Root;
use Bio::Tools::Run::Samtools::Config;

# currently an AssemblerBase object, but the methods we need from 
# there should really go in an updated WrapperBase.../maj

use base qw(Bio::Root::Root Bio::Tools::Run::AssemblerBase);

our $program_name = 'samtools';
our $use_dash = 1;
our $join = ' ';

=head2 new

 Title   : new
 Usage   : my $obj = new Bio::Tools::Run::Samtools();
 Function: Builds a new Bio::Tools::Run::Samtools object
 Returns : an instance of Bio::Tools::Run::Samtools
 Args    :

=cut

sub new {
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);
    $self->parameters_changed(1); 
    $self->_register_program_commands( \@program_commands, \%command_prefixes );
    unless (grep /command/, @args) {
	push @args, '-command', 'run';
    }
    $self->_set_program_options(\@args, \@program_params, \@program_switches,
				\%param_translation, undef, $use_dash, $join);
    $self->program_name($program_name) if not defined $self->program_name();
    if ($^O =~ /cygwin/) {
	my @kludge = `PATH=\$PATH:/usr/bin:/usr/local/bin which $program_name`;
	chomp $kludge[0];
	$self->program_name($kludge[0]);
    }
    $self->parameters_changed(1); # set on instantiation, per Bio::ParameterBaseI
    return $self;
}

=head2 run()

 Title   : run
 Usage   : $obj->run( @file_args )
 Function: Run a samtools command as specified during object contruction
 Returns : 
 Args    : a specification of the files to operate on:

=cut

sub run {
    my ($self, @args) = @_;
    # _translate_params will provide an array of command/parameters/switches
    # -- these are set at object construction
    # to set up the run, need to add the files to the call
    # -- provide these as arguments to this function
    $self->_check_executable;
    my $cmd = $self->command if $self->can('command');
    $self->throw("No samtools command specified for the object") unless $cmd;
    # setup files necessary for this command
    my $filespec = $command_files{$cmd};
    $self->throw("No command-line file specification is defined for command '$cmd'; check Bio::Tools::Run::Samtools::Config") unless $filespec;

    # parse args based on filespec
    # require named args
    $self->throw("Named args are required") unless !(@args % 2);
    s/^-// for @args;
    my %args = @args; 
    # validate
    my @req = map { 
	my $s = $_; 
	$s =~ s/^[012]?[<>]//;
	$s =~ s/[^a-zA-Z0-9_]//g; 
	$s
    } grep !/[#]/, @$filespec;
    !defined($args{$_}) && $self->throw("Required filearg '$_' not specified") for @req;
    # set up redirects
    my ($in, $out, $err);
    for (@$filespec) {
	m/^1?>(.*)/ && do {
	    defined($args{$1}) && ( open($out,">", $args{$1}) or $self->throw("Open for write error : $!"));
	    next;
	};
	m/^2>#?(.*)/ && do {
	    defined($args{$1}) && (open($err, ">", $args{$1}) or $self->throw("Open for write error : $!"));
	    next;
	};
	m/^<#?(.*)/ && do {
	    defined($args{$1}) && (open($in, "<", $args{$1}) or $self->throw("Open for read error : $!"));
	    next;
	}
    }
    my $dum;
    $in || ($in = \$dum);
    $out || ($out = \$self->{'stdout'});
    $err || ($err = \$self->{'stderr'});
    
    # Get program executable
    my $exe = $self->executable;
    # Get command-line options
    my $options = $self->_translate_params();
    # Get file specs sans redirects in correct order
    my @specs = map { 
	my $s = $_; 
	$s =~ s/[^a-zA-Z0-9_]//g; 
	$s
    } grep !/[<>]/, @$filespec;
    my @files = @args{@specs};
    # expand arrayrefs
    my $l = $#files;
    for (0..$l) {
	splice(@files, $_, 1, @{$files[$_]}) if (ref($files[$_]) eq 'ARRAY');
    }
    @files = map { defined $_ ? $_ : () } @files; # squish undefs
    my @ipc_args = ( $exe, @$options, @files );

    eval {
	IPC::Run::run(\@ipc_args, $in, $out, $err) or
	    die ("There was a problem running $exe : $!");
    };
    if ($@) {
	$self->throw("$exe call crashed: $@");
    }

    # return arguments as specified on call
    return @args;
}

=head2 stdout()

 Title   : stdout
 Usage   : $fac->stdout()
 Function: store the output from STDOUT for the run, 
           if no file specified in run_maq()
 Example : 
 Returns : scalar string
 Args    : on set, new value (a scalar or undef, optional)

=cut

sub stdout {
    my $self = shift;
    
    return $self->{'stdout'} = shift if @_;
    return $self->{'stdout'};
}

=head2 stderr()

 Title   : stderr
 Usage   : $fac->stderr()
 Function: store the output from STDERR for the run, 
           if no file is specified in run_maq()
 Example : 
 Returns : scalar string
 Args    : on set, new value (a scalar or undef, optional)

=cut

sub stderr {
    my $self = shift;
    
    return $self->{'stderr'} = shift if @_;
    return $self->{'stderr'};
}

1;
