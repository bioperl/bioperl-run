# $Id$
#
# BioPerl module for Bio::Tools::Run::Phylo::Molphy::ProtML
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

Bio::Tools::Run::Phylo::Molphy::ProtML - A wrapper for the Molphy pkg app ProtML

=head1 SYNOPSIS

  use Bio::AlignIO;
  use Bio::TreeIO;
  use Bio::Tools::Run::Phylo::Molphy::ProtML;

  my %args = ( 'models' => 'jtt',
               'search' => 'quick',
               'other'  => [ '-information', '-w'] );
  my $verbose = 0; # change to 1 if you want some debugging output
  my $protml = Bio::Tools::Run::Phylo::Molphy::ProtML->new(-verbose => $verbose,
  							  -flags   => \%args);

  die("cannot find the protml executable") unless $protml->executable;

  # read in a previously built protein alignment
  my $in = Bio::AlignIO->new(-format => 'clustalw',
  			    -file   => 't/data/cel-cbr-fam.aln');
  my $aln = $in->next_aln;
  $protml->alignment($aln);

  my ($rc,$results) = $protml->run();

  # This may be a bit of overkill, but it is possible we could
  # have a bunch of results and $results is a
  # Bio::Tools::Phylo::Molphy object

  my $r = $results->next_result;
  # $r is a Bio::Tools::Phylo::Molphy::Result object

  my @trees;
  while( my $t = $r->next_tree ) {
      push @trees, $t;
  }

  print "search space is ", $r->search_space, "\n";
        "1st tree score is ", $tree[0]->score, "\n";

  my $out = Bio::TreeIO->new(-file => ">saved_MLtrees.tre",
                            -format => "newick");
  $out->write_tree($tree[0]);
  $out = undef;

=head1 DESCRIPTION

This is a wrapper for the exe from the Molphy (MOLecular
PHYlogenetics) package by Jun Adachi & Masami Hasegawa.  The software
can be downloaded from L<http://www.ism.ac.jp/ismlib/softother.e.html>.
Note that PHYLIP (Joe Felsenstein) also provides a version of protml
which this module is currently NOT prepared to handle.  Use the package
available directly from MOLPHY authors if you want to use the module
in its present implementation (extensions are welcomed!).

The main components are the protml and nucml executables which are
used to build maximum likelihood (ML) phylogenetic trees based on
either protein or nucleotide sequences.

Here are the valid input parameters, we have added a longhand version
of the parameters to help you understand what each one does.  Either
the longhand or the original Molphy parameter will work. 

  Bioperl      Molphy           Description
  Longhand     parameter
  Model (one of these):
  ---------------
  jtt              j            Jones, Taylor & Thornton (1992)
  jtt-f            jf           JTT w/ frequencies
  dayhoff          d            Dahoff et al. (1978)
  dayhoff-f        d            dayhoff w/ frequencies
  mtrev24          m            mtREV24 Adachi & Hasegwa (1995)
  mtrev24-f        mf           mtREV24 w/ frequencies
  poisson          p            Poisson
  proportional     pf           Proportional
  rsr              r            Relative Substitution Rate
  rsr-f            rf           RSR w/ frequencies
  frequencies      f            data frequencies

  Search Strategy (one of these):
  ----------------
  usertrees        u            User trees (must also supply a tree)
  rearrangement    R            Local rearrangement
  lbp              RX           Local boostrap prob
  exhaustive       e            Exhaustive search
  star             s            Star decomposition search (may not be ML)
  quick            q            Quick Add OTU search (may not be ML)
  distance         D            ML Distance matrix --> NJDIST (need to supply
  							       NJDIST tree)

  Others (can be some or all of these):
  ---------------
  norell-bp        b            No RELL-BP
  minimumevolution M            Minimum evolution

  sequential       S            Sequence is in Sequential format
                     _OR_
  interleaved      I            Sequence is in Interleaved format

  verbose          v            Verbose messages directed to STDERR
  information      i            Output some information (tree vals)
  		   w            More some extra information (transition
                                                             matricies, etc)


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

Email jason-AT-bioperl_DOT_org

=head1 CONTRIBUTORS

Additional contributors names and emails here

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut


# Let the code begin...


package Bio::Tools::Run::Phylo::Molphy::ProtML;
use vars qw(@ISA $PROGRAMNAME $PROGRAM $MINNAMELEN %VALIDVALUES %VALIDFLAGS);
use strict;
use Bio::Tools::Run::WrapperBase;
use Bio::Tools::Phylo::Molphy;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Root::Root;

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase );

