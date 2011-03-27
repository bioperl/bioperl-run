# $Id$
# BioPerl module for Bio::Tools::Run::Phylo::LVB
#
# Created by Daniel Barker, based on ProtPars.pm by Shawn Hoon 
#
# You may distribute this module under the same terms as perl itself
#
# POD documentation - main docs before the code

=head1 NAME 

Bio::Tools::Run::Phylo::LVB - Object for using the LVB program to create
an array of L<Bio::Tree> objects from a nucleotide multiple alignment
file or a nucleotide SimpleAlign object. Works with LVB version 2.1.

=head1 SYNOPSIS

  use Bio::Tools::Run::Phylo::LVB;

  # Create a SimpleAlign object.
  # NOTE. Aligning nucleotide sequence directly, as below, makes
  # sense for non-coding nucleotide sequence (e.g., structural RNA
  # genes, introns, ITS). For protein-coding genes, to prevent
  # Clustal intronducing frameshifts one should instead align the
  # translations of the genes, then convert the multiple alignment
  # to nucleotide by referring to the corresponding transcript
  # sequences (e.g., using EMBOSS tranalign).
  use Bio::Tools::Run::Alignment::Clustalw;
  $aln_factory = Bio::Tools::Run::Alignment::Clustalw->new(quiet => 1);
  $inputfilename = "/Users/daniel/nuc.fa";
  $aln = $aln_factory->align($inputfilename);

  # Create the tree or trees.
  $tree_factory = Bio::Tools::Run::Phylo::LVB->new(quiet => 1);
  @trees = $tree_factory->run($aln);

  # Or one can pass in a file name containing a nucleotide multiple
  # alignment in Phylip 3.6 format:
  $tree_factory = Bio::Tools::Run::Phylo::LVB->new(quiet => 1);
  $tree = $tree_factory->run("/Users/daniel/nuc.phy");

=head1 DESCRIPTION

Wrapper for LVB, which uses a simulated annealing heuristic search
to seek parsimonious trees from a nucleotide multiple alignment.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists.  Your participation is much appreciated.

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

=head1 PARAMETERS FOR LVB COMPUTATION

=head2 FORMAT

  Title       : FORMAT
  Description : (optional)
                When running LVB from a Phylip 3.6-format
                multiple alignment file, this specifies
                the layout of the file. It may be
                "interleaved" or "sequential". FORMAT is
                automatically set to "interleaved" if
                running from a SimpleAlign object.
                Defaults to "interleaved".

=head2 GAPS

  Title       : GAPS
  Description : (optional)
                LVB can treat gaps represented in the
                multiple alignment by "-" as either
                "fifthstate" or "unknown". "fifthstate"
                regards "-" as equivalent to "O", which
                is an unambiguous character state
                distinct from all nucleotides. "unknown"
                regards "-" as equivalent to "?", which
                is as an ambiguous site that may contain
                "A" or "C" or "G" or "T" or "O".
                Defaults to "unknown".

=head2 SEED

  Title       : SEED
  Description : (optional)
                This specifies the random number seed
                for LVB. SEED must be an integer in the
                range 0 to 900000000 inclusive. If no
                seed is specified, LVB takes a seed from
                the system clock. By default, no seed is
                specified.

=head2 DURATION

  Title       : DURATION
  Description : (optional)
                This specifies the duration of the
                analysis, which may be "fast" or "slow".
                "slow" causes LVB to perform a more
                thorough and more time-consuming search
                than "fast". Defaults to "slow".

=head2 BOOTSTRAPS

  Title       : BOOTSTRAPS
  Description : (optional)
                This specifies the number of bootstrap
                replicates to use, which must be a
                positive integer. Set bootstraps to 0 for
                no bootstrapping. Defaults to 0.

=head1 AUTHOR

Daniel Barker

=head1 CONTRIBUTORS

Email jason-AT-bioperl_DOT_org

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

#'

package Bio::Tools::Run::Phylo::LVB;

use vars qw($AUTOLOAD @ISA $PROGRAM $PROGRAMDIR $PROGRAMNAME
	    @LVB_PARAMS @OTHER_SWITCHES
	    %OK_FIELD);
