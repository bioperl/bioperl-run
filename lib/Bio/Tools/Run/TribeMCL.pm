# BioPerl module for TribeMCL
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Shawn Hoon <shawnh@fugu-sg.org>
#
# Copyright Shawn Hoon
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::TribeMCL

=head1 SYNOPSIS

  use Bio::Tools::Run::TribeMCL;
  use Bio::SearchIO;

  # 3 methods to input the blast results

  # straight forward raw blast output (NCBI or WU-BLAST)
  my @params = ('inputtype'=>'blastfile');

  # OR

  # markov program format 
  # protein_id1 protein_id2 evalue_magnitude evalue_factor
  # for example: 
  # proteins ENSP00000257547  and ENSP00000261659
  # with a blast score evalue of 1e-50
  # and proteins O42187 and ENSP00000257547
  # with a blast score evalue of 1e-119
  # entry would be 

  my @array  = [[qw(ENSP00000257547 ENSP00000261659 1 50)],
		[qw(O42187 ENSP00000257547 1 119)]];
  my @params = ('pairs'=>\@array,I=>'2.0');

  # OR

  # pass in a searchio object 
  # slowest of the 3 methods as it does more rigourous parsing
  # than required for us here

  my $sio = Bio::SearchIO->new(-format=>'blast',
                               -file=>'blast.out');
  my @params=('inputtype'=>'searchio',I=>'2.0');


  # you can specify the path to the executable manually in the following way
  my @params=('inputtype'=>'blastfile',I=>'2.0',
	      'mcl'=>'/home/shawn/software/mcl-02-150/src/shmcl/mcl',
	      'matrix'=>'/home/shawn/software/mcl-02-150/src/contrib/tribe/tribe-matrix');
  my $fact = Bio::Tools::Run::TribeMCL->new(@params);

  # OR

  $fact->matrix_executable('/home/shawn/software/mcl-02-150/src/contrib/tribe/tribe-matrix');
  $fact->mcl_executable('/home/shawn/software/mcl-02-150/src/shmcl/mcl');

  # to run

  my $fact = Bio::Tools::Run::TribeMCL->new(@params);

  # Run the program
  # returns an array reference to clusters where members are the ids
  # for example :2 clusters with 3 members per cluster:
  #  $fam = [ [mem1 mem2 mem3],[mem1 mem2 mem3]]

  # pass in either the blastfile path/searchio obj/the array ref to scores
  my $fam = $fact->run($sio); 

  # print out your clusters

  for (my $i = 0; $i <scalar(@{$fam}); $i++){
    print "Cluster $i \t ".scalar(@{$fam->[$i]})." members\n";
    foreach my $member (@{$fam->[$i]}){
      print "\t$member\n";
    }
  }

=head1 DESCRIPTION

TribeMCL is a method for clustering proteins into related groups,
which are termed 'protein families'. This clustering is achieved by
analysing similarity patterns between proteins in a given dataset, and
using these patterns to assign proteins into related groups. In many
cases, proteins in the same protein family will have similar
functional properties.

TribeMCL uses a novel clustering method (Markov Clustering or MCL)
which solves problems which normally hinder protein sequence
clustering.

Reference:

  Enright A.J., Van Dongen S., Ouzounis C.A; Nucleic Acids
  Res. 30(7):1575-1584 (2002)

You will need tribe-matrix (the program used to generate the matrix
for input into mcl) and mcl (the clustering software) available at:

  http://www.ebi.ac.uk/research/cgg/tribe/ or
  http://micans.org/mcl/.

Future Work in this module: Port the tribe-matrix program into perl so
that we can enable have a SearchIO kinda module for reading and
writing mcl data format

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists. Your participation is much appreciated.

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
the bugs and their resolution.  Bug reports can be submitted via the
web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Shawn Hoon

Email shawnh@fugu-sg.org

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a "_".

=cut


