# $Id$
#
# BioPerl module for Bio::Tools::Run::Phylo::Gumby
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Sendu Bala <bix@sendu.me.uk>
#
# Copyright Sendu Bala
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Phylo::Gumby - Wrapper for gumby

=head1 SYNOPSIS

  use Bio::Tools::Run::Phylo::Gumby;

  # Make a Gumby factory
  $factory = Bio::Tools::Run::Phylo::Gumby->new();

  # Run gumby with an alignment and tree file
  my @results = $factory->run($alignfilename, $treefilename);

  # or with alignment object and tree objects
  @results = $factory->run($bio_simplalign, $bio_tree_tree);

  # or with alignment object and Bio::DB::Taxonomy object
  @results = $factory->run($bio_simplalign, $bio_db_taxonomy);

  # specify the positions of exons in (at least) one of the alignment sequences
  # to get better results
  $factory->econs(1);
  $factory->annots($gff_filename);
  @results = $factory->run($alignfilename, $treefilename);

  # or using feature objects
  $factory->annots(@bio_seqfeature_objects);
  @results = $factory->run($alignfilename, $treefilename);

  # (mixtures of all the above are possible)

  # look at the results
  foreach my $feat (@results) {
    my $seq_id = $feat->seq_id;
    my $start = $feat->start;
    my $end = $feat->end;
    my $score = $feat->score;
    my ($pvalue) = $feat->get_tag_values('pvalue');
    my ($kind) = $feat->get_tag_values('kind'); # 'all', 'exon' or 'nonexon'
  }

=head1 DESCRIPTION

This is a wrapper for running the gumby application by Shyam Prabhakar. You
can get details here: http://pga.lbl.gov/gumby/. Gumby is used for phylogenetic
footprinting/ shadowing.

You can try supplying normal gumby command-line arguments to new(), eg.

  $factory->new(-ratio => 2);

or calling arg-named methods (excluding the initial hyphen, eg.

  $factory->econs(1);

to set the -econs arg).


You will need to enable this Gumby wrapper to find the gumby program.
This can be done in (at least) three ways:

 1. Make sure the gumby executable is in your path.
 2. Define an environmental variable GUMBYDIR which is a 
    directory which contains the gumby application:
    In bash:

    export GUMBYDIR=/home/username/gumby/

    In csh/tcsh:

    setenv GUMBYDIR /home/username/gumby

 3. Include a definition of an environmental variable GUMBYDIR in
    every script that will use this Gumby wrapper module, e.g.:

    BEGIN { $ENV{GUMBYDIR} = '/home/username/gumby/' }
    use Bio::Tools::Run::Phylo::Gumby;

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

=head1 AUTHOR - Sendu Bala

Email bix@sendu.me.uk

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Phylo::Gumby;
use strict;

use Cwd;
use File::Spec;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Tools::GFF;
use Bio::Tools::Phylo::Gumby;

use base qw(Bio::Tools::Run::Phylo::PhyloBase);

our $PROGRAM_NAME = 'gumby';
our $PROGRAM_DIR = $ENV{'GUMBYDIR'};

# methods for the gumby args we support
our @PARAMS   = qw(annots ratio base plen prob);
our @SWITCHES = qw(econs);

# just to be explicit, args we don't support (yet) or we handle ourselves
our @UNSUPPORTED = qw(o minseq blklen);

=head2 program_name

 Title   : program_name
 Usage   : $factory>program_name()
 Function: holds the program name
 Returns : string
 Args    : None

=cut

