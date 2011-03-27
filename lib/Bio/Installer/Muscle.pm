
# BioPerl module for Bio::Installer::Muscle
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Albert Vilella
#
# Copyright Albert Vilella
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Installer::Muscle - DESCRIPTION of Object

=head1 SYNOPSIS

Give standard usage here

=head1 DESCRIPTION

Describe the object here

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

=head2 Support 

Please direct usage questions or support issues to the mailing list:

I<bioperl-l@bioperl.org>

rather than to the module maintainer directly. Many experienced and 
reponsive experts will be able look at the problem and quickly 
address it. Please include a thorough description of the problem 
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
the web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Albert Vilella

Email avilella-AT-gmail-DOT-com

Describe contact details here

=head1 CONTRIBUTORS

Additional contributors names and emails here

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut


# Let the code begin...


package Bio::Installer::Muscle;
use vars qw(@ISA %DEFAULTS);
use strict;

# Object preamble - inherits from Bio::Root::Root

use Bio::Root::Root;
use Bio::Installer::Generic;

@ISA = qw(Bio::Installer::Generic );

BEGIN {
    %DEFAULTS = ( 'ORIGIN_DOWNLOAD_DIR' => 'http://igs-server.cnrs-mrs.fr/~cnotred/Packages',
                  'BIN_FOLDER' => 'bin',
                  'DESTINATION_DOWNLOAD_DIR' => '/tmp',
                  'DESTINATION_INSTALL_DIR' => "$ENV{'HOME'}",
                  'PACKAGE_NAME' => 'T-COFFEE_distribution.tar.gz',
                  'DIRECTORY_NAME' => 'T-COFFEE_distribution_Version_1.37',
                  'ENV_NAME' => 'MUSCLEDIR',
                );
}


=head2 get_default 

 Title   : get_default 
 Usage   :
 Function:
 Example :
 Returns : 
 Args    :


=cut

sub get_default {
    my $self = shift;
    my $param = shift;
    return $DEFAULTS{$param};
}


=head2 install

 Title   : install
 Usage   : $installer->install();
 Function:
 Example :
 Returns : 
 Args    :


=cut

sub install{
   my ($self,@args) = @_;
   my $dir;
   $self->_decompress;
   $self->_execute_Muscle_install_script;
   $dir = $self->destination_install_dir;
   $self->_remember_env;
}


=head2 _execute_Muscle_install_script

 Title   : _execute_Muscle_install_script
 Usage   :
 Function:
 Example :
 Returns : 
 Args    :


=cut

sub _execute_Muscle_install_script{
   my ($self,@args) = @_;
   my $call;

   my $destination = $self->destination_install_dir;
   $destination =~ s|/$||;
   $destination .= "/" . $self->directory_name;

   chdir $destination or die "Cant cd to $destination $!\n";
   print "\n\nCompiling now... (this might take a while)\n\n";
   $call = "sh install";
   system("$call") == 0 or die "Error when trying to run install script $?\n";


}


1;
