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

  http://redmine.open-bio.org/projects/bioperl/

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
use Bio::Root::Root;
use Bio::Tools::Run::Samtools::Config;

# currently an AssemblerBase object, but the methods we need from 
# there should really go in an updated WrapperBase.../maj

use base qw(Bio::Tools::Run::WrapperBase Bio::Root::Root);
use Bio::Tools::Run::WrapperBase::CommandExts;

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
    my ($class, @args) = @_;
    $program_dir ||= $ENV{SAMTOOLSDIR};
    my $self = $class->SUPER::new(@args);
    return $self;
}

sub run { shift->_run(@_) }
1;
