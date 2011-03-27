# BioPerl module for Bio::Tools::Run::Alignment::Lagan
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Bioperl
#
# Copyright Bioperl, Stephen Montgomery <smontgom@bcgsc.bc.ca>
#
# Special thanks to Jason Stajich.
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Alignment::Lagan - Object for the local execution of the LAGAN suite of tools (including MLAGAN for multiple sequence alignments)

=head1 SYNOPSIS

  use Bio::Tools::Run::Alignment::Lagan;

  @params =
      ('chaos' => "The contents of this string will be passed as args to chaos",

       #Read you chaos README file for more info/This functionality
       #has not been tested and will be integrated in future versions.

       'order' => "\"-gs -7 -gc -2 -mt 2 -ms -1\"",
       #Where gap start penalty of- 7, gap continue of -2, match of 2,
       #and mismatch of -1.

       'recurse' => "\"(12,25),(7,25),(4,30)"\",
       #A list of (wordlength,score cutoff) pairs to be used in the
       #recursive anchoring

       'tree' => "\"(sample1 (sample2 sample3))"\",
       #Used by mlagan / tree can also be passed when calling mlagan directly

       #SCORING PARAMETERS FOR MLAGAN:
       'match' => 12,
       'mismatch' => -8,
       'gapstart' => -50,
       'gapend' => -50,
       'gapcont' => -2,
  );


=head1 DESCRIPTION

To run mlagan/lagan, you must have an environment variable that points to
the executable directory with files lagan.pl etc.
"LAGAN_DIR=/opt/lagan_executables/"

Simply having the executables in your path is not supported because the
executables themselves only work with the environment variable set.

All lagan and mlagan parameters listed in their Readmes can be set
except for the mfa flag which has been turned on by default to prevent
parsing of the alignment format.

TO USE LAGAN:

  my $lagan = Bio::Tools::Run::Alignment::Lagan->new(@params);
  my $report_out = $lagan->lagan($seq1, $seq2);

A SimpleAlign object is returned.

TO USE MLAGAN:

  my $lagan = Bio::Tools::Run::Alignment::Lagan->new();
  my $tree = "(($seqname1 $seqname2) $seqname3)";
  my @sequence_objs; 	#an array of bioperl Seq objects

  ##If you use an unblessed seq array
  my $seq_ref = \@sequence_objs;
  bless $seq_ref, "ARRAY";

  my $report_out = $lagan->mlagan($seq_ref, $tree);

  A SimpleAlign object is returned	

Only basic mlagan/lagan functionality has been implemented due to the
iterative development of their project.  Future maintenance upgrades
will include enhanced features and scoring.

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

=head1 AUTHOR - Stephen Montgomery

Email smontgom@bcgsc.bc.ca

Genome Sciences Centre in beautiful Vancouver, British Columbia CANADA

=head1 CONTRIBUTORS

MLagan/Lagan is the hard work of Michael Brudno et al.

Sendu Bala bix@sendu.me.uk

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Alignment::Lagan;

use strict;
use Bio::Root::IO;
use Bio::Seq;
use Bio::SeqIO;
use Bio::AlignIO;
use Bio::SimpleAlign;
use File::Spec;
use Bio::Matrix::IO;
use Cwd;

use base qw(Bio::Tools::Run::WrapperBase);

our @LAGAN_PARAMS = qw(chaos order recurse mfa out lazy maskedonly
                       usebounds rc translate draft info fastreject);
our @OTHER_PARAMS = qw(outfile);
our @LAGAN_SWITCHES = qw(silent quiet);
our @MLAGAN_PARAMS = qw(nested postir translate lazy verbose tree match mismatch
                        gapstart gapend gapcont out version);

#Not all of these parameters are useful in this context, care
#should be used in setting only standard ones

#The LAGAN_DIR environment variable must be set
our $PROGRAM_DIR = $ENV{'LAGAN_DIR'} || '';

