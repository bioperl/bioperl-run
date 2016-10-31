#
# BioPerl module for Bio::Tools::Run::Phylo::ExaML
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Hannes Hettling <hannes.hettling@naturalis.nl> 
# and Rutger Vos <rutger.vos@naturalis.nl>
#
# Copyright Rutger Vos, Hannes Hettling
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Phylo::ExaML - tree inference wrapper for ExaML

=head1 SYNOPSYS

 use Bio::Tools::Run::Phylo::ExaML;
 my $examl Bio::Tools::Run::Phylo::ExaML->new;
 $examl->outfile_name('out.tre');
 $examl->t('start.tre')
 $examl->m('GAMMA');
 $examl->quiet(1);
 # optional: use mpirun for parallel inference
 $examl->mpirun('mpirun') # mpirun must be in PATH
 $examl->cores(4)

 $examl->run('infile.phy');

=head1 DESCRIPTION

Infers a large phylogeny using the ExaML program. Input files must be in PHYLIP format,
(so far this has only been tested with interleaved PHYLIP), output file contains an
unrooted tree in Newick format. If no starting tree is provided with option 't',
a neighbor joining starting tree will be constructed. Parallel inference is supported
using 'mpirun'. To this end, the location of mpirun (if not in PATH) and the number of cores 
can be specified.

=head1 METHODS

B<Note:> in addition to the methods described below, all the arguments described for the
constructor can be used as methods as well. For example, the argument C<-B> becomes:

 $examl->B($num);

=over

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

=head1 AUTHOR - Hannes Hettling & Rutger Vos

Email hannes.hettling@naturalis.nl, rutger.vos@naturalis.nl

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

package Bio::Tools::Run::Phylo::ExaML;

use strict;
use version;
use Cwd;
use File::Basename;
use File::Spec;
use File::Temp 'tempfile';
use Bio::Align::DNAStatistics;
use Bio::Tree::DistanceFactory;	
use Bio::Tools::Run::Phylo::PhyloBase;
use base qw(Bio::Tools::Run::Phylo::PhyloBase);

our $PROGRAM_NAME = 'examl';
our $PARSER_NAME = 'parse-examl';
our @ExaML_PARAMS = qw(B c e f i m p w);
our @ExaML_SWITCHES = qw(a D M Q S);

# Specify model if none is specified
my $DEFAULTMODEL = 'GAMMA';

=head2 new

 Title   : new
 Usage   : my $treebuilder = Bio::Tools::Run::Phylo::ExaML->new();
 Function: Constructor
 Returns : Bio::Tools::Run::Phylo::ExaML
 Args    : Same as those used to run examl. For example:
           my $examl Bio::Tools::Run::Phylo::ExaML->new( -m => "Gamma", -B => 10 );

The constructor takes the following optional, named arguments that require appropriate 
values:

 '-B' # specify the number of best ML trees to save and print to file
 '-c' # Specify number of distinct rate catgories for ExaML when modelOfEvolution
        is set to GTRPSR. Individual per-site rates are categorized into 
        numberOfCategories rate categories to accelerate computations. DEFAULT: 25
 '-e' # set model optimization precision in log likelihood units for final
        optimization of model parameters. DEFAULT: 0.1
 '-f' # select algorithm: 
 			'-f' => 'd': new rapid hill-climbing DEFAULT: ON
            '-f' => 'o': old and slower rapid hill-climbing without heuristic cutoff
 '-i' # Initial rearrangement setting for the subsequent application of topological 
        changes phase
 '-m' # Model of rate heterogeneity:
			'-m' => 'PSR' for the per-site rate category model (this used to be called 
			        CAT in RAxML)
			'-m' => 'GAMMA' for the gamma model of rate heterogeneity with 4 discrete 
         	        rates