# Let the code begin...
package Bio::Tools::Run::TribeMCL;
use vars qw($AUTOLOAD @ISA  $PROGRAMDIR
            @TRIBEMCL_PARAMS @MATRIXPROGRAM_PARAMS @MCLPROGRAM_PARAMS
            @OTHER_SWITCHES %OK_FIELD
      	    $MATRIXPROGRAM_NAME $MCLPROGRAM_NAME
      	    $MCLPROGRAM $MATRIXPROGRAM
	    );
use strict;

use Bio::SeqIO;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Cluster::SequenceFamily;
use Bio::Factory::ApplicationFactoryI;
use Bio::Tools::Run::WrapperBase;
use Bio::Annotation::DBLink;
use Bio::Seq;
use Bio::Species;

@ISA = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);

# You will need to enable mcl and tribe-matrix to use this wrapper. This
# can be done in (at least) two ways:
#
# 1. define an environmental variable TRIBEDIR 
# export TRIBEDIR =/usr/local/share/mclbin/
# where the tribe-matrix and mcl programs are located.
#you probably need to copy them individually to the same directory
#if the installation puts them in different directories. or simply put them in
#your standard /usr/local/bin
#
# 2. include a definition of an environmental variable TRIBEDIR in
# every script that will use TRIBEMCL.pm
# $ENV{TRIBEDIR} = '/usr/local/share/mclbin/;
#
#3. Manually set the path to the executabes in your code:
#

#my @params=('inputtype'=>'blastfile',I=>'2.0','
#                       mcl'=>'/home/shawn/software/mcl-02-150/src/shmcl/mcl','
#                       matrix'=>'/home/shawn/software/mcl-02-150/src/contrib/tribe/tribe-matrix');
#my $fact = Bio::Tools::Run::TribeMCL->new(@params);

#or
#$fact->matrix_executable('/home/shawn/software/mcl-02-150/src/contrib/tribe/tribe-matrix');
#$fact->mcl_executable('/home/shawn/software/mcl-02-150/src/shmcl/mcl');


BEGIN {
    $MATRIXPROGRAM_NAME = 'tribe-matrix';
    $MCLPROGRAM_NAME    = 'mcl';
    if (defined $ENV{TRIBEDIR}) {
        $PROGRAMDIR = $ENV{TRIBEDIR} || '';
        $MCLPROGRAM = Bio::Root::IO->catfile($PROGRAMDIR,$MCLPROGRAM_NAME.($^O =~ /mswin/i ?'.exe':''));
        $MATRIXPROGRAM = Bio::Root::IO->catfile($PROGRAMDIR,$MATRIXPROGRAM_NAME.($^O =~ /mswin/i ?'.exe':''));
    }

    @TRIBEMCL_PARAMS = qw(inputtype hsp hit scorefile blastfile description_file searchio pairs mcl matrix weight description family_tag use_db);

    @MATRIXPROGRAM_PARAMS = qw(ind out chunk);
    @MCLPROGRAM_PARAMS = qw(I t P R pct o);

    @OTHER_SWITCHES = qw(verbose quiet); 

    # Authorize attribute fields
    foreach my $attr (@TRIBEMCL_PARAMS, @MATRIXPROGRAM_PARAMS,
                      @MCLPROGRAM_PARAMS, @OTHER_SWITCHES) {
      $OK_FIELD{$attr}++;
    }
}

sub new {
  my ($class, @args) = @_;
  my $self = $class->SUPER::new(@args);
  
  my ($attr, $value);
  while (@args) {
    $attr =   shift @args;
    $value =  shift @args;
    next if( $attr =~ /^-/ ); # don't want named parameters
    if ($attr =~/MCL/i) {
      $self->mcl_executable($value);
      next;
    }
    if ($attr =~ /MATRIX/i){
      $self->matrix_executable($value);
      next;
    }
    $self->$attr($value);
  }
  defined($self->weight) || $self->weight(200);

  return $self;
}