sub program_name {
    return $PROGRAM_NAME;
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns : string
 Args    : None

=cut

sub program_dir {
    return $PROGRAM_DIR;
}

=head2 new

 Title   : new
 Usage   : $factory = Bio::Tools::Run::Phylo::Gumby->new()
 Function: creates a new Gumby factory
 Returns : Bio::Tools::Run::Phylo::Gumby
 Args    : Most options understood by gumby can be supplied as key =>
           value pairs.

           These options can NOT be used with this wrapper:
           o
           minseq
           blklen

=cut

sub new {
    my ($class, @args) = @_;
    my $self = $class->SUPER::new(@args);
    
    $self->_set_from_args(\@args, -methods => [@PARAMS, @SWITCHES, 'quiet'],
                                  -create => 1);
    
    return $self;
}

=head2 annots

 Title   : annots
 Usage   : $factory->annots(@gff_filenames)
 Function: Specify annotation files for gumby to use
 Returns : string of absolute filepaths to gff files
 Args    : list of gff filenames (can be relative), where the first column
           corresponds to a sequence id from the alignment that will be supplied
           to run()
           OR
           list of Bio::SeqFeatureI objects, which have seq_id() values that
           will correspond to the sequence ids from the alignment that will
           be supplied to run() (the objects will be grouped by seq_id and
           output to gff files for use by gumby; filepaths to those tempfiles
           will be returned). Note that all features must have source, seq_id
           and primary_tag set or none will be used.

           NB: feature coordinates must be relative to the parts of the
           sequences in the alignment you will supply, as though numbering
           started at 1 for each each sequence in the alignment. There is
           currently no automatic correction for this.

=cut

sub annots {
    my $self = shift;
    if (@_) {
        my @files;
        my %feats;
        foreach my $thing (@_) {
            if (ref($thing) && $thing->isa('Bio::SeqFeatureI')) {
                my $seq_id = $thing->seq_id || $self->throw("Supplied a feature with no seq_id");
                push(@{$feats{$seq_id}}, $thing);
            }
            elsif (-e $thing) {
                push(@files, File::Spec->rel2abs($thing));
            }
            else {
                $self->throw("'$thing' was not a Bio::SeqFeatureI or a file");
            }
        }
        
        if (keys %feats) {
            my $temp_dir = $self->tempdir;
            
            while (my ($seq_id, $feats) = each %feats) {
                my $temp_file = File::Spec->catfile($temp_dir, $seq_id.'.gff');
                $temp_file = File::Spec->rel2abs($temp_file);
                my $gffout = Bio::Tools::GFF->new(-file => ">$temp_file", -gff_version => 2);
                $gffout->write_feature(@{$feats});
                push(@files, $temp_file);
            }
        }
        
        $self->{annots} = \@files;
    }
    
    if (defined $self->{annots}) {
        return join(' ', @{$self->{annots}});
    }
    return;
}

=head2 run

 Title   : run
 Usage   : $result = $factory->run($fasta_align_file, $newick_tree_file);
           -or-
           $result = $factory->run($align_object, $tree_object);
           -or-
           $result = $factory->run($align_object, $db_taxonomy_object);
 Function: Runs gumby on an alignment.
 Returns : list of Bio::SeqFeature::Annotated (one per prediction and sequence)
 Args    : The first argument represents an alignment, the second argument
           a species tree.
           The alignment can be provided as a multi-fasta format alignment
           filename, or a Bio::Align::AlignI complient object (eg. a
           Bio::SimpleAlign).
           The species tree can be provided as a newick format tree filename
           or a Bio::Tree::TreeI complient object. Alternatively a
           Bio::DB::Taxonomy object can be supplied, in which case the species
           tree will be generated by using the alignment sequence names as
           species names and looking for those in the supplied database.

           In all cases, the alignment sequence names must correspond to node
           ids in the species tree. Multi-word species names should have the
           spaces removed to form the sequence names, eg. Homosapiens.
           Underscores may also be used for either or both of sequence and node
           ids ('Homo_sapiens'), but underscores will be removed internally.

           NB: Gumby treats each sequence in the alignment as starting at
           position 1. This method returns results with the coordinates
           corrected so they match the coordinates of your input alignment. Eg.
           if 'Homo_sapiens' sequence had the range 20..60 in your alignment,
           the first Gumby result might be 1..5 which is corrected to 20..24.

=cut

sub run {
    my ($self, $aln, $tree) = @_;
    
    ($aln && $tree) || $self->throw("alignment and tree must be supplied");
    $aln = $self->_alignment($aln);
    $tree = $self->_tree($tree);
    
    $tree->force_binary;
    
    # adjust seq & node ids to remove spaces and underscores (eg. if tree
    # generated from taxonomy/ user input bad names)
    foreach my $thing ($tree->get_leaf_nodes, $aln->each_seq) {
        my $id = $thing->id;
        $id =~ s/_aligned//; #*** dubious custom-handling for the allowed case of mlagan adding _aligned to id (according to gumby author)
        $id =~ s/[ _]//g;
        $thing->id($id);
    }
    my $new_aln = $aln->new;
    foreach my $seq ($aln->each_seq) {
        $new_aln->add_seq($seq);
    }
    $self->_alignment($new_aln);
    
    #*** at some stage we want to revert the ids back to original...
    
    # check node and seq names match
    $self->_check_names;
    
    return $self->_run; 
}

sub _run {
    my $self = shift;
    
    my $exe = $self->executable || return;
    
    # cd to a temp dir
    my $temp_dir = $self->tempdir;
    my $cwd = Cwd->cwd();
    chdir($temp_dir) || $self->throw("Couldn't change to temp dir '$temp_dir'");
    
    my $tree_file = 'tree_file';
    my $aln_file = $self->_write_alignment;
    
    # generate a gumby-friendly tree file
    my $tree = $self->_tree;
    $tree = $tree->simplify_to_leaves_string;
    open(my $tfhandle, '>', $tree_file) || $self->throw("Could not write to tree file '$tree_file'");
    print $tfhandle $tree, "\n";
    close($tfhandle);
    
    my $command = $exe.$self->_setparams($aln_file, $tree_file);
    $self->debug("gumby command = $command\n");
    
    open(PIPE, "$command |") || $self->throw("gumby call ($command) failed to start: $? | $!");
    my $error = '';
    while (<PIPE>) {
        print unless $self->quiet;
        if (/^ERROR: (.+)/ || /^mbgumbel\(\): (.+)/) {
            $error .= $1;
        }
    }
    close(PIPE) || ($error ? $self->warn("gumby call ($command) failed: $error") : $self->throw("gumby call ($command) crashed: $?"));
    
    my $aln = $self->_alignment();
    my %offsets;
    foreach my $seq ($aln->each_seq) {
        $offsets{lc($seq->id)} = $seq->start - 1;
    }
    
    my @feats = ();
    foreach my $file ('out_all.align', 'out_exon.align', 'out_nonexon.align') {
        -e $file || next;
        my $parser = Bio::Tools::Phylo::Gumby->new(-file => $file);
        
        while (my @results = $parser->next_result) {
            foreach my $result (@results) {
                my $this_adjust = $offsets{lc($result->seq_id)};
                $result->start($result->start + $this_adjust);
                $result->end($result->end + $this_adjust);
            }
            push(@feats, @results);
        }
        
        unlink($file);
    }
    
    # cd back again
    chdir($cwd) || $self->throw("Couldn't change back to working directory '$cwd'");
    
    return @feats;
}

=head2 _setparams

 Title   : _setparams
 Usage   : Internal function, not to be called directly
 Function: Creates a string of params to be used in the command string
 Returns : string of params
 Args    : alignment and tree file names

=cut

sub _setparams {
    my ($self, $aln_file, $tree_file) = @_;
    
    my $param_string = ' '.$tree_file;
    $param_string .= ' '.$aln_file;
    $param_string .= $self->SUPER::_setparams(-params => \@PARAMS,
                                              -switches => \@SWITCHES,
                                              -dash => 1,);
    $param_string .= ' -o out';
    $param_string .= ' 2>&1';
    $param_string .= ' 1>/dev/null' if $self->quiet;
    
    return $param_string;
}

1;