In addition, the following optional, named arguments that require booleans are available:

 '-a' # use the median for the discrete approximation of the GAMMA model of rate 
        heterogeneity. DEFAULT: OFF
 '-D' # ML search convergence criterion. This will break off ML searches if the relative 
        Robinson-Foulds distance between the trees obtained from two consecutive lazy SPR 
        cycles is smaller or equal to 1%. Usage recommended for very large datasets in 
        terms of taxa. On trees with more than 500 taxa this will yield execution time 
        improvements of approximately 50% while yielding only slightly worse trees.
        DEFAULT: OFF
 '-M' # Switch on estimation of individual per-partition branch lengths. Only has effect 
        when used in combination with "-q". Branch lengths for individual partitions will 
        be printed to separate files. A weighted average of the branch lengths is computed 
        by using the respective partition lengths.
 '-Q' # Enable alternative data/load distribution algorithm for datasets with many 
        partitions. In particular under PSR this can lead to parallel performance 
        improvements of up to factor 10!
 '-S' # turn on memory saving option for gappy multi-gene alignments. For large and gappy 
        datasets specify -S to save memory. This will produce slightly different 
        likelihood values, may be a bit slower but can reduce memory consumption from 
        70GB to 19GB on very large and gappy datasets.
 '-w' # FULL (!) path to the directory into which ExaML shall write its output files

=cut

sub new {
    my ( $class, @args ) = @_;
    my $self = $class->SUPER::new(@args);
    $self->_set_from_args(
        \@args,
        '-methods' => [ @ExaML_PARAMS, @ExaML_SWITCHES ],
        '-create'  => 1,
    );
    my ($out, $quiet) = $self->SUPER::_rearrange( [qw(OUTFILE_NAME QUIET)], @args );
    $self->outfile_name( $out || '' );
    $self->quiet( $quiet ) if $quiet;

    return $self;
}

=item program_name

Returns the local name of the wrapped program, i.e. 'examl'.

=cut

sub program_name { $PROGRAM_NAME }

=item program_dir

(no-op)

=cut

sub program_dir { undef }

=item run_id

Getter/setter for an ID string for this run. by default based on the PID. this only has
to be unique during the runtime of this process, all files that have the run ID in them
are cleaned up afterwards.

=cut

sub run_id {
	my $self = shift;
	if ( @_ ) {
		$self->{'_run_id'} = shift;
	}
	return $self->{'_run_id'} || "examl-run-$$";
}

=item work_dir

Getter/setter. Intermediate files will be written here.

=cut

sub work_dir {
	my $self = shift;
	if ( @_ ) {
		$self->{'_workdir'} = shift;
	}
	return $self->{'_workdir'} || '.';
}

=item parser

Getter/setter for the location of the parser program (which creates a compressed, binary 
representation of the input alignment) that comes with examl. By default this is named parse-examl
and should be in the PATH.

=cut

sub parser {
	my ( $self, $parser ) = @_;
	if ( $parser ) {
		$self->{'_parser'} = $parser;
	}
	return $self->{'_parser'} || $PARSER_NAME;
}

=item mpirun

Getter/setter for the location of the mpirun program for parallelized runs. When unset,
no parallelization is attempted.

=cut

sub mpirun {
	my ( $self, $mpirun ) = @_;
	if ( $mpirun ) {
		$self->{'_mpirun'} = $mpirun;
	}
	return $self->{'_mpirun'};
}

=item cores

Getter/setter for number of mpi cores

=cut

sub cores {
	my ( $self, $nodes ) = @_;
	if ( $nodes ) {
		$self->{'_cores'} = $nodes;
	}
	return $self->{'_cores'};
}

=item version

Returns the version number of the ExaML executable.

=cut

sub version {
    my ($self) = @_;
    my $exe;
    return undef unless $exe = $self->executable;
    my $string = `$exe -v 2>&1`;
    $string =~ /ExaML version (\d+\.\d+\.\d+)/;
    return $1 || undef;
}

=item run

Runs the analysis. 

=back

=cut

sub run {
 	my ( $self, $matrix, $intree ) = @_;

	# set alignment object
	$self->_alignment($matrix);
	
	# examl wants to run inside the dir with data
	my $curdir = getcwd;
	chdir $self->work_dir;	
	
	# generate random starting tree if not given
	$intree = $self->_make_starttree if not $intree;

	my $binary = $self->_make_binary( $matrix, $self->run_id . '-dat' );

	# compose argument string: add MPI commands, if any
	my $string;
	if ( $self->mpirun && $self->cores ) {
		$string = sprintf '%s -np %i ', $self->mpirun, $self->nodes;
	}

	# add executable and parameters
	$string .= $self->executable . $self->_setparams($binary,$intree);
	system($string) and die("Couldn't run ExaML: $?");
	chdir $curdir;
	
	# remove cruft
	$self->_cleanup;
	
	my $treeio = Bio::TreeIO->new( -file => $self->outfile_name );
    my $tree = $treeio->next_tree;

	return $tree;
}