sub new {
    my($class, @args) = @_;
    my $self = $class->SUPER::new(@args);
    
    $self->_set_from_args(\@args, -methods => [@LAGAN_PARAMS, @OTHER_PARAMS,
                                               @LAGAN_SWITCHES, @MLAGAN_PARAMS],
                                  -create => 1);
    
    my ($tfh, $tempfile) = $self->io->tempfile();
    my $outfile = $self->out || $self->outfile || $tempfile;
    $self->out($outfile);
    close($tfh);
    undef $tfh;
    return $self;
}

=head2 lagan

  Runs the Lagan pairwise alignment algorithm
  Inputs should be two PrimarySeq objects.

  Returns an SimpleAlign object / preloaded with the tmp file of the
  Lagan multifasta output.

=cut

sub lagan {
    my ($self, $input1, $input2) = @_;
    $self->io->_io_cleanup();
    my $executable = 'lagan.pl';
		
    #my (undef, $tempfile) = $self->io->tempfile();
    #$self->out($tempfile);
    my ($infile1, $infile2) = $self->_setinput($executable, $input1, $input2);
    my $lagan_report = &_generic_lagan(	$self,
                                        $executable,
                                        $infile1,
                                        $infile2 );
}

=head2 mlagan

  Runs the Mlagan multiple sequence alignment algorithm.
  Inputs should be an Array of Primary Seq objects and a Phylogenetic Tree in
  String format or as a Bio::Tree::TreeI compliant object.
  Returns an SimpleAlign object / preloaded with the tmp file of the Mlagan
  multifasta output.

=cut

sub mlagan {
    my ($self, $input1, $tree) = @_;
    $self->io->_io_cleanup();
    my $executable = 'mlagan';
    
    if ($tree && ref($tree) && $tree->isa('Bio::Tree::TreeI')) {
        # fiddle tree so mlagan will like it
        my %orig_ids;
        foreach my $node ($tree->get_nodes) {
            my $seq_id = $node->name('supplied');
            $seq_id = $seq_id ? shift @{$seq_id} : ($node->node_name ? $node->node_name : $node->id);
            $orig_ids{$seq_id} = $node->id;
            $node->id($seq_id);
        }
        
        # convert to string
        my $tree_obj = $tree;
        $tree = $tree->simplify_to_leaves_string;
        
        # more fiddling
        $tree =~ s/ /_/g;
        $tree =~ s/"//g;
        $tree =~ s/,/ /g;

        # unfiddle the tree object
        foreach my $node ($tree_obj->get_nodes) {
            $node->id($orig_ids{$node->id});
        }
    }
    
    my $infiles;
    ($infiles, $tree) = $self->_setinput($executable, $input1, $tree);
    my $lagan_report = &_generic_lagan (	$self,
						$executable,
						$infiles,
						$tree );
}

=head2  nuc_matrix

 Title   : nuc_matrix
 Usage   : my $matrix_obj = $obj->nuc_matrix();
           -or-
           $obj->nuc_matrix($matrix_obj);
           -or-
           $obj->nuc_matrix($matrix_file);
 Function: Get/set the substitution matrix for use by mlagan. By default the
           file $LAGAN_DIR/nucmatrix.txt is used by mlagan. By default this
           method returns a corresponding Matrix.
 Returns : Bio::Matrix::Mlagan object
 Args    : none to get, OR to set:
           Bio::Matrix::MLagan object
           OR
           filename of an mlagan substitution matrix file

           NB: due to a bug in mlagan 2.0, the -nucmatrixfile option does not
           work, so this Bioperl wrapper is unable to simply point mlagan to
           your desired matrix file (or to a temp file generated from your
           matrix object). Instead the $LAGAN_DIR/nucmatrix.txt file must
           actually be replaced. This wrapper will make a back-up copy of that
           file, write the new file in its place, then revert things back to the
           way they were after the alignment has been produced. For this reason,
           $LAGAN_DIR must be writable, as must $LAGAN_DIR/nucmatrix.txt.

