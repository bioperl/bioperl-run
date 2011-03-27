# BioPerl module for Bio::Installer::Generic
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

Bio::Installer::Generic - DESCRIPTION of Object

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


package Bio::Installer::Generic;
use vars qw(@ISA);
use strict;

# Object preamble - inherits from Bio::Root::Root

use Bio::Root::Root;
# Download file
use LWP;
use HTTP::Request::Common;

@ISA = qw(Bio::Root::Root );


=head2 new

 Title   : new
 Usage   : my $obj = new Generic();
 Function: Builds a new Generic object 
 Returns : an instance of Generic
 Args    : -origin_download_dir => from where is going to be downloaded
           -destination_download_dir => where is going to be saved
           -destination_install_dir => where is going to be installed
           -package_name => name of the package to be downloaded
           -directory_name => name of the directory once has been decompressed


=cut

sub new {
    my($class,@args) = @_;

    my $self = $class->SUPER::new(@args);

    my ($origin_download_dir, 
        $destination_download_dir, 
        $destination_install_dir, 
        $package_name, 
        $directory_name) =
            $self->_rearrange( [qw(ORIGIN_DOWNLOAD_DIR 
                                   DESTINATION_DOWNLOAD_DIR 
                                   DESTINATION_INSTALL_DIR 
                                   PACKAGE_NAME 
                                   DIRECTORY_NAME)],
                               @args);
    defined $origin_download_dir && $self->origin_download_dir($origin_download_dir);
    defined $destination_download_dir && $self->destination_download_dir($destination_download_dir);
    defined $destination_install_dir && $self->destination_install_dir($destination_install_dir);
    defined $package_name && $self->package_name($package_name);
    defined $directory_name && $self->directory_name($directory_name);

    return $self;
}


=head2 origin_download_dir

 Title   : origin_download_dir
 Usage   : $obj->origin_download_dir($newval)
 Function: 
 Example : 
 Returns : value of origin_download_dir (a scalar)
 Args    : on set, new value (a scalar or undef, optional)


=cut

sub origin_download_dir{
    my $self = shift;

    return $self->{'origin_download_dir'} = shift if @_;
    return $self->{'origin_download_dir'} || $self->get_default('ORIGIN_DOWNLOAD_DIR');
}


=head2 destination_download_dir

 Title   : destination_download_dir
 Usage   : $obj->destination_download_dir($newval)
 Function: 
 Example : 
 Returns : value of destination_download_dir (a scalar)
 Args    : on set, new value (a scalar or undef, optional)


=cut

sub destination_download_dir{
    my $self = shift;

    return $self->{'destination_download_dir'} = shift if @_;
    return $self->{'destination_download_dir'} || $self->get_default('DESTINATION_DOWNLOAD_DIR');
}


=head2 destination_install_dir

 Title   : destination_install_dir
 Usage   : $obj->destination_install_dir($newval)
 Function: 
 Example : 
 Returns : value of destination_install_dir (a scalar)
 Args    : on set, new value (a scalar or undef, optional)


=cut

sub destination_install_dir{
    my $self = shift;

    return $self->{'destination_install_dir'} = shift if @_;
    return $self->{'destination_install_dir'} || $self->get_default('DESTINATION_INSTALL_DIR');
}


=head2 package_name

 Title   : package_name
 Usage   : $obj->package_name($newval)
 Function: 
 Example : 
 Returns : value of package_name (a scalar)
 Args    : on set, new value (a scalar or undef, optional)


=cut

sub package_name{
    my $self = shift;

    return $self->{'package_name'} = shift if @_;
    return $self->{'package_name'} || $self->get_default('PACKAGE_NAME');
}


=head2 directory_name

 Title   : directory_name
 Usage   : $obj->directory_name($newval)
 Function: 
 Example : 
 Returns : value of directory_name (a scalar)
 Args    : on set, new value (a scalar or undef, optional)


=cut

sub directory_name{
    my $self = shift;

    return $self->{'directory_name'} = shift if @_;
    return $self->{'directory_name'} || $self->get_default('DIRECTORY_NAME');
}


=head2 env_name

 Title   : env_name
 Usage   :
 Function:
 Example :
 Returns : 
 Args    :


=cut

sub env_name{
   my $self = shift;
    return $self->{'env_name'} = shift if @_;
    return $self->{'env_name'} || $self->get_default('ENV_NAME');
}

=head2 _remember_env

 Title   : _remember_env
 Usage   :
 Function:
 Example :
 Returns : 
 Args    :


=cut

sub _remember_env{
   my ($self,@args) = @_;
   my $dir;
   $dir = $self->destination_install_dir;
   $dir =~ s|/$||;
   $dir .= "/" . $self->directory_name . "/" . $self->get_default('BIN_FOLDER');
   my $env_name = $self->env_name;
   print STDERR <<END;


You will need to enable \$$env_name to help bioperl find the
program. This can be done in (at least) two ways:
 1. define an environmental variable \$$env_name:
	export $env_name=$dir
    or
 2. include a definition of an environmental variable $env_name in
     every script that will use the program in the corresponding
     bioperl module.
	BEGIN {\$ENV\{\'$env_name\'\}=$dir; }

END
  ;
}


=head2 _decompress

 Title   : _decompress
 Usage   :
 Function:
 Example :
 Returns : 
 Args    :


=cut

sub _decompress{
   my ($self,@args) = @_;
   my $call;
   my $destination = $self->destination_download_dir . "/" . $self->package_name;;
   my $destination_install_dir = $self->destination_install_dir;
   if (($^O =~ /dec_osf|linux|unix|bsd|solaris|darwin/i)) {
       $call = "tar xzvf $destination --directory=$destination_install_dir";
       system("$call") == 0 or $self->throw("Error when trying to decompress package");
       $call = "rm -f $destination";
       system("$call") == 0 or $self->throw("Error when trying to delete compressed package");
   } else {
       $self->throw("_decompress not yet implemented in this platform");
   }
}


=head2 download

 Title   : download
 Usage   : $installer->download();
 Function:
 Example :
 Returns : 
 Args    :


=cut

sub download{
    my ($self,@args) = @_;
    print "\n\nDownloading package...(this might take a while)\n\n";sleep 1;
    my $file = $self->origin_download_dir;
    $file =~ s|/$||;
    $file .= "/" . $self->package_name;
    my $destination = $self->destination_download_dir;
    $destination =~ s|/$||;
    $destination .= "/" . $self->package_name;;
    my $ua = LWP::UserAgent->new;
    my $response = $ua->request( GET($file), $destination );
    die "Error at $file\n ", $response->status_line, "\n Aborting"
        unless $response->is_success;
    print "Package successfully downloaded at $destination.\n";

    return $self;
}


=head2 uninstall

 Title   : uninstall
 Usage   : $installer->uninstall();
 Function:
 Example :
 Returns : 
 Args    :


=cut

sub uninstall{
   my ($self,@args) = @_;
   my $call;
   my $destination = $self->destination_install_dir;
   $destination =~ s|/$||;
   $destination .= "/" . $self->directory_name;
   print "\n\nUninstalling now: this will delete the installed program\n\n";
   if (($^O =~ /dec_osf|linux|unix|bsd|solaris|darwin/i)) {
       $call = "rm -rf $destination";
       system("$call") == 0 or die "Error when trying to delete installed program $?\n";
   } else {
       $self->throw("uninstall not yet implemented in this platform");
   }
   return $self;
}


1;