sub AUTOLOAD {
    my $self = shift;
    my $attr = $AUTOLOAD;
    $attr =~ s/.*:://;
    $self->throw("Unallowed parameter: $attr !") unless $OK_FIELD{$attr};
    $self->{$attr} = shift if @_;
    return $self->{$attr};
}

=head2 mcl_executable

 Title   : mcl_executable
 Usage   : $self->mcl_executable()
 Function: get set for path to mcl executable
 Returns : String or undef if not installed
 Args    : [optional] string of path to executable
           [optional] boolean to warn on missing executable status

=cut

sub mcl_executable{
   my ($self,$exe,$warn) = @_;
   
   if( defined $exe ) {
       $self->{'_mcl_exe'} = $exe;
   }
   unless( defined $self->{'_mcl_exe'} ) {
       # this would be the name set in the BEGIN block
       if( $MCLPROGRAM && -e $MCLPROGRAM && -x $MCLPROGRAM ) {
	   $self->{'_mcl_exe'} = $MCLPROGRAM;
       } else { 
	   my $exe;
	   if( ( $exe = $self->io->exists_exe($MCLPROGRAM_NAME) ) &&
	       -x $exe ) {
	       $self->{'_mcl_exe'} = $exe;
	   } else { 
	       $self->warn("Cannot find executable for $MCLPROGRAM_NAME") if $warn;
	       $self->{'_mcl_exe'} = undef;
	   }
       }
   }
   $self->{'_mcl_exe'};
}

=head2 matrix_executable

 Title   : matrix_executable
 Usage   : $self->matrix_executable()
 Function: get set for path to tribe-matrix executable
 Returns : String or undef if not installed
 Args    : [optional] string of path to executable
           [optional] boolean to warn on missing executable status

=cut

sub matrix_executable{
   my ($self,$exe,$warn) = @_;
   
   if( defined $exe ) {
       $self->{'_matrix_exe'} = $exe;
   }
   unless( defined $self->{'_matrix_exe'} ) {
       # this would be the name set in the BEGIN block
       if( $MATRIXPROGRAM && -e $MATRIXPROGRAM && -x $MATRIXPROGRAM ) {
	   $self->{'_matrix_exe'} = $MATRIXPROGRAM;
       } else { 
	   my $exe;
	   if( ( $exe = $self->io->exists_exe($MATRIXPROGRAM_NAME) ) &&
	       -x $exe ) {
	       $self->{'_matrix_exe'} = $exe;
	   } else { 
	       $self->warn("Cannot find executable for $MATRIXPROGRAM_NAME")
		   if $warn;
	       $self->{'_matrix_exe'} = undef;
	   }
       }
   }
   $self->{'_matrix_exe'};
}

=head2 run

 Title   : run
 Usage   : $self->run()
 Function: runs the clustering
 Returns : Array Ref of clustered Ids 
 Args    : 

=cut

sub run {
  my ($self,$input) = @_;
  if($self->description_file){
      $self->_setup_description($self->description_file);
  }
  my $file = $self->_setup_input($input);
  defined($file) || $self->throw("Error setting up input ");
  #run tribe-matrix to generate matrix for mcl
  my ($index_file, $mcl_infile) = $self->_run_matrix($file);
  $self->throw("tribe-matrix not run properly as index file is missing")
      unless (-e $index_file);
  $self->throw("tribe-matrix not run properly as matrix file is missing")
      unless (-e $mcl_infile);
  #run mcl
  my $clusters = $self->_run_mcl($index_file,$mcl_infile);
  my $families;
  if($self->description){
    my %consensus = $self->_consensifier($clusters);
    $families = $self->_generate_families($clusters,\%consensus);
  }
  else {
    $families = $self->_generate_families($clusters);
  }

  return @{$families};
}