sub _cleanup {
	my $self = shift;
	my $dir  = $self->work_dir;
	my ( $outv, $outd, $out ) = File::Spec->splitpath($self->outfile_name);
	my $run  = $self->run_id;
	opendir my $dh, $dir or die $!;
	while( my $entry = readdir $dh ) {
		if ( $entry =~ /^ExaML_binaryCheckpoint\.${out}_\d+$/ ) {
			unlink "${dir}/${entry}";
		}
		elsif ( $entry =~ /^ExaML_(?:info|log).${out}$/ ) {
			unlink "${dir}/${entry}";		
		}
		elsif ( $entry =~ /^${run}-dat\.binary$/ ) {
			unlink "${dir}/${entry}";		
		}
		elsif ( $entry =~ /^${run}\.(?:dnd|phy)$/ ) {
			unlink "${dir}/${entry}";		
		}
		elsif ( $entry =~ /^RAxML_info\.${run}-dat$/ ) {
			unlink "${dir}/${entry}";		
		}
	}
	rename "${dir}/ExaML_result\.${out}", $self->outfile_name;
	return $self->outfile_name;
}

sub _setparams {
    my ( $self, $infile, $intree ) = @_;
    my $param_string = '';

	# set default model if not specified
	if ( !$self->m ) {
		$self->m($DEFAULTMODEL);
	}
	
	# iterate over parameters and switches
    for my $attr (@ExaML_PARAMS) {
        my $value = $self->$attr();
        next unless defined $value;
        $param_string .= ' -' . $attr . ' ' . $value;
    }
    for my $attr (@ExaML_SWITCHES) {
        my $value = $self->$attr();
        next unless $value;
        $param_string .= ' -' . $attr;
    }

    # Set default output file if no explicit output file has been given
    if ( ! $self->outfile_name ) {
        my ( $tfh, $outfile ) = $self->io->tempfile( '-dir' => $self->work_dir );
        close $tfh;
        undef $tfh;
        $self->outfile_name($outfile);
    }
    
    # set file names to local
    my %path = ( '-t' => $intree, '-s' => $infile, '-n' => $self->outfile_name );
	while( my ( $param, $path ) = each %path ) {
		my $file = $path;
		# Examl doesn't like '/' in outfile argument -n
		$file = basename($file) if $param eq '-n';
		$param_string .= " $param $file";
	}

    # hide stderr
    my $null = File::Spec->devnull;
    $param_string .= " > $null 2> $null" if $self->quiet() || $self->verbose < 0;
	
    return $param_string;
}

=item _make_starttree

Make a NJ starting tree using Kimura distance metrics
This method is used when no starting tree is provided

=cut

sub _make_starttree {
	my $self = shift;

	die('Alignment object not set') if not $self->_alignment; 
	
	my $stats = Bio::Align::DNAStatistics->new;

    my ($tfh, $tempfile) = $self->io->tempfile(-dir => $self->tempdir);

	my $dfactory = Bio::Tree::DistanceFactory->new(-method => 'NJ');
	my $treeout = Bio::TreeIO->new(-format => 'newick', -file => ">$tempfile");
	my $mat = $stats->distance(-method => 'Kimura', -align  => $self->_alignment);
	my $tree = $dfactory->make_tree($mat);
	$treeout->write_tree($tree);
	
	return $tempfile;
}

=item _make_binary

Given the location of a file in phylip format and a name for the binary file, 
creates a binary representation of the phylip file using the examl parser 
writes it to the specified file. By default, examl appends the suffix '.binary'.
to the input binary file name.

=cut

sub _make_binary {
	my ( $self, $phylip, $binfilename ) = @_;

	my @command = ( $self->parser,
		'-m' => 'DNA',
		'-s' => $phylip,
		'-n' => $binfilename,
		'>'  => File::Spec->devnull,
		'2>' => File::Spec->devnull,
	);
	my $string = join ' ', @command;
	system($string) and warn("Couldn't execute command '$string': $! (errno: $?)");
	
	return "${binfilename}.binary";
}


1;
