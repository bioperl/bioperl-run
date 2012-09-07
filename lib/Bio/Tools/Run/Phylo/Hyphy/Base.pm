#
# BioPerl module for Bio::Tools::Run::Phylo::Hyphy::Base
#
# Please direct questions and support issues to <bioperl-l@bioperl.org>
#
# Cared for by Albert Vilella <avilella-at-gmail-dot-com>
#
# Copyright Albert Vilella
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Phylo::Hyphy::Base - Hyphy wrapping base methods

=head1 SYNOPSIS

FIXME

=head1 DESCRIPTION

HyPhy ([Hy]pothesis Testing Using [Phy]logenies) package of Sergei
Kosakowsky Pond, Spencer V. Muse, Simon D.W. Frost and Art Poon.  See
http://www.hyphy.org for more information.

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

=head1 AUTHOR - Albert Vilella

Email avilella-at-gmail-dot-com

=head1 CONTRIBUTORS

Additional contributors names and emails here

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut


# Let the code begin...


package Bio::Tools::Run::Phylo::Hyphy::Base;
use strict;
use Bio::Root::Root;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Tools::Run::WrapperBase;
use base qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

=head2 Default Values

Valid and default values are listed below.  The default
values are always the first one listed.  These descriptions are
essentially lifted from the python wrapper or provided by the author.

=cut

our $PROGRAMNAME = 'HYPHYMP';
our $PROGRAM;


BEGIN {
   if( defined $ENV{'HYPHYDIR'} ) {
      $PROGRAM = Bio::Root::IO->catfile($ENV{'HYPHYDIR'},$PROGRAMNAME). ($^O =~ /mswin/i ?'.exe':'');;
   }
}

=head2 program_name

 Title   : program_name
 Usage   : $factory->program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
   return $PROGRAMNAME;
}

=head2 valid_values

 Title   : valid_values
 Usage   : $factory->valid_values()
 Function: returns the possible parameters
 Returns:  an array holding all possible parameters (this needs to be specified per child class).
           Returns an empty array in the base class.
 Args    : None

=cut

sub valid_values {
    return ();
}

=head2 program_dir

 Title   : program_dir
 Usage   : ->program_dir()
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
   return Bio::Root::IO->catfile($ENV{HYPHYDIR}) if $ENV{HYPHYDIR};
}


=head2 new

 Title   : new
 Usage   : my $obj = Bio::Tools::Run::Phylo::Hyphy->new();
 Function: Builds a new Bio::Tools::Run::Phylo::Hyphy object
 Returns : Bio::Tools::Run::Phylo::Hyphy
 Args    : -alignment => the Bio::Align::AlignI object
           -save_tempfiles => boolean to save the generated tempfiles and
                              NOT cleanup after onesself (default FALSE)
           -tree => the Bio::Tree::TreeI object
           -params => a hashref of parameters (all passed to set_parameter)
           -executable => where the hyphy executable resides

See also: L<Bio::Tree::TreeI>, L<Bio::Align::AlignI>

=cut

sub new {
  my($class,@args) = @_;
  my $self = $class->SUPER::new(@args);
    my $versionstring = $self->version();

  return $self;
}


=head2 prepare

 Title   : prepare
 Usage   : my $rundir = $hyphy->prepare($aln);
 Function: prepare the analysis using the default or updated parameters
           the alignment parameter must have been set
 Returns : value of rundir
 Args    : L<Bio::Align::AlignI> object,
           L<Bio::Tree::TreeI> object [optional]

=cut