sub _generate_families {
    my ($self,$clusters,$consensus) = @_;
    my $family_tag = $self->family_tag || "TribeFamily";
    my @fam;
    if($consensus){
      my %description = %{$self->description};
      my %consensus = %{$consensus};
      for(my $i = 0; $i < scalar(@{$clusters}); $i++){
          my @mem;
          foreach my $member (@{$clusters->[$i]}){
              my $mem = Bio::Seq->new(-id=>$member,
                                      -alphabet=>"protein",
                                      -desc=>$description{$member}->[1]);
              my $annot = Bio::Annotation::DBLink->new(-database=>$description{$member}->[0],
                                                       -primary_id=>$member);

              $mem->annotation->add_Annotation('dblink',$annot);

              #store species information
              my $taxon_str = $description{$member}->[2];
              #parse taxon info into hash
              my %taxon;
              $taxon_str=~s/=;/=undef;/g if $taxon_str;
              %taxon = map{split '=',$_}split';',$taxon_str if $taxon_str;
              my $name = $taxon{'taxon_common_name'};
              my @classification = $taxon{'taxon_classification'} ? split(':',$taxon{'taxon_classification'}) : ();
              my $tax_id = $taxon{'taxon_id'};
              my $sub_species = $taxon{'taxon_sub_species'};

              my $species = Bio::Species->new();
              $species->common_name($name) if $name; #*** should this actually be scientific_name() ?
              $species->sub_species($sub_species) if $sub_species;
              $species->ncbi_taxid($tax_id) if $tax_id;
              $species->classification(@classification) if @classification;
              $mem->species($species); 

              push @mem, $mem;
          }
          my $id = $family_tag."_".$i;
          my $fam = Bio::Cluster::SequenceFamily->new(-family_id=>$id,
                                              -description=>$consensus{$i}{desc},
                                              -annotation_score=>$consensus{$i}{conf},
                                              -members=>\@mem);
          push @fam, $fam;
      }
      return \@fam;
    }
    else {
        for(my $i = 0; $i < scalar(@{$clusters}); $i++){
          my @mem;
          foreach my $member (@{$clusters->[$i]}){
              my $mem = Bio::Seq->new(-id=>$member,
                                      -alphabet=>"protein");
              push @mem, $mem;
          }
          my $id = $family_tag."_".$i;
          my $fam = Bio::Cluster::SequenceFamily->new(-family_id=>$id,
                                                      -members=>\@mem);
          push @fam, $fam;
      }
     return \@fam;
    }

}