BEGIN {
    $MINNAMELEN = 25;

    %VALIDFLAGS = (
		   'models' => { # models
		       jtt          => 'j', # Jones, Taylor & Thornton (1992)
		       'jtt-f'      => 'jf', # jtt w/ frequencies
		       dayhoff      => 'd', # Dahoff et al. (1978)
		       'dayhoff-f'  => 'df', # dayhoff w/ frequencies
		       mtrev24      => 'm', # Adachi & Hasegwa (1995)
		       'mtrev24-f'  => 'mf', # mtREV24 w/ frequencies
		       poisson      => 'p', # Poisson
		       proportional => 'pf', # Proportional
		       rsr          => 'r', # Relative Substitution Rate
		       'rsr-f'      => 'rf', # RSR w/ frequencies
		       frequencies  => 'f', # data frequencies
		   },
		   'search' => { # search strategy
		       usertrees     => 'u', # must also supply tree
		       rearrangement => 'R', # local rearrangement
		       lbp           => 'RX', # local boostrap prob
		       exhaustive    => 'e', # exhaustive
		       star          => 's', # star decomposition search (may not be ML)
		       quick         => 'q', # quick add OTU search (may not be ML)
		       distance      => 'D', # ML Distance matrix --> NJDIST
		   },
		   'others' => { # others
		       'norell-bp'   => 'b',
		       sequential    => 'S', # sequential format
		       interleaved   => 'I', # interleaved format
		       minimumevolution => 'M', # minimum evolution
		       verbose       => 'v', # verbose to stderr
		       information    => 'i', # output some information
		       w             => 'w', # some extra information
		   }
		   );
    # this will allow for each of the parameters to also accept the original
    # protML params
    my @toadd;
    foreach my $type ( keys %VALIDFLAGS ) {
	my @keys = keys %{ $VALIDFLAGS{$type} };
	for my $k ( @keys ) {
	    my $v = $VALIDFLAGS{$type}->{$k};
	    $VALIDFLAGS{$type}->{$v} = $v;
	}
    }
    %VALIDVALUES = (num_retained     => sub { my $a = shift;
					      if( $a =~ /^\d+$/) {
						  return 'n';
						  }}, # should be a number
		    percent_retained => sub { my $a = shift;
					      if( $a =~ /^\d+$/ &&
						  $a >= 0 && $a <= 100) {
						  return 'P';
					      }}
		    );


}

=head2 program_name

 Title   : program_name
 Usage   : >program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
        return 'protml';
}

=head2 program_dir

 Title   : program_dir
 Usage   : ->program_dir()
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
        return Bio::Root::IO->catfile($ENV{MOLPHYDIR}) if $ENV{MOLPHYDIR};
}

=head2 new

 Title   : new
 Usage   : my $obj = Bio::Tools::Run::Phylo::Molphy::ProtML->new();
 Function: Builds a new Bio::Tools::Run::Phylo::Molphy::ProtML object
 Returns : Bio::Tools::Run::Phylo::Molphy::ProtML
 Args    : -alignment => the Bio::Align::AlignI object
           -save_tempfiles => boolean to save the generated tempfiles and
                              NOT cleanup after onesself (default FALSE)
           -tree => the Bio::Tree::TreeI object
           -params => a hashref of PAML parameters (all passed to
						    set_parameter)
           -executable => where the protml executable resides

See also: L<Bio::Tree::TreeI>, L<Bio::Align::AlignI>


=cut

sub new {
  my($class,@args) = @_;

  my $self = $class->SUPER::new(@args);
  $self->{'_protmlparams'} = {};
  $self->{'_protmlflags'} = {};

  my ($aln, $tree, $st,  $flags, $params,
      $exe) = $self->_rearrange([qw(ALIGNMENT TREE SAVE_TEMPFILES
				    FLAGS PARAMS EXECUTABLE)],
				    @args);
  defined $aln && $self->alignment($aln);
  defined $tree && $self->tree($tree );
  defined $st  && $self->save_tempfiles($st);
  defined $exe && $self->executable($exe);
  if( defined $flags ) {
      if( ref($flags) !~ /HASH/i ) {
	  $self->warn("Must provide a valid hash ref for parameter -FLAGS");
      } else {
	  foreach my $type ( keys %$flags ) {
	      if( $type =~ /other/i ) {
		  foreach my $flag ( @{$flags->{$type}} ) {
		      $self->set_flag('others', $flag) ;
		  }
	      } else {
		  $self->set_flag($type, $flags->{$type}) ;
	      }
	  }
      }
  }
  if( defined $params ) {
      if( ref($flags) !~ /HASH/i ) {
	  $self->warn("Must provide a valid hash ref for parameter -FLAGS");
      } else {
	  map { $self->set_parameter($_, $$params{$_}) } keys %$params;
      }
  }
  return $self;
}


=head2 run

 Title   : run
 Usage   : $protml->run();
 Function: run the protml analysis using the default or updated parameters
           the alignment parameter must have been set
 Returns : Bio::Tools::Phylo::Molphy
 Args    :