=cut

sub nuc_matrix {
    my ($self, $thing, $gap_open, $gap_continue) = @_;
    
    if ($thing) {
        if (-e $thing) {
            my $min = Bio::Matrix::IO->new(-format => 'mlagan',
                                           -file   => $thing);
            $self->{_nuc_matrix} = $min->next_matrix;
        }
        elsif (ref($thing) && $thing->isa('Bio::Matrix::Mlagan')) {
            $self->{_nuc_matrix} = $thing;
        }
        else {
            $self->throw("Unknown kind of thing supplied, '$thing'");
        }
        
        $self->{_nuc_matrix_set} = 1;
    }
    
    unless (defined $self->{_nuc_matrix}) {
        # read the program default file
        my $min = Bio::Matrix::IO->new(-format => 'mlagan',
                                       -file   => File::Spec->catfile($PROGRAM_DIR, 'nucmatrix.txt'));
        $self->{_nuc_matrix} = $min->next_matrix;
    }
    
    $self->{_nuc_matrix_set} = 1 if defined wantarray;
    return $self->{_nuc_matrix};
}

=head2  _setinput

 Title   : _setinput
 Usage   : Internal function, not to be called directly
 Function: Create input file(s) for Lagan executables
 Returns : name of files containing Lagan data input / 
           or array of files and phylo tree for Mlagan data input

=cut

sub _setinput {
    my ($self, $executable, $input1, $input2) = @_;
    my ($fh, $infile1, $infile2, $temp1, $temp2, $seq1, $seq2);

    $self->io->_io_cleanup();
	
  SWITCH: {
        if (ref($input1) =~ /ARRAY/i) {

            ##INPUTS TO MLAGAN / WILL hAVE TO BE CHANGED IF LAGAN EVER
            ##SUPPORTS MULTI-INPUT
            my @infilearr;
            foreach $seq1 (@$input1) {
                ($fh, $infile1) = $self->io->tempfile();
                my $temp = Bio::SeqIO->new(	-fh => $fh,
                                            -format => 'Fasta' );
                unless ($seq1->isa("Bio::PrimarySeqI")) {
                    return 0;
                }
                $temp->write_seq($seq1);
                close $fh;
                undef $fh;
                push @infilearr, $infile1;
            }
            $infile1 = \@infilearr;
            last SWITCH;  
        }
        elsif ($input1->isa("Bio::PrimarySeqI")) {
            ##INPUTS TO LAGAN
            ($fh, $infile1) = $self->io->tempfile();

            #Want to make sure their are no white spaces in sequence.
            #Happens if input1 is taken from an alignment.

            my $sequence = $input1->seq();
            $sequence =~ s/\W+//g;
            $input1->seq($sequence);
            $temp1 = Bio::SeqIO->new(	-fh => $fh,
                                        -format => 'Fasta' );
            $temp1->write_seq($input1);
            close $fh;
            undef $fh;
            last SWITCH;		
        }
    }
  SWITCH2: {
        if (ref($input2)) {
            if ($input2->isa("Bio::PrimarySeqI")) {
                ($fh, $infile2) = $self->io->tempfile();

                #Want to make sure their are no white spaces in
                #sequence.  Happens if input2 is taken from an
                #alignment.

                my $sequence = $input2->seq();
                $sequence =~ s/\W+//g;
                $input2->seq($sequence);

                $temp2 = Bio::SeqIO->new(       -fh => $fh,
                                                -format => 'Fasta' );
                $temp2->write_seq($input2);
                close $fh;
                undef $fh;
                last SWITCH2;
            }
        } else {
            $infile2 = $input2;
            ##A tree as a scalar has been passed, pass it through
        }
    }
    return ($infile1, $infile2);
}

=head2  _generic_lagan

 Title   : _generic_lagan
 Usage   :  internal function not called directly
 Returns :  SimpleAlign object