sub prepare {
   my ($self,$aln,$tree) = @_;
   $tree = $self->tree unless $tree;
   $aln  = $self->alignment unless $aln;
   if( ! $aln ) {
      $self->warn("must have supplied a valid alignment file in order to run hyphy");
      return 0;
   }
   my ($tempdir) = $self->tempdir();
   my ($tempseqFH,$tempalnfile);
   if( ! ref($aln) && -e $aln ) {
      $tempalnfile = $aln;
   } else {
      ($tempseqFH,$tempalnfile) = $self->io->tempfile('-dir' => $tempdir, UNLINK => ($self->save_tempfiles ? 0 : 1));
      $aln->set_displayname_flat(1);
      my $alnout = Bio::AlignIO->new('-format' => 'fasta', '-fh' => $tempseqFH);
      $alnout->write_aln($aln);
      $alnout->close();
      undef $alnout;
      close($tempseqFH);
   }
   $self->{'_params'}{'tempalnfile'} = $tempalnfile;
    # setting a new temp file to hold the run output for debugging
   $self->{'run_output'} = "$tempdir/run_output";
   my $outfile = $self->outfile_name;
   if ($outfile eq "") {
        $outfile = "$tempdir/results.out";
       $self->outfile_name($outfile);
    }
   my ($temptreeFH,$temptreefile);
   if( ! ref($tree) && -e $tree ) {
      $temptreefile = $tree;
   } else {
      ($temptreeFH,$temptreefile) = $self->io->tempfile('-dir' => $tempdir, UNLINK => ($self->save_tempfiles ? 0 : 1));
      my $treeout = Bio::TreeIO->new('-format' => 'newick', '-fh' => $temptreeFH);
      $treeout->write_tree($tree);
      $treeout->close();
      close($temptreeFH);
   }
   $self->{'_params'}{'temptreefile'} = $temptreefile;
   $self->create_wrapper;
   $self->{_prepared} = 1;
   return $tempdir;
}


=head2 create_wrapper

 Title   : create_wrapper
 Usage   : $self->create_wrapper
 Function: It will create the wrapper file that interfaces with the analysis bf file
 Example :
 Returns :
 Args    :


=cut

sub create_wrapper {
   my $redirect = "stdinRedirect";
   my ($self,$batchfile) = @_;
   my $tempdir = $self->tempdir;
   $self->update_ordered_parameters;

   #check version of HYPHY:
   my $versionstring = $self->version();
   $versionstring =~ /.*?(\d+\.\d+).*/;
   my $version = $1;

   my $wrapper = "$tempdir/wrapper.bf";
   open(WRAPPER, ">", $wrapper) or $self->throw("cannot open $wrapper for writing");

   print WRAPPER qq{$redirect = {};\n\n};
   my $counter = sprintf("%02d", 0);
   foreach my $elem (@{ $self->{'_orderedparams'} }) {
      my ($param,$val) = each %$elem;
      if ($val eq "") {
        $val = "$tempdir/$param"; # any undefined parameters must be temporary output files.
      }
      print WRAPPER qq{$redirect ["$counter"] = "$val";\n};
      $counter = sprintf("%02d",$counter+1);
   }
   # This next line is for BatchFile:
    if ((ref ($self)) =~ m/BatchFile/) {
        print WRAPPER "\nExecuteAFile ($batchfile, $redirect);\n";
    } else {
        # Not exactly sure what version of HYPHY caused this change,
        # but Github source changes suggest that it was sometime
        # after version 0.9920060501 was required.
        $batchfile =~ s/"//g; # remove any extra quotes in the batchfile name.
        if ($version >= 0.9920060501) {
           print WRAPPER qq{\nExecuteAFile (HYPHY_LIB_DIRECTORY + "TemplateBatchFiles" + DIRECTORY_SEPARATOR  + "$batchfile", stdinRedirect);\n};
        } else {
           print WRAPPER qq{\nExecuteAFile (HYPHY_BASE_DIRECTORY + "TemplateBatchFiles" + DIRECTORY_SEPARATOR  + "$batchfile", stdinRedirect);\n};
        }
    }

   close(WRAPPER);
   $self->{'_wrapper'} = $wrapper;
}


=head2 run

 Title   : run
 Usage   : my ($rc,$results) = $BatchFile->run();
 Function: run the Hyphy analysis using the specified batchfile and its ordered parameters
 Returns : Return code, Hash
 Args    : none


=cut

sub run {
    my ($self) = @_;

    my $aln = $self->alignment;
    my $tree = $self->tree;
    unless (defined($self->{'_prepared'})) {
        $self->prepare($aln,$tree);
    }
    my $rc = 1;
    my $results = "";
    my $commandstring;
    my $exe = $self->executable();
    unless ($exe && -e $exe && -x _) {
        $self->throw("unable to find or run executable for 'HYPHY'");
    }

    #runs the HYPHY command
    $commandstring = $exe . " BASEPATH=" . $self->program_dir . " " . $self->{'_wrapper'};
    my $pid = open(RUN, "-|", "$commandstring") or $self->throw("Cannot open exe $exe");
    my $waiting = waitpid $pid,0;
    # waitpid will leave a nonzero error in $? if the HYPHY command crashes, so we should bail gracefully.
    my $error = $? & 127;
    if ($error != 0) {
        $self->throw("Error: " . $self->program_name . " ($waiting) quit unexpectedly with signal $error");
    }
    #otherwise, return the results and exit with 1 so that the parent knows we were successful.
    while (my $line = <RUN>) {
        $results .= "$line";
    }
    close(RUN);
    # process the errors from $? and set the error values.
    $rc = $? >> 8;
    if (($results =~ m/error/i) || ($rc == 0)) { # either the child process had an error, or HYPHY put one in the output.
        $rc = 0;
        $self->warn($self->program_name . " reported error $rc - see error_string for the program output");
        $results =~ m/(error.+)/is;
        $self->error_string($1);
    }

    # put these run results into the temp run output file:
    open (OUT, ">", $self->{'run_output'});
    print OUT $results;
    close OUT;

    return ($rc,$results);
}