sub _consensifier {
    my ($self,$clusters) = @_;
    eval {
      require "Algorithm/Diff.pm";
    };
    if($@){
      $self->warn("Algorith::Diff is needed to run TribeMCL");
      return undef;
    }
    my %description = %{$self->description}; 
    my %consensus;
    my $best_annotation;
    my %use_db;
    if($self->use_db){
      foreach my $key(split(',',$self->use_db)){
        $use_db{$key}++;
      }
    }
CLUSTER:
    for(my $i = 0; $i < scalar(@{$clusters}); $i++){
        my @desc;
        my @orig_desc;
        my $total_members = scalar(@{$clusters->[$i]});

        foreach my $member(@{$clusters->[$i]}){
          #if specify which dbs to use for consensifying
          if($self->use_db){
              if($use_db{$description{$member}->[0]}){
                push @desc, $description{$member}->[1] if $description{$member}->[1];
                push @orig_desc, $description{$member}->[1] if $description{$member}->[1];
              }
          }
          else {
            push @desc, $description{$member}->[1] if $description{$member}->[1];
            push @orig_desc, $description{$member}->[1] if $description{$member}->[1];
          }

        }
        if($#desc < 0){ #truly unknown
            $consensus{$i}{desc} = "UNKNOWN";
            $consensus{$i}{conf} = 0;
            next CLUSTER;
        }
        if($#desc == 0){#only a single description
            $consensus{$i}{desc} = grep(/S+/,@desc);
            $consensus{$i}{desc} = $consensus{$i}{desc} || "UNKNOWN";
	    if ($consensus{$i}{desc} eq "UNKNOWN") {
	      $consensus{$i}{conf} = 0;
	    } else {
	      $consensus{$i}{conf} = 100 * int(1/$total_members);            
	    }
            next CLUSTER;
        }

        #all the same desc
        my %desc = ();
        foreach my $desc (@desc) {        $desc{$desc}++;     }
        if ( (keys %desc) == 1 ) {
          my ($best_annotation,) = keys %desc;
          my $n = grep($_ eq $best_annotation, @desc);
          my $perc= int( 100*($n/$total_members) );
          $consensus{$i}{desc} = $best_annotation;
          $consensus{$i}{conf} = $perc;
          next CLUSTER;
        }
      
        my %lcshash = ();
        my %lcnext = ();
        while (@desc) {
          # do an all-against-all LCS (longest commong substring) of the
          # descriptions of all members; take the resulting strings, and
          # again do an all-against-all LCS on them, until we have nothing
          # left. The LCS's found along the way are in lcshash.
          #
          # Incidentally, longest common substring is a misnomer, since it
          # is not guaranteed to occur in either of the original strings. It
          # is more like the common parts of a Unix diff ...
          for (my $i=0;$i<@desc;$i++) {
            for (my $j=$i+1;$j<@desc;$j++){
                my @list1=split(" ",$desc[$i]);
                my @list2=split(" ",$desc[$j]);
                my @lcs=Algorithm::Diff::LCS(\@list1,\@list2);
                my $lcs=join(" ",@lcs);
                $lcshash{$lcs}=1;
                $lcnext{$lcs}=1;
            }
          }
          @desc=keys(%lcnext);
          undef %lcnext;
        }
        my ($best_score, $best_perc)=(0, 0);
        my @all_cands=sort {length($b) <=>length($a)} keys %lcshash ;
        foreach my $candidate_consensus (@all_cands) {
          my @temp=split(" ",$candidate_consensus);
          my $length=@temp;               # num of words in annotation

          # see how many members of cluster contain this LCS:

          my ($lcs_count)=0;
          foreach my $orig_desc (@orig_desc) {
            my @list1=split(" ",$candidate_consensus);
            my @list2=split(" ",$orig_desc);
            my @lcs=Algorithm::Diff::LCS(\@list1,\@list2);
            my $lcs=join(" ",@lcs);

            if ($lcs eq $candidate_consensus ||
                index($orig_desc,$candidate_consensus) != -1 # addition;
                # many good (single word) annotations fall out otherwise
               ) {
                $lcs_count++;

                # Following is occurs frequently, as LCS is _not_ the longest
                # common substring ... so we can't use the shortcut either

                # if ( index($orig_desc,$candidate_consensus) == -1 ) {
                #   warn "lcs:'$lcs' eq cons:'$candidate_consensus' and
                # orig:'$orig_desc', but index == -1\n"
                # }
            }
          }
          my $perc_with_desc=(($lcs_count/$total_members))*100;
          my $perc=($lcs_count/$total_members)*100;
          my $score=$perc + ($length*14); # take length into account as well
          $score = 0 if $length==0;
          if (($perc_with_desc >= 40) && ($length >= 1)) {
            if ($score > $best_score) {
                $best_score=$score;
                $best_perc=$perc;
                $best_annotation=$candidate_consensus;
            }
          }
      }
      if ($best_perc==0 || $best_perc >= 100 )  {
        $best_perc='NA';
      }
      if  ($best_annotation eq  '')  {
        $best_annotation = 'AMBIGUOUS';
      }
      $consensus{$i}{desc} = $best_annotation;
      $consensus{$i}{conf} = $best_perc;
  }
  return %consensus;
}