=cut


sub _generic_lagan {
    my ($self, $executable, $input1, $input2) = @_;
    my $param_string = $self->_setparams($executable);
    my $lagan_report = &_runlagan($self, $executable, $param_string,
                                  $input1, $input2);	
}	

=head2  _setparams

 Title   : _setparams
 Usage   : Internal function, not to be called directly
 Function: Create parameter inputs for (m)Lagan program
 Returns : parameter string to be passed to Lagan
 Args    : Reference to calling object and name of (m)Lagan executable

=cut


sub _setparams {
    my ($self, $executable) = @_;
    
    my (@execparams, $nucmatrixfile);
    if ($executable eq 'lagan.pl') {
        @execparams = @LAGAN_PARAMS;
    }
    elsif ($executable eq 'mlagan') {
        @execparams = @MLAGAN_PARAMS;
        
        if ($self->{_nuc_matrix_set}) {
            # we create this file on every call because we have no way of
            # knowing if user altered the matrix object
            (my $handle, $nucmatrixfile) = $self->io->tempfile();
            my $mout = Bio::Matrix::IO->new(-format => 'mlagan',
                                            -fh => $handle);
            $mout->write_matrix($self->nuc_matrix);
            $self->{_nucmatrixfile} = $nucmatrixfile;
        }
    }
    ##EXPAND OTHER LAGAN SUITE PROGRAMS HERE
    
    my $param_string = $self->SUPER::_setparams(-params => [@execparams],
                                                -dash => 1);
    $param_string .= " -nucmatrixfile $nucmatrixfile" if $nucmatrixfile;
    return $param_string . " -mfa ";
}	


=head2  _runlagan

 Title   :  _runlagan
 Usage   :  Internal function, not to be called directly
 Function:   makes actual system call to (m)Lagan program
 Example :
 Returns : Report object in the SimpleAlign object

=cut

sub _runlagan {
    my ($self, $executable, $param_string, $input1, $input2) = @_;
    my ($lagan_obj, $exe);
    if ( ! ($exe = $self->executable($executable))) {
        return;
    }
    
    my $version = $self->version;
    
    my $command_string;
    if ($executable eq 'lagan.pl') {
        $command_string = $exe . " " . $input1 . " " . $input2 . $param_string;
    }
    if ($executable eq 'mlagan') {
        $command_string = $exe;
        foreach my $tempfile (@$input1) {
            $command_string .= " " . $tempfile;
        }
        if (defined $input2) {
            $command_string .= " -tree " . "\"" . $input2 . "\"";
        }	
        $command_string .= " " . $param_string;
        
        my $matrix_file = $self->{_nucmatrixfile};
        if ($version <= 3 && $matrix_file) {
            # mlagan 2.0 bug-workaround
            my $orig = File::Spec->catfile($PROGRAM_DIR, 'nucmatrix.txt');
            -e $orig || $self->throw("Strange, $orig doesn't seem to exist");
            system("cp $orig $orig.bk") && $self->throw("Backup of $orig failed: $!");
            system("cp $matrix_file $orig") && $self->throw("Copy of $matrix_file -> $orig failed: $!");
        }
    }

    if (($self->silent ||  $self->quiet) &&
        ($^O !~ /os2|dos|MSWin32|amigaos/)) {
      $command_string .= ' > /dev/null 2> /dev/null';

    }
    
    # will do brute-force clean up of junk files generated by lagan
    my $cwd = cwd();
    opendir(my $cwd_dir, $cwd) || $self->throw("Could not open the current directory '$cwd'!");
    my %ok_files;
    foreach my $thing (readdir($cwd_dir)) {
        if ($thing =~ /anch/) {
            $ok_files{$thing} = 1;
        }
    }
    closedir($cwd_dir);
    
    $self->debug("$command_string\n");
    my $status = system(($version <= 3 ? '_POSIX2_VERSION=1 ' : '').$command_string); # temporary hack whilst lagan script 'rechaos.pl' uses obsolete sort syntax
    
    if ($version <= 1 && $self->{_nucmatrixfile}) {
        my $orig = File::Spec->catfile($PROGRAM_DIR, 'nucmatrix.txt');
        system("mv $orig.bk $orig") && $self->warn("Restore of $orig from $orig.bk failed: $!");
    }
    
    opendir($cwd_dir, $cwd) || $self->throw("Could not open the current directory '$cwd'!");
    foreach my $thing (readdir($cwd_dir)) {
        if ($thing =~ /anch/) {
            unlink($thing) unless $ok_files{$thing};
        }
    }
    closedir($cwd_dir);
    
    my $outfile = $self->out();
    my $align = Bio::AlignIO->new(	'-file' => $outfile,
					'-format' => 'fasta' );
    my $aln = $align->next_aln();

    return $aln;
}