use strict;
use Bio::SimpleAlign;
use Cwd;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Root::Root;
use Bio::Tools::Run::WrapperBase;
use Bio::Root::IO;
use File::Copy;

@ISA = qw(Bio::Root::Root  Bio::Tools::Run::WrapperBase);

# You will need to enable the LVB program.
# You can set the path to the program through doing:
# my @params('executable'=>'/usr/local/bin/lvb');
# my $lvb_factory = Bio::Tools::Run::Phylo::LVB->new(@params);
# 

BEGIN {
    # NOTE. The order of the members of @LVB_PARAMS is vital!
    @LVB_PARAMS = qw(FORMAT GAPS SEED DURATION BOOTSTRAPS);
    @OTHER_SWITCHES = qw(QUIET);
    foreach my $attr(@LVB_PARAMS, @OTHER_SWITCHES) {
        $OK_FIELD{$attr}++;
    }
} 

=head2 program_name

 Title   : program_name
 Usage   : ->program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
            return 'lvb';
}

=head2 program_dir

 Title   : program_dir
 Usage   : ->program_dir()
 Function: returns undef
 Args    :

=cut

sub program_dir {
    return undef;
}

sub new {
    my ($class,@args) = @_;
    my $self = $class->SUPER::new(@args);

    # set defaults
    $self->FORMAT("interleaved");
    $self->GAPS("unknown");
    $self->SEED("");
    $self->DURATION("slow");
    $self->BOOTSTRAPS(0);

    # re-set with user's values where specified
    my ($attr, $value);
    while (@args)  {
	$attr =   shift @args;
	$value =  shift @args;
	next if( $attr =~ /^-/ ); # don't want named parameters
        $self->$attr($value);	
    }
    return $self;
}

sub AUTOLOAD {
    my $self = shift;
    my $attr = $AUTOLOAD;
    $attr =~ s/.*:://;
    $attr = uc $attr;
    $self->throw("Unallowed parameter: $attr !") unless $OK_FIELD{$attr};
    $self->{$attr} = shift if @_;
    return $self->{$attr};
}

=head2  run 

 Title   : run 
 Usage   :
	$inputfilename = '/Users/daniel/nuc.phy';
	@trees = $factory->run($inputfilename);
 Function: Create one or more LVB trees from a SimpleAlign
           object or a file containing a Phylip 3.6-format
           nucleotide multiple alignment.
 Example :
 Returns : Array of L<Bio::Tree> objects
 Args    : Name of a file containing a nucleotide multiple
           alignment in Phylip 3.6 format, or a SimpleAlign
           object

=cut

sub run{
  
    my ($self,$input) = @_;
    my ($infilename);

    # Create input file pointer
    $infilename = $self->_setinput($input);
    if (!$infilename) {$self->throw("Problems setting up for lvb. Probably bad input data in $input !");}
    
    # Create parameter string to pass to lvb program
    my $param_string = $self->_setparams();

    # run lvb
    my @trees = $self->_run($infilename,$param_string);
}

=head2  create_tree

 Title   : create_tree
 Usage   :
        $inputfilename = '/Users/daniel/nuc.phy';
        @trees = $factory->create_tree($inputfilename);
 Function: Create one or more LVB trees from a SimpleAlign
           object or a file containing a Phylip 3.6-format
           nucleotide multiple alignment.
 Example :
 Returns : Array of L<Bio::Tree> objects
 Args    : Name of a file containing a nucleotide multiple 
           alignment in Phylip 3.6 format, or a SimpleAlign
           object

=cut

sub create_tree{
  return shift->run(@_);
}

#################################################

=head2  _run

 Title   : _run
 Usage   : Internal function, not to be called directly	
 Function:  makes actual system call to lvb program
 Example :
 Returns : Array of Bio::Tree objects
 Args    : Name of a file containing a multiple alignment
           in Phylip 3.6 format and a parameter string to be
           passed to LVB

=cut

