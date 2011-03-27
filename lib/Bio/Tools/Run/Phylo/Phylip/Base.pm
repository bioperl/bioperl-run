# $Id $
#
# BioPerl module for Bio::Tools::Run::Phylo::Phylip::Base
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Jason Stajich <jason-AT-bioperl_DOT_org>
#
# Copyright Jason Stajich
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Phylo::Phylip::Base - Base object for Phylip modules

=head1 SYNOPSIS

# Do not use directly
# This module is for setting basic data sets for the Phylip wrapper
# modules

=head1 DESCRIPTION

This module is just a base object for Bioperl Phylip wrappers.

IMPORTANT PHYLIP VERSION ISSUES
By default we assume you have Phylip 3.6 installed, if you
have installed Phylip 3.5 you need to set the environment variable
PHYLIPVERSION


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
of the bugs and their resolution. Bug reports can be submitted via the
web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Jason Stajich

Email jason-at-bioperl.org

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut


# Let the code begin...


package Bio::Tools::Run::Phylo::Phylip::Base;
use vars qw(@ISA %DEFAULT %FILENAME);
use strict;

BEGIN {
    eval { require File::Spec };
    if( $@) { Bio::Root::RootI->throw("Must have installed File::Spec to run Bio::Tools::Run::Phylo::Phylip tools");
  }
    
}

use Bio::Root::Root;
use Bio::Tools::Run::WrapperBase;
use Bio::Tools::Run::Phylo::Phylip::PhylipConf;
@ISA = qw(Bio::Root::Root  Bio::Tools::Run::WrapperBase);

BEGIN {
    %DEFAULT = ( 
		 'VERSION'   => $ENV{'PHYLIPVERSION'} || '3.6',
		 );
    %FILENAME = %Bio::Tools::Run::Phylo::Phylip::PhylipConf::FileName;
}

=head2 new

 Title   : new
 Usage   : my $obj = Bio::Tools::Run::Phylo::Phylip::Base->new();
 Function: Builds a new Bio::Tools::Run::Phylo::Phylip::Base object 
 Returns : an instance of Bio::Tools::Run::Phylo::Phylip::Base
 Args    :

=cut

=head2 outfile

 Title   : outfile
 Usage   : $obj->outfile($newval)
 Function: Get/Set default PHYLIP outfile name ('outfile' usually)
           Changing this is only necessary when you have compiled
           PHYLIP to use a different filename for the default 'outfile'
           This will not change the default output filename by 
           PHYLIP
 Returns : value of outfile
 Args    : newvalue (optional)


=cut

sub outfile{
   my $self = shift;
   $self->{'_outfile'} = shift if @_;
   return $self->{'_outfile'} || $FILENAME{$self->version}{'OUTFILE'}
}


=head2 treefile

 Title   : treefile
 Usage   : $obj->treefile($newval)
 Function: Get/Set the default PHYLIP treefile name ('treefile' usually)
 Returns : value of treefile
 Args    : newvalue (optional)


=cut

sub treefile{
   my $self = shift;
   $self->{'_treefile'} = shift if @_;
   return $self->{'_treefile'} || $FILENAME{$self->version}{'TREEFILE'};
}


=head2 fontfile

 Title   : fontfile
 Usage   : $obj->fontfile($newval)
 Function: Get/Set the fontfile
 Returns : value of fontfile (a scalar)
 Args    : on set, new value (a scalar or undef, optional)


=cut

sub fontfile{
    my $self = shift;

    return $self->{'fontfile'} = shift if @_;
    return $self->{'fontfile'} ;
}

=head2 plotfile

 Title   : plotfile
 Usage   : $obj->plotfile($newval)
 Function: Get/Set the plotfile
 Returns : value of plotfile (a scalar)
 Args    : on set, new value (a scalar or undef, optional)


=cut

sub plotfile {
    my $self = shift;

    return $self->{'plotfile'} = shift if @_;
    return $self->{'plotfile'} || $FILENAME{$self->version}{'PLOTFILE'};
}

=head2 version

 Title   : version
 Usage   : $obj->version($newval)
 Function: Get/Set the version
 Returns : value of version (a scalar)
 Args    : on set, new value (a scalar or undef, optional)


=cut

sub version {
    my $self = shift;

    return $self->{'version'} = shift if @_;
    return $self->{'version'} || $DEFAULT{'VERSION'};
}
1;