=head2 executable

 Title   : executable
 Usage   : my $exe = $lagan->executable('mlagan');
 Function: Finds the full path to the 'lagan' executable
 Returns : string representing the full path to the exe
 Args    : [optional] name of executable to set path to
           [optional] boolean flag whether or not warn when exe is not found

 Thanks to Jason Stajich for providing the framework for this subroutine

=cut

sub executable {
    my ($self, $exename, $exe, $warn) = @_;
    $exename = 'lagan.pl' unless defined $exename;

    if ( defined $exe && -x $exe ) {
        $self->{'_pathtoexe'}->{$exename} = $exe;
    }
    unless ( defined $self->{'_pathtoexe'}->{$exename} ) {
        my $f = $self->program_path($exename);
        $exe = $self->{'_pathtoexe'}->{$exename} = $f if(-e $f && -x $f );
        
        unless( $exe )  {
            if ( ($exe = $self->io->exists_exe($exename)) && -x $exe ) {
                $self->{'_pathtoexe'}->{$exename} = $exe;
            } else {
                $self->warn("Cannot find executable for $exename") if $warn;
                $self->{'_pathtoexe'}->{$exename} = undef;
            }
        }
    }
    
    # even if its executable, we still need the environment variable to have
    # been set
    if (! $PROGRAM_DIR) {
        $self->warn("Environment variable LAGAN_DIR must be set, even if the lagan executables are in your path");
        $self->{'_pathtoexe'}->{$exename} = undef;
    }
    
    return $self->{'_pathtoexe'}->{$exename};
}

=head2 program_path

 Title   : program_path
 Usage   : my $path = $lagan->program_path();
 Function: Builds path for executable
 Returns : string representing the full path to the exe

 Thanks to Jason Stajich for providing the framework for this subroutine

=cut

sub program_path {
    my ($self,$program_name) = @_;
    my @path;
    push @path, $self->program_dir if $self->program_dir;
   	push @path, $program_name .($^O =~ /mswin/i ?'':'');
	# Option for Windows variants / None so far

    return Bio::Root::IO->catfile(@path);
}

=head2 program_dir

 Title   : program_dir
 Usage   : my $dir = $lagan->program_dir();
 Function: Abstract get method for dir of program. To be implemented
           by wrapper.
 Returns : string representing program directory

 Thanks to Jason Stajich for providing the framework for this subroutine

=cut

sub program_dir {
    $PROGRAM_DIR;
}

=head2 version

 Title   : version
 Usage   : my $version = $lagan->version;
 Function: returns the program version
 Returns : number
 Args    : none

=cut

sub version {
    my $self = shift;
    my $exe = $self->executable('mlagan') || return;
    
    open(my $VER, "$exe -version 2>&1 |") || die "Could not open command '$exe -version'\n";
    my $version;
    while (my $line = <$VER>) {
        ($version) = $line =~ /(\d+\S+)/;
    }
    close($VER) || die "Could not complete command '$exe -version'\n";
    
    return $version;
}

1;