=cut

sub run {
    my ($self) = @_;

    unless ( $self->save_tempfiles ) {
	$self->cleanup();
    }

    my $align = $self->alignment();
    if( ! $align  ) {
	$self->warn("must have provided a valid alignment object");
	return -1;
    }
    if( $align->get_seq_by_pos(1)->alphabet ne 'protein' ) {
	$self->warn("Must have provided a valid protein alignment");
	return -1;
    }

    my %params = $self->get_parameters;
    my %flags  = $self->get_flags();
    my $cmdstring = $self->executable;

    if( ! defined $flags{'search'} ) {
	$self->warn("Must have set a valid 'search' flag to run protml this is one of ".join(",", keys %{$VALIDFLAGS{'search'}}));
	return;
    }
    my $tree = $self->tree;

    for my $t ( keys %flags ) {
	if( $t eq 'others' ) {
	    $cmdstring .= " " . join(" ", map { '-'.$_ } keys %{$flags{$t}});
	} else {
	    next if $flags{$t} eq 'u';
	    $cmdstring .= " -".$flags{$t};
	}
    }

    while( my ($param,$val) = each %params ) {
	$cmdstring .= " \-$param $val";
    }
    my ($tmpdir) = $self->tempdir();
    my ($tempseqFH,$tempseqfile) = $self->io->tempfile
	('DIR' => $tmpdir,
	 UNLINK => ($self->save_tempfiles ? 0 : 1));
    
    my $alnout = Bio::AlignIO->new('-format'      => 'phylip',
				  '-fh'          => $tempseqFH,
				  '-interleaved' => 0,
				  '-idlinebreak' => 1,
				  '-idlength'    => $MINNAMELEN > $align->maxdisplayname_length() ? $MINNAMELEN : $align->maxdisplayname_length() +1);

    $alnout->write_aln($align);
    $alnout->close();
    $alnout = undef;
    close($tempseqFH);
    $tempseqFH = undef;
    $cmdstring .= " $tempseqfile";
    if( $tree && defined $flags{'search'} eq 'u' ) {
	my ($temptreeFH,$temptreefile) = $self->io->tempfile
	    ('DIR' => $tmpdir,
	     UNLINK => ($self->save_tempfiles ? 0 : 1));
	my $treeout = Bio::TreeIO->new('-format' => 'newick',
				      '-fh'     => $temptreeFH);
	$treeout->write_tree($tree);
	$treeout->close();
	close($temptreeFH);
	$cmdstring .= " $temptreefile";
    }
    $self->debug( "cmdstring is $cmdstring\n");

    unless( open(PROTML, "$cmdstring |") ) {
	$self->warn("Cannot run $cmdstring");
	return undef;
    }
    my $parser= Bio::Tools::Phylo::Molphy->new(-fh => \*PROTML);
    return (1,$parser);
}

=head2 alignment

 Title   : alignment
 Usage   : $protml->align($aln);
 Function: Get/Set the Bio::Align::AlignI object
 Returns : Bio::Align::AlignI object
 Args    : [optional] Bio::Align::AlignI
 Comment : We could potentially add support for running directly on a file
           but we shall keep it simple
See also : L<Bio::SimpleAlign>, L<Bio::Align::AlignI>

=cut

sub alignment{
   my ($self,$aln) = @_;
   if( defined $aln ) {
       if( !ref($aln) || ! $aln->isa('Bio::Align::AlignI') ) {
	   $self->warn("Must specify a valid Bio::Align::AlignI object to the alignment function");
	   return undef;
       }
       $self->{'_alignment'} = $aln;
   }
   return  $self->{'_alignment'};
}

=head2 tree

 Title   : tree
 Usage   : $protml->tree($tree, %params);
 Function: Get/Set the Bio::Tree::TreeI object
 Returns : Bio::Tree::TreeI
 Args    : [optional] $tree => Bio::Tree::TreeI,

 Comment : We could potentially add support for running directly on a file
           but we shall keep it simple
See also : L<Bio::Tree::Tree>

=cut

sub tree {
   my ($self, $tree, %params) = @_;
   if( defined $tree ) {
       if( ! ref($tree) || ! $tree->isa('Bio::Tree::TreeI') ) {
	   $self->warn("Must specify a valid Bio::Tree::TreeI object to the alignment function");
       }
       $self->{'_tree'} = $tree;
   }
   return $self->{'_tree'};
}

=head2 get_flags

 Title   : get_flags
 Usage   : my @params = $protml->get_flags();
 Function: returns the list of flags
 Returns : array of flag names coded in the way that
 Args    : none


=cut

sub get_flags{
   my ($self) = @_;
   # we're returning a copy of this
   return %{ $self->{'_protmlflags'} };
}


