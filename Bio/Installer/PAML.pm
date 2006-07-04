#!/usr/local/bin/perl

# BioPerl module for Bio::Installer::PAML
#
# Cared for by Albert Vilella
#
# Copyright Albert Vilella
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Installer::PAML - DESCRIPTION of Object

=head1 SYNOPSIS

Give standard usage here

=head1 DESCRIPTION

Describe the object here

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
the web:

  http://bugzilla.open-bio.org/

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


package Bio::Installer::PAML;
use vars qw(@ISA %DEFAULTS);
use strict;

# Object preamble - inherits from Bio::Root::Root

use Bio::Root::Root;
use Bio::Installer::Generic;

@ISA = qw(Bio::Installer::Generic );

BEGIN {
    %DEFAULTS = ( 'ORIGIN_DOWNLOAD_DIR' => 'ftp://abacus.gene.ucl.ac.uk/pub/paml/',
                  'BIN_FOLDER' => 'src',
                  'DESTINATION_DOWNLOAD_DIR' => '/tmp',
                  'DESTINATION_INSTALL_DIR' => "$ENV{'HOME'}",
                  'PACKAGE_NAME' => 'paml3.14a.tar.gz',
                  'DIRECTORY_NAME' => 'paml3.14',
                  'ENV_NAME' => 'PAMLDIR',
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
   $self->_decompress;
   $self->_tweak_paml_makefile;
   $self->_execute_paml_makefile;
   $self->_remember_env;
}


=head2 _execute_paml_makefile

 Title   : _execute_paml_makefile
 Usage   :
 Function:
 Example :
 Returns : 
 Args    :


=cut

sub _execute_paml_makefile{
   my ($self,@args) = @_;
   my $call;

   my $destination = $self->destination_install_dir . "/" . $self->directory_name . "/src";
   chdir $destination or $self->throw("Cant cd to $destination");
   print "\n\nCompiling now... (this might take a while)\n\n";
   if (($^O =~ /dec_osf|linux|unix|bsd|solaris|darwin/i)) {
       $call = "make";
       system("$call") == 0 or $self->throw("Error when trying to run make");
   } else {
       $self->throw("_execute_paml_makefile not yet implemented in this platform");
   }
}


=head2 _tweak_paml_makefile

 Title   : _tweak_paml_makefile
 Usage   :
 Function:
 Example :
 Returns : 
 Args    :


=cut

sub _tweak_paml_makefile{
    my ($self,@args) = @_;
    my $gcc3;
    my $return = qx/gcc -v 2>&1/;
    if ($return =~ /version 3/) {
        $return = `cat /proc/cpuinfo`;
        if( ($return =~ /mmx/) || ($return =~ /3dnow/)) {
            my $destination = $self->destination_install_dir . "/" . $self->directory_name . "/src";
            chdir $destination or $self->throw("Cant cd to $destination");
            my $new = "Makefile";
            open(OLD, "< Makefile.UNIX")         or  $self->throw("can't open Makefile.UNIX");
            open(NEW, "> $new")         or $self->throw("can't open $new");
            while (<OLD>) {
                # change $_, then...
                $_ =~ s/CFLAGS = -O3/\# CFLAGS = -O3/g;
                if( $return =~ /3dnow/ ) {
                    $_ =~ s/#CFLAGS = -march=athlon -mcpu=athlon -O4 -funroll-loops -fomit-frame-pointer -finline-functions/CFLAGS = -march=athlon -mcpu=athlon -O4 -funroll-loops -fomit-frame-pointer -finline-functions/g;
                } elsif( $return =~ /mmx/ ) {
                    $_ =~ s/#CFLAGS = -march=pentiumpro -mcpu=pentiumpro -O4 -funroll-loops -fomit-frame-pointer -finline-functions/CFLAGS = -march=pentiumpro -mcpu=pentiumpro -O4 -funroll-loops -fomit-frame-pointer -finline-functions/g;
                }
                print NEW $_ or $self->throw("can't write $new");
            }
            close(OLD)                  or $self->throw("can't close Makefile.UNIX");
            close(NEW)                  or $self->throw("can't close $new");
        }
    }


}


1;
