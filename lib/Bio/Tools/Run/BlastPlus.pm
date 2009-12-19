# $Id$
#
# BioPerl module for Bio::Tools::Run::BlastPlus
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

Bio::Tools::Run::BlastPlus - A wrapper for NCBI's blast+ suite

=head1 SYNOPSIS

Give standard usage here

=head1 DESCRIPTION

Blast+ is NCBI's successor to the C<blastall> family of programs. 

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

Describe contact details here

=head1 CONTRIBUTORS

Additional contributors names and emails here

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

# Let the code begin...


package Bio::Tools::Run::BlastPlus;
use strict;
use warnings;

use lib '../../..';
use Bio::Root::Root;
use Bio::Tools::Run::BlastPlus::Config;
use Bio::Tools::Run::WrapperBase;
use Bio::Tools::Run::WrapperBase::CommandExts;

use base qw(Bio::Tools::Run::WrapperBase Bio::Root::Root);

=head2 new

 Title   : new
 Usage   : my $obj = new Bio::Tools::Run::BlastPlus();
 Function: Builds a new Bio::Tools::Run::BlastPlus object
 Returns : an instance of Bio::Tools::Run::BlastPlus
 Args    :

=cut

sub new {
    my ($class,@args) = @_;
    $program_dir ||= $ENV{BLASTPLUSDIR};
    my $self = $class->SUPER::new(@args);
    return $self;
}


# making this work: 
# this is truly a suite of programs: no "front-end" command-line application.
# so need to emulate a front-end application in the wrapper
# what is, e.g., $program_name? Also, need to make sure that the 
# right executables are found and run.
# could do this through program_dir
#
# could have a pseudo-program "*blast", which provides a meaningful name, 
# but * indicates that a hash of executables must be maintained, and that
# commands are really programs, and the correct executable must be looked up 
# and run.
#
# so if  $program_name =~ /^\*/, @program_commands are real programs, and 
# we need to find their executables and store in a hash.

# problem: that WrapperBase really set up to handle only one executable at a time
# so we can (1)override the WrapperBase methods, or (2) add our own.



1;