=head2 set_flag

 Title   : set_flag
 Usage   : $protml->set_parameter($type,$val);
 Function: Sets a protml parameter, will be validated against
           the valid values as set in the %VALIDVALUES class variable.
           The checks can be ignored if one turns off param checks like this:
             $protml->no_param_checks(1)
 Returns : boolean if set was success, if verbose is set to -1
           then no warning will be reported
 Args    : $type => name of the parameter
           This can be one of 'search', 'model', 'other'
           $value => flag value
 See also: L<no_param_checks()>

=cut

sub set_flag{
   my ($self,$type,$param) = @_;
   $type = lc($type);
   while( substr($type,0,1) eq '-') { # handle multiple '-'
       substr($type,0,1,'');
   }

   if( ! defined $type ||
       ! defined $param ) {
       $self->debug("Must supply a type and param when setting flag");
       return 0;
   }

   if( ! $VALIDFLAGS{$type} ) {
       $self->warn("$type is an unrecognized type");
   }
   $param = lc($param);

   while( substr($param,0,1) eq '-') { # handle multiple '-'
       substr($param,0,1,'');
   }

   if(! $self->no_param_checks && ! defined $VALIDFLAGS{$type}->{$param} ) {
       $self->warn("unknown flag ($type) $param will not be set unless you force by setting no_param_checks to true");
       return 0;
   }
   if($type eq 'others' ) {
       $self->{'_protmlflags'}->{$type}->{$VALIDFLAGS{$type}->{$param} || $param} = 1;
   } else {
       $self->{'_protmlflags'}->{$type} = $VALIDFLAGS{$type}->{$param} || $param;
   }
   return 1;
}


=head2 get_parameters

 Title   : get_parameters
 Usage   : my %params = $protml->get_parameters();
 Function: returns the list of parameters as a hash
 Returns : associative array keyed on parameter names
 Args    : none


=cut

sub get_parameters{
   my ($self) = @_;
   # we're returning a copy of this
   return %{ $self->{'_protmlparams'} };
}


=head2 set_parameter

 Title   : set_parameter
 Usage   : $protml->set_parameter($param,$val);
 Function: Sets a protml parameter, will be validated against
           the valid values as set in the %VALIDVALUES class variable.
           The checks can be ignored if one turns off param checks like this:
             $protml->no_param_checks(1)
 Returns : boolean if set was success, if verbose is set to -1
           then no warning will be reported
 Args    : $param => name of the parameter
           $value => value to set the parameter to
 See also: L<no_param_checks()>

=cut

sub set_parameter{
   my ($self,$param,$value) = @_;
   $param = lc($param);
   $param =~ s/^\-//;
   if(! $self->no_param_checks && ! defined $VALIDVALUES{$param} ) {
       $self->warn("unknown parameter $param will not be set unless you force by setting no_param_checks to true");
       return 0;
   }

   my $paramflag = $VALIDVALUES{$param}->($value);
   if( $paramflag ) {
       $self->{'_protmlparams'}->{$paramflag} = $value;
   } else {
       print "value $value was not valid for param $param\n";
       return 0;
   }
   return 1;
}

=head1 Bio::Tools::Run::WrapperBase methods

=cut

=head2 no_param_checks

 Title   : no_param_checks
 Usage   : $obj->no_param_checks($newval)
 Function: Boolean flag as to whether or not we should
           trust the sanity checks for parameter values
 Returns : value of no_param_checks
 Args    : newvalue (optional)


=cut

=head2 save_tempfiles

 Title   : save_tempfiles
 Usage   : $obj->save_tempfiles($newval)
 Function:
 Returns : value of save_tempfiles
 Args    : newvalue (optional)


=cut

=head2 outfile_name

 Title   : outfile_name
 Usage   : my $outfile = $protml->outfile_name();
 Function: Get/Set the name of the output file for this run
           (if you wanted to do something special)
 Returns : string
 Args    : [optional] string to set value to


=cut


=head2 tempdir

 Title   : tempdir
 Usage   : my $tmpdir = $self->tempdir();
 Function: Retrieve a temporary directory name (which is created)
 Returns : string which is the name of the temporary directory
 Args    : none


=cut

=head2 cleanup

 Title   : cleanup
 Usage   : $protml->cleanup();
 Function: Will cleanup the tempdir directory after a PAML run
 Returns : none
 Args    : none


=cut

=head2 io

 Title   : io
 Usage   : $obj->io($newval)
 Function:  Gets a L<Bio::Root::IO> object
 Returns : L<Bio::Root::IO>
 Args    : none


=cut


sub DESTROY {
    my $self= shift;
    unless ( $self->save_tempfiles ) {
	$self->cleanup();
    }
    $self->SUPER::DESTROY();
}
1;