sub _setup_description {
    my ($self,$file) = @_;
    my $goners='().-';
    my $spaces= ' ' x length($goners);
    my $filter = "tr '$goners' '$spaces' < $file";
    open (FILE,"$filter | ") || die "$filter: $!";
    my %description;
    while(<FILE>){
        chomp;
        my ($db,$acc,$description,$taxon_str) = split("\t",$_);
        $description || $self->throw("Wrongly formated description file");
        $description = $self->_apply_edits($description);

        if($description{$acc}){
            $self->warn("Duplicated entry $acc in description file, overwriting..");
        }
        $description{$acc} = [$db,$description,$taxon_str];
    }
    $self->description(\%description);
}

sub as_words {
    #add ^ and $ to regexp
    my (@words);
    my @newwords=();

    foreach my $word (@words) { push @newwords, "^$word\$" };
}

sub _apply_edits {
  my ($self,$desc) = @_;
  my @deletes = ( 'FOR\$',  'SIMILAR TO\$', 'SIMILAR TO PROTEIN\$',
               'RIKEN.*FULL.*LENGTH.*ENRICHED.*LIBRARY',
               '\w*\d{4,}','HYPOTHETICAL PROTEIN'
               );
  my @newwords =  &as_words(qw(NOVEL PUTATIVE PREDICTED
                               UNNAMED UNNMAED ORF CLONE MRNA
                               CDNA EST RIKEN FIS KIAA\d+ \S+RIK IMAGE HSPC\d+
                               FOR HYPOTETICAL HYPOTHETICAL));
  push @deletes, @newwords;

  foreach my $re ( @deletes ) { $desc=~s/$re//g; }

  #Apply some fixes to the annotation:
  $desc=~s/EC (\d+) (\d+) (\d+) (\d+)/EC $1.$2.$3.$4/;
  $desc=~s/EC (\d+) (\d+) (\d+)/EC $1.$2.$3.-/;
  $desc=~s/EC (\d+) (\d+)/EC $1\.$2.-.-/;
  $desc=~s/(\d+) (\d+) KDA/$1.$2 KDA/;
  return $desc;
}

=head2 _run_mcl

 Title   : _run_mcl
 Usage   : $self->_run_mcl()
 Function: internal function for running the mcl program
 Returns : Array Ref of clustered Ids
 Args    : Index_file name, matrix input file name

=cut

sub _run_mcl {
  my ($self,$ind_file,$infile) = @_;
  my $exe = $self->mcl_executable || $self->throw("mcl not found.");
  my $cmd = $exe . " $infile";
  unless (defined $self->o) {
    my ($fh,$o) = $self->io->tempfile(-dir=>$self->tempdir);
    $self->o($o);
    # file handle not use later so deleted
    close($fh);
    undef $fh;
  }
  unless (defined $self->I) {
    $self->I(3.0);
  }

  foreach my $param (@MCLPROGRAM_PARAMS) {
    if (defined $self->$param) {
      $cmd .= " -$param ".$self->$param;
    }
  }
  if($self->quiet || 
     ($self->verbose < 0)){
      $cmd .= " -V all";
      if( $^O !~ /Mac/ && $^O !~ /Win/ ) {
	  $cmd .= ' 2> /dev/null';
      }
  }

  my $status = system($cmd);

  $self->throw( "mcl  call ($cmd) crashed: $? \n") unless $status==0;
  my $families = $self->_parse_mcl($ind_file,$self->o);
  return $families;
}

=head2 _run_matrix

 Title   : _run_matrix
 Usage   : $self->_run_matrix()
 Function: internal function for running the tribe-matrix program
 Returns : index filepath and matrix file path
 Args    : filepath of parsed ids and scores

=cut

sub _run_matrix {
  my ($self,$parse_file) = @_;
  my $exe = $self->matrix_executable || $self->throw("tribe-matrix not found.");
  my $cmd = $exe . " $parse_file";
  unless (defined $self->ind) {
    my ($fh,$indexfile) = $self->io->tempfile(-dir=>$self->tempdir);
    $self->ind($indexfile);
    # file handle not use later so deleted
    close($fh);
    undef $fh;
  }
  unless (defined $self->out) {
    my ($fh,$matrixfile) = $self->io->tempfile(-dir=>$self->tempdir);
    $self->out($matrixfile);
    # file handle not use later so deleted
    close($fh);
    undef $fh;
  }
  foreach my $param (@MATRIXPROGRAM_PARAMS) {
    if (defined $self->$param) {
      $cmd .= " -$param ".$self->$param;
    }
  }
  $cmd .= " > /dev/null";
  my $status = system($cmd);

  $self->throw( "tribe-matrix call ($cmd) crashed: $? \n") unless $status==0;

  return ($self->ind,$self->out);
}

=head2 _setup_input

 Title   : _setup_input
 Usage   : $self->_setup_input()
 Function: internal function for running setting up the inputs
            needed for running mcl
 Returns : filepath of parsed ids and scores
 Args    : 

=cut

sub _setup_input {
    my ($self,$input) = @_;
    my ($type,$rc);

    my ($tfh,$outfile) = $self->io->tempfile(-dir=>$self->tempdir);

    $type = $self->inputtype();
    if($type=~/scorefile/i){
        -e $self->scorefile ||
            $self->throw("Scorefile doesn't seem to exist or accessible");
        return $self->scorefile;
    }
    if($type =~/blastfile/i){
	    $self->blastfile($input);
	    $rc = $self->_parse_blastfile($self->blastfile,$tfh);
    } 
    elsif($type=~/searchio/i){
	    $self->searchio($input);
	    $rc = $self->_get_from_searchio($self->searchio,$tfh);
    } 
    elsif($type=~/pairs/i) {
	    $self->pairs($input);
	    for my $line (@{ $self->pairs }){
	      print $tfh join("\t",@{$line}), "\n"; 
	      $rc++;
	    }
    } 
    elsif($type =~/hsp/i) {
	    $self->hsp($input);
	    $rc = $self->_get_from_hsp($self->hsp,$tfh);
    }
    elsif($type=~/hit/i){
      $self->hit($input);
      $rc = $self->_get_from_hit($self->hit,$tfh);
    }
    else {
        $self->throw("Must set inputtype to either blastfile,searchio or ".
                     "paris using \$fact->blastfile |\$fact->searchio| \$fact->pairs");
    }
    unless ( $rc ) {
	    $self->throw("Need inputs for running tribe mcl, nothing provided"); 
    }
    close($tfh);
    $tfh= undef;
    return $outfile;
}

=head2 _get_from_hsp

 Title   : _get_from_hsp
 Usage   : $self->_get_from_hsp()
 Function: internal function for getting blast scores from hsp 
 Returns : array ref to ids and score [protein1 protein2 magnitude factor]
 Args    : L<Bio::Search::HSP::GenericHSP>

=cut

sub _get_from_hsp {
    my ($self,$hsp,$tfh) = @_;
    my @array;
    my $count;
    foreach my $pair (@{$hsp}){
        my $sig = $pair->score;
        $sig =~ s/^e-/1e-/g;
        my $expect=sprintf("%e",$sig);
        if ($expect==0){
          my $wt = $self->weight;
          $expect=sprintf("%e","1e-$wt");
        }
        my $first=(split("e-",$expect))[0];
        my $second=(split("e-",$expect))[1];

	print $tfh join("\t", $pair->feature1->seq_id,
			$pair->feature2->seq_id,int($first),
			int($second) ), "\n";
	$count++;
    }
    return $count;
}

sub _get_from_hit {
    my ($self,$hit,$tfh) = @_;
    my $count; 
    foreach my $pair(@{$hit}){
        my $sig = $pair->raw_score;
        $sig =~s/^e-/1e-/g;
        my $expect = sprintf("%e",$sig);
        if ($expect==0){
          my $wt = $self->weight;
          $expect=sprintf("%e","1e-$wt");
        }
        my $first=(split("e-",$expect))[0];
        my $second=(split("e-",$expect))[1];
        print $tfh join("\t",$pair->name,$pair->description,int($first),int($second)),"\n";
        $count++;
    }
    return $count;
}


=head2 _get_from_searchio

 Title   : _get_from_searchio
 Usage   : $self->_get_from_searchio()
 Function: internal function for parsing blast scores from searchio object
 Returns : array ref to ids and score [protein1 protein2 magnitude factor]
 Args    :  L<Bio::Tools::SearchIO>

=cut

sub _get_from_searchio {
  my ($self,$sio,$tfh) = @_;
  my @array;
  my $count;
  while( my $result = $sio->next_result ) {
    while( my $hit = $result->next_hit ) {
      while( my $hsp = $hit->next_hsp ) {
        my $sig = $hsp->evalue;
        $sig =~ s/^e-/1e-/g;
        my $expect=sprintf("%e",$sig);
        if ($expect==0){
          my $wt = $self->weight;
          $expect=sprintf("%e","1e-$wt");
        }
        my $first=(split("e-",$expect))[0];
        my $second=(split("e-",$expect))[1];
        print $tfh join("\t",
			$hsp->feature1->seq_id, 
			$hsp->feature2->seq_id,
			int($first),
			int($second) ), "\n";

	$count++;
      }
    }
  }
  return $count;
}

=head2 _parse_blastfile

 Title   : _parse_blastfile
 Usage   : $self->_parse_blastfile()
 Function: internal function for quickly parsing blast evalue 
           scores from raw blast output file
 Returns : array ref to ids and score [protein1 protein2 magnitude factor]
 Args    :  file path

=cut

sub _parse_blastfile {
  my ($self, $file,$tfh) = @_;
  open(FILE,$file) || $self->throw("Cannot open Blast Output File");
  my ($query,$reference,$first,$second);
  my @array;
  my $count;
  my $weight = $self->weight;
  while(<FILE>){
    if(/Query=\s+(\S+)/){
      $query = $1;
    }
    if(/^>(\S+)/){
      $reference = $1;
    }
    if (/Expect = (\S+)/){
      my $raw=$1;
      $raw=~s/^e-/1e-/g;
      my $expect=sprintf("%e",$raw);
      if ($expect==0){
        $expect=sprintf("%e","1e-$weight");	
			}
      $first=(split("e-",$expect))[0];
      $second=(split("e-",$expect))[1];
      print $tfh join("\t", $query, 
		      $reference,
		      int($first),
		      int($second)), "\n";
      $count++;
    }
  }
  return $count;
}

=head2 _parse_mcl

 Title   : _parse_mcl
 Usage   : $self->_parse_mcl()
 Function: internal function for quickly parsing mcl output and 
           generating the array of clusters
 Returns : Array Ref of clustered Ids
 Args    :  index file path, mcl output file path

=cut

sub _parse_mcl {
  my ($self,$ind,$mcl) = @_;
  open (MCL,$mcl) || $self->throw("Error, cannot open $mcl for parsing");
  my $i =-1;
  my $start;
  my (@cluster,@out);
  while(<MCL>) {
      if ($start) {
	  chomp($_);
	  $cluster[$i] = join(" ",$cluster[$i],"$_");
      }
      if(/^\d+/){
	  $start = 1;
	  $i++;
	  $cluster[$i] = join(" ",$cluster[$i] || '',"$_");
      }
      if (/\$$/){
	  $start = 0;
      }
      last if /^\(mclruninfo/;
  }
  open (IND,$ind) || $self->throw("Cannot open $ind for parsing");
  my %hash;
  while(<IND>){
      /^(\S+)\s+(\S+)/;
      $hash{$1}=$2;
  }

  for (my $j=0;$j<$i+1;$j++)	{
      my @array=split(" ",$cluster[$j]);
      for (my $p=1;$p<$#array;$p++){
	  push @{$out[$array[0]]}, $hash{$array[$p]};
      }
  }
  return \@out;
}


1;