=head2 error_string

 Title   : error_string
 Usage   : $obj->error_string($newval)
 Function: Where the output from the last analysus run is stored.
 Returns : value of error_string
 Args    : newvalue (optional)


=cut

sub error_string {
   my ($self,$value) = @_;
   if( defined $value) {
      $self->{'error_string'} = $value;
    }
    return $self->{'error_string'};

}

=head2 alignment

 Title   : alignment
 Usage   : $hyphy->alignment($aln);
 Function: Get/Set the L<Bio::Align::AlignI> object
 Returns : L<Bio::Align::AlignI> object
 Comment : We could potentially add support for running directly on a file
           but we shall keep it simple
 See also: L<Bio::SimpleAlign>

=cut

sub alignment {
   my ($self,$aln) = @_;

   if( defined $aln ) {
      if( -e $aln ) {
         $self->{'_alignment'} = $aln;
      } elsif( !ref($aln) || !$aln->isa('Bio::Align::AlignI') ) {
         $self->warn("Must specify a valid Bio::Align::AlignI object to alignment(): you specified a " . ref($aln));
         return;
      } else {
         $self->{'_alignment'} = $aln;
      }
   }
   return $self->{'_alignment'};
}

=head2 tree

 Title   : tree
 Usage   : $hyphy->tree($tree);
 Function: Get/Set the L<Bio::Tree::TreeI> object
 Returns : L<Bio::Tree::TreeI>
 Args    : [optional] $tree => L<Bio::Tree::TreeI>,

 Comment : We could potentially add support for running directly on a file
           but we shall keep it simple
 See also: L<Bio::Tree::Tree>

=cut

sub tree {
   my ($self, $tree, %params) = @_;
   if( defined $tree ) {
      if( !ref($tree) || !$tree->isa('Bio::Tree::TreeI') ) {
         $self->warn("Must specify a valid Bio::Tree::TreeI object to tree(): you specified a " . ref($tree));
         return;
      } else {
          $self->{'_tree'} = $tree;
      }
   }
   return $self->{'_tree'};
}

=head2 get_parameters

 Title   : get_parameters
 Usage   : my %params = $self->get_parameters();
 Function: returns the list of parameters as a hash
 Returns : associative array keyed on parameter names
 Args    : none


=cut

sub get_parameters {
   my ($self) = @_;
   # we're returning a copy of this
   return %{ $self->{'_params'} };
}


=head2 set_parameter

 Title   : set_parameter
 Usage   : $hyphy->set_parameter($param,$val);
 Function: Sets a hyphy parameter, will be validated against
           the valid values.
           The checks can be ignored if one turns off param checks like this:
             $hyphy->no_param_checks(1)
 Returns : boolean if set was success, if verbose is set to -1
           then no warning will be reported
 Args    : $param => name of the parameter
           $value => value to set the parameter to
 See also: L<no_param_checks()>

=cut



sub set_parameter {
   my ($self,$param,$value) = @_;
   # FIXME - add validparams checking
   $self->{'_params'}{$param} = $value;
   return 1;
}

=head2 set_default_parameters

 Title   : set_default_parameters
 Usage   : $obj->set_default_parameters();
 Function: (Re)set the default parameters from the defaults
           (the first value in each array in the valid_values() array)
 Returns : none
 Args    : none


=cut


