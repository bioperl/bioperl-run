# $Id: Gerp.pm,v 1.3 2007/05/25 10:14:55 sendu Exp $
#
# BioPerl module for Bio::Tools::Run::Phylo::Gerp
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

Bio::Tools::Run::Gerp - Wrapper for GERP

=head1 SYNOPSIS

  use Bio::Tools::Run::Phylo::Gerp;

  # Make a Gerp factory
  $factory = Bio::Tools::Run::Phylo::Gerp->new();

  # Run Gerp with an alignment and tree file
  my $parser = $factory->run($alignfilename, $treefilename);

  # or with alignment object and tree object (which needs branch lengths)
  $parser = $factory->run($bio_simplalign, $bio_tree_tree);

  # (mixtures of the above are possible)

  # look at the results
  while (my $feat = $parser->next_result) {
    my $start = $feat->start;
    my $end = $feat->end;
    my $rs_score = $feat->score;
    my $p_value = ($feat->annotation->get_Annotations('p-value'))[0]->value;
  }

=head1 DESCRIPTION

This is a wrapper for running the GERP (v2) programs 'gerpcol' and 'gerpelem' by
Eugene Davydov (originally Gregory M. Cooper et al.). You can get details here:
http://mendel.stanford.edu/sidowlab/. GERP can be used for phylogenetic
footprinting/ shadowing (it finds 'constrained elements in multiple
alignments').

You can try supplying normal gerpcol/gerpelem command-line arguments to new(),
eg. $factory-E<gt>new(-e =E<gt> 0.05) or calling arg-named methods, eg.
$factory-E<gt>e(0.05). The filename-related args (t, f, x) are handled internally
by the run() method. This wrapper currently only supports running GERP on a
single alignment at a time (ie. F isn't used at all, nor are multiple fs
possible).


You will need to enable this GERP wrapper to find the GERP executables.
This can be done in (at least) three ways:

 1. Make sure gerpcol and gerpelem are in your path.
 2. Define an environmental variable GERPDIR which is a 
    directory which contains the GERP executables:
    In bash:

    export GERPDIR=/home/username/gerp/

    In csh/tcsh:

    setenv GERPDIR /home/username/gerp

 3. Include a definition of an environmental variable GERPDIR in
    every script that will use this GERP wrapper module, e.g.:

    BEGIN { $ENV{GERPDIR} = '/home/username/gerp/' }
    use Bio::Tools::Run::Phylo::Gerp;

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

package Bio::Tools::Run::Phylo::Gerp;
use strict;

use Cwd;
use File::Spec;
use File::Basename;
use Bio::AlignIO;
use Bio::TreeIO;
use Bio::Tools::Phylo::Gerp;

use base qw(Bio::Tools::Run::Phylo::PhyloBase);

our $PROGRAM_NAME = 'gerpcol';
our $PROGRAM_DIR;

# methods for the gerp args we support
our @COLPARAMS   = qw(r n s);
our @ELEMPARAMS  = qw(l L t d p b a c r e);
our @SWITCHES    = qw(v);

# just to be explicit, args we don't support (yet) or we handle ourselves
our @UNSUPPORTED = qw(h t f F x);

BEGIN {
    # lets add all the gerp executables to the path
    $PROGRAM_DIR = $ENV{'GERPDIR'};
    $ENV{PATH} = "$PROGRAM_DIR:$ENV{PATH}" if $PROGRAM_DIR;
}

=head2 program_name

 Title   : program_name
 Usage   : $factory>program_name()
 Function: holds the program name
 Returns : string
 Args    : None

=cut

sub program_name {
    my $self = shift;
    if (@_) { $self->{program_name} = shift }
    return $self->{program_name} || $PROGRAM_NAME;
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
 Usage   : $factory = Bio::Tools::Run::Phylo::Gerp->new()
 Function: creates a new GERP factory
 Returns : Bio::Tools::Run::Phylo::Gerp
 Args    : Most options understood by GERP can be supplied as key =>
           value pairs.

           These options can NOT be used with this wrapper:
           h, t, f, F and x

=cut

sub new {
    my ($class, @args) = @_;
    my $self = $class->SUPER::new(@args);
    
    $self->_set_from_args(\@args, -methods => [@COLPARAMS, @ELEMPARAMS,
                                               @SWITCHES, 'quiet'],
                                  -create => 1);
    
    return $self;
}

=head2 run

 Title   : run
 Usage   : $parser = $factory->run($align_file, $tree_file);
           -or-
           $parser = $factory->run($align_object, $tree_object);
 Function: Runs GERP on an alignment.
 Returns : Bio::Tools::Phylo::Gerp parser object, containing the results
 Args    : The first argument represents an alignment, the second argument
           a phylogenetic tree with branch lengths.
           The alignment can be provided as a MAF format alignment
           filename, or a Bio::Align::AlignI complient object (eg. a
           Bio::SimpleAlign).
           The species tree can be provided as a newick format tree filename
           or a Bio::Tree::TreeI complient object.

           In all cases, the alignment sequence names must correspond to node
           ids in the tree. Multi-word species names should have the
           spaces replaced with underscores (eg. Homo_sapiens)

=cut

sub run {
    my ($self, $aln, $tree) = @_;
    $self->_alignment($aln || $self->throw("An alignment must be supplied"));
    $self->_tree($tree || $self->throw("A phylo tree must be supplied"));
    
    # check node and seq names match
    $self->_check_names;
    
    return $self->_run;
}

sub _run {
    my $self = shift;
    
    $self->executable || return;
    
    # cd to a temp dir
    my $temp_dir = $self->tempdir;
    my $cwd = Cwd->cwd();
    chdir($temp_dir) || $self->throw("Couldn't change to temp dir '$temp_dir'");
    
    foreach my $prog ('gerpcol', 'gerpelem') {
        delete $self->{'_pathtoexe'};
        $self->program_name($prog);
        my $exe = $self->executable || $self->throw("'$prog' executable not found");
        
        my $command = $exe.$self->_setparams($prog);
        $self->debug("gerp command = $command\n");
        
        #eval {
        #    local $SIG{ALRM} = sub { die "alarm\n" };
        #    alarm 60;
        #    system($command) && $self->throw("gerp call ($command) failed: $! | $?");
        #    alarm 0;
        #};
        #die if $@ && $@ ne "alarm\n";
        #if ($@) {
        #    die "Gerp timed out\n";
        #}
        #
        # system("rm -fr $cwd/gerp_dir; cp -R $temp_dir $cwd/gerp_dir");
        
        open(my $pipe, "$command |") || $self->throw("gerp call ($command) failed to start: $? | $!");
        my $error = '';
        my $warning = '';
        while (<$pipe>) {
            if ($self->quiet) {
                $error .= $_;
                $warning .= $_ if /warning/i;
            }
            else {
                print;
            }
        }
        close($pipe) || ($error ? $self->throw("gerp call ($command) failed: $error") : $self->throw("gerp call ($command) crashed: $?"));
        
        # (throws most likely due to seg fault in gerpelem when ~25000 entries
        #  in rates file, not much I can do about it!)
        
        $self->warn("GERP: ".$warning) if $warning;
    }
    
    #system("rm -fr $cwd/gerp_dir; cp -R $temp_dir $cwd/gerp_dir");
    
    my $result_file = $self->{align_base}.'.rates.elems';
    my $parser = Bio::Tools::Phylo::Gerp->new(-file => $result_file);
    
    # cd back again
    chdir($cwd) || $self->throw("Couldn't change back to working directory '$cwd'");
    
    return $parser;
}

=head2 _setparams

 Title   : _setparams
 Usage   : Internal function, not to be called directly
 Function: Creates a string of params to be used in the command string
 Returns : string of params
 Args    : none

=cut

sub _setparams {
    my ($self, $prog) = @_;
    
    my $param_string;
    if ($prog eq 'gerpcol') {
        my $align_file = $self->_write_alignment;
        $param_string .= ' -f '.$align_file;
        $self->{align_base} = basename($align_file);
        $param_string .= ' -t '.$self->_write_tree;
        $param_string .= $self->SUPER::_setparams(-params => \@COLPARAMS,
                                                  -switches => \@SWITCHES,
                                                  -dash => 1);
    }
    else {
        $param_string .= ' -f '.$self->{align_base}.'.rates';
        $param_string .= $self->SUPER::_setparams(-params => \@ELEMPARAMS,
                                                  -switches => \@SWITCHES,
                                                  -dash => 1);
    }
    
    $param_string .= " 2>&1";
    
    return $param_string;
}

1;
