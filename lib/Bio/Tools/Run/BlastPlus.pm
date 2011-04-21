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

  http://redmine.open-bio.org/projects/bioperl/

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

=head2 program_version()

 Title   : program_version
 Usage   : $version = $bedtools_fac->program_version()
 Function: Returns the program version (if available)
 Returns : string representing location and version of the program
 Note    : this works around the WrapperBase::version() method conflicting with
           the -version parameter for SABlast (good argument for not having
           getter/setters for these)

=cut

=head2 package_version()

 Title   : package_version
 Usage   : $version = $bedtools_fac->version()
 Function: Returns the BLAST+ package version (if available)
 Returns : string representing BLAST+ package version (may differ from version())

=cut

sub program_version {
	my ($self) = @_;
    if (!defined $self->{program_version}) {
        $self->_version;
    }
    $self->{program_version} || '';
}

sub package_version {
	my ($self) = @_;
    if (!defined $self->{package_version}) {
        $self->_version;
    }
    $self->{package_version} || '';
}

sub _version {
    my $self = shift;
    my ($in, $out, $err);

	# Get program executable
	my $exe = $self->executable;
	my @ipc_args = ( $exe, '-version');
	
	eval {
		IPC::Run::run(\@ipc_args, \$in, \$out, \$err) or
			die ("There was a problem running $exe : $!");
	};
	
    if ($out =~ /blastdbcmd\:\s+(\S+)\nPackage\:\s+([^,]+)/xms) {
        @{$self}{qw(program_version package_version)} = ($1, $2);
    } else {
        $self->throw("Unknown version output: $out");
    }
}

1;