sub set_default_parameters {
    my ($self) = @_;
    my @validvals = $self->valid_values();
    foreach my $elem (@validvals) {
        keys %$elem; #reset hash iterator
        my ($param,$val) = each %$elem;
        if (ref($val)=~/ARRAY/i ) {
            unless (ref($val->[0])=~/HASH/i) {
                push @{ $self->{'_orderedparams'} }, {$param, $val->[0]};
            } else {
                $val = $val->[0];
            }
        }
        if ( ref($val) =~ /HASH/i ) {
            my $prevparam;
            while (defined($val)) {
                last unless (ref($val) =~ /HASH/i);
                last unless (defined($param));
                $prevparam = $param;
                ($param,$val) = each %{$val};
                push @{ $self->{'_orderedparams'} }, {$prevparam, $param};
                push @{ $self->{'_orderedparams'} }, {$param, $val} if (defined($val));
            }
        } elsif (ref($val) !~ /HASH/i && ref($val) !~ /ARRAY/i) {
            push @{ $self->{'_orderedparams'} }, {$param, $val};
        }
    }
}


=head2 update_ordered_parameters

 Title   : update_ordered_parameters
 Usage   : $hyphy->update_ordered_parameters(0);
 Function: (Re)set the default parameters from the defaults
           (the first value in each array in the
           %VALIDVALUES class variable)
 Returns : none
 Args    : boolean: keep existing parameter values


=cut

sub update_ordered_parameters {
   my ($self) = @_;
   for (my $i=0; $i < scalar(@{$self->{'_orderedparams'}}); $i++) {
      my ($param,$val) = each %{$self->{'_orderedparams'}[$i]};
      if (exists $self->{'_params'}{$param}) {
         $self->{'_orderedparams'}[$i] = {$param, $self->{'_params'}{$param}};
      } else {
         $self->{'_orderedparams'}[$i] = {$param, $val};
      }
   }
}

=head2 outfile_name

 Title   : outfile_name
 Usage   : my $outfile = $hyphy->outfile_name();
 Function: Get/Set the name of the output file for this run
           (if you wanted to do something special)
 Returns : string
 Args    : [optional] string to set value to


=cut

sub outfile_name {
   my $self = shift;
   if( @_ ) {
      return $self->{'_params'}->{'outfile'} = shift @_;
   }
   return $self->{'_params'}->{'outfile'};
}

=head2 version

 Title   : version
 Usage   : $obj->version()
 Function:  Returns the version string from HYPHY
 Returns : string
 Args    : none


=cut

sub version {
    my $self = shift;
    my $tempdir = $self->tempdir;
    if (defined $self->{'_version'}) {
        return $self->{'_version'};
    }
    # if it's not already defined, write out a small batchfile to return the version string, then clean up.
    my $versionbf = "$tempdir/version.bf";
    open(WRAPPER, ">", $versionbf) or $self->throw("cannot open $versionbf for writing");
    print WRAPPER qq{GetString (versionString, HYPHY_VERSION, 2);\nfprintf (stdout, versionString);};
    close(WRAPPER);
    my $exe = $self->executable();
    unless ($exe && -e $exe && -x _) {
        $self->throw("unable to find or run executable for 'HYPHY'");
    }
    my $commandstring = $exe . " BASEPATH=" . $self->program_dir . " " . $versionbf;
    open(RUN, "$commandstring |") or $self->throw("Cannot open exe $exe");
    my $output = <RUN>;
    close(RUN);
    unlink $versionbf;
    $self->{'_version'} = $output;
    return $output;
}

=head2 hyphy_lib_dir

 Title   : hyphy_lib_dir
 Usage   : $obj->hyphy_lib_dir()
 Function: Returns the HYPHY_LIB_DIRECTORY from HYPHY
 Returns : string
 Args    : none


=cut

sub hyphy_lib_dir {
    my $self = shift;
    if (defined $self->{'_hyphylibdir'}) {
        return $self->{'_hyphylibdir'};
    }
    # if it's not already defined, write out a small batchfile to return the version string, then clean up.
    my $hyphylibdirbf = $self->io->catfile($self->tempdir,"hyphylibdir.bf");
    open(WRAPPER, ">", $hyphylibdirbf) or $self->throw("cannot open $hyphylibdirbf for writing");
    print WRAPPER qq{fprintf (stdout, HYPHY_LIB_DIRECTORY);};
    close(WRAPPER);
    my $exe = $self->executable();
    unless ($exe && -e $exe && -x _) {
        $self->throw("unable to find or run executable for 'HYPHY'");
    }
    my $commandstring = $exe . " BASEPATH=" . $self->program_dir . " " . $hyphylibdirbf;
    open(RUN, "$commandstring |") or $self->throw("Cannot open exe $exe");
    my $output = <RUN>;
    close(RUN);
    unlink $hyphylibdirbf;
    $self->{'_hyphylibdir'} = $output;
    return $output;
}


1;