sub _run {
    my ($self,$infile,$param_string) = @_;
    return unless(  $self->executable );

    my $instring;
    my $curpath = cwd;    
    unless( File::Spec->file_name_is_absolute($infile) ) {
	$infile = $self->io->catfile($curpath,$infile);
    }
    $instring =  $param_string;
    $self->debug( "Program ".$self->executable || ''."\n");

    # create LVB's working copy of the input file, which must be named "infile"
    # NOTE, we cut trailing spaces since they can cause trouble with LVB 2.1
    my $lvb_infile = $self->tempdir . "/infile";
    open(LVB_SUB_RUN_TMP_IN_FH, "$infile");
    open(LVB_SUB_RUN_TMP_OUT_FH, ">$lvb_infile");
    while (<LVB_SUB_RUN_TMP_IN_FH>) {
	s/ +$//;
        print LVB_SUB_RUN_TMP_OUT_FH
	    or $self->throw("output error on $lvb_infile");
    }
    chdir($self->tempdir);
    #open a pipe to run lvb to bypass interactive menus
    if ($self->quiet() || $self->verbose() < 0) {
    	open(LVB_PIPE,"|".$self->executable.">/dev/null");
    }
    else {
    	open(LVB_PIPE,"|".$self->executable);
    }
    print LVB_PIPE $instring;
    close(LVB_PIPE);	
    chdir($curpath);
    #get the results
    my $treefile = $self->tempdir . "/outtree";
    
    $self->throw("LVB did not create treefile correctly") 
  	unless (-e $treefile);

    #create the trees
    my $in  = Bio::TreeIO->new(-file => $treefile, '-format' => 'newick');
    my @trees = ();
    while (my $tree = $in->next_tree()) {
	push @trees, $tree;
    }

    unless ( $self->save_tempfiles ) {
	# Clean up the temporary files created along the way...	
	unlink $lvb_infile;
	unlink $treefile;
    }
    return @trees;
}

=head2  _setinput

 Title   :  _setinput
 Usage   :  Internal function, not to be called directly	
 Function:   Create input file for lvb program
 Example :
 Returns : name of file containing a multiple alignment in
           Phylip 3.6 format 
 Args    : SimpleAlign object reference or input file name

=cut

sub _setinput {
    my ($self, $input, $suffix) = @_;
    my ($alnfilename,$infilename, $temp, $tfh,$input_tmp,$input_fh);

    # If $input is not a  reference it better be the name of a
    # file with the sequence/

    #  a phy formatted alignment file 
    unless (ref $input) {
        # check that file exists or throw
        $alnfilename= $input;
        unless (-e $input) {return 0;}
	return $alnfilename;
    }

    #  $input may be a SimpleAlign Object
    if ($input->isa("Bio::Align::AlignI")) {
        #  Open temporary file for both reading & writing of BioSeq array
	($tfh,$alnfilename) = $self->io->tempfile(-dir=>$self->tempdir);
	my $alnIO = Bio::AlignIO->new(-fh => $tfh, -format=>'phylip',idlength=>$10);
	$alnIO->write_aln($input);
	$alnIO->close();
	close($tfh);
	$tfh = undef;
	unless ($self->format() =~ /^interleaved$/i) {
	    $self->warn("resetting LVB format to interleaved");
	    $self->format("interleaved");
	}
	return $alnfilename;		
    }
    return 0;
}

=head2  _setparams

 Title   :  _setparams
 Usage   :  Internal function, not to be called directly	
 Function:   Create parameter inputs for lvb program
 Example :
 Returns : parameter string to be passed to LVB
 Args    : name of calling object

=cut

sub _setparams {
    my ($attr, $value, $self);

    $self = shift;
    my $param_string = "";

    for $attr (@LVB_PARAMS) {
        $value = $self->$attr();
	if ($attr =~/SEED/i) {
	    $value = "" unless defined $value;
	    $param_string .= "$value\n";
	} elsif ($attr  =~ /BOOTSTRAPS/i) {
	    $value = 0 unless defined $value;
	    $param_string .= "$value\n";
	} else {	# we want I for "interleaved" or S for "sequential",
                        # U for "unknown" or F for "fifthstate",
			# F for "fast" or S for "slow"
	    $param_string .= uc(substr $value, 0, 1) . "\n";
	}
    }

    return $param_string;
}

1; # Needed to keep compiler happy
