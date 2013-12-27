# BioPerl module for Meme
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

Bio::Tools::Run::Meme - Wrapper for Meme Program

=head1 SYNOPSIS

  use Bio::Tools::Run::Meme;

  my $factory = Bio::Tools::Run::Meme->new(-dna => 1, -mod => 'zoops');

  # return a Bio::AlignIO given Bio::PrimarySeqI objects
  my $alignio = $factory->run($seq1, $seq2, $seq3...);

  # add a Bio::Map::Prediction to the appropriate maps given Bio::Map::GeneMap
  # objects (predict on the full map sequences supplied) or Bio::Map::Gene
  # objects (predict on the full map sequences of the maps the supplied Genes
  # are on) or Bio::Map::PositionWithSequence objects
  my $prediction = $factory->run($biomap1, $biomap2, $biomap3...);

=head1 DESCRIPTION

This is a wrapper for running meme, a transcription factor binding site
prediction program. It can be found here:
http://meme.sdsc.edu/meme4/meme-download.html

You can try supplying normal meme command-line arguments to new(), eg.
new(-mod => 'oops') or calling arg-named methods (excluding the initial
hyphen(s), eg. $factory->mod('oops') to set the -mod option to 'oops').


You will need to enable this MEME wrapper to find the meme program. During
standard installation of meme you will have set up an environment variable
called MEME_BIN which is used for this purpose.

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

=head1 AUTHOR - Sendu Bala

Email bix@sendu.me.uk

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a "_".

=cut

package Bio::Tools::Run::Meme;

use strict;
use Bio::SeqIO;
use Bio::AlignIO;
use Bio::Map::Prediction;
use Bio::Map::Position;

use base qw(Bio::Tools::Run::WrapperBase);

our $PROGRAM_NAME = 'meme';
our $PROGRAM_DIR = $ENV{'MEME_BIN'};

# methods for the meme args we support
our @PARAMS   = qw(mod nmotifs evt nsites minsites maxsites wnsites w minw maxw
                   wg ws bfile maxiter distance prior b plib spfuzz spmap cons
                   maxsize p time sf);
our @SWITCHES = qw(dna protein nomatrim noendgaps revcomp pal);

# just to be explicit, args we don't support (yet) or we handle ourselves
our @UNSUPPORTED = qw(h text nostatus);


=head2 new

 Title   : new
 Usage   : $rm->new($seq)
 Function: creates a new wrapper
 Returns:  Bio::Tools::Run::Meme
 Args    : Most options understood by meme can be supplied as key =>
           value pairs, with a boolean value for switches. -quiet can also be
           set to silence meme completely.

           These options can NOT be used with this wrapper (they are handled
           internally or don't make sense in this context):
           -h -text -nostatus

=cut

sub new {
    my ($class, @args) = @_;
    my $self = $class->SUPER::new(@args);
    
    $self->_set_from_args(\@args, -methods => [@PARAMS, @SWITCHES, 'quiet'],
                                  -create => 1);
    
    return $self;
}

=head2 program_name

 Title   : program_name
 Usage   : $factory>program_name()
 Function: holds the program name
 Returns:  string
 Args    : None

=cut

sub program_name {
    return $PROGRAM_NAME;
}

=head2 program_dir

 Title   : program_dir
 Usage   : $factory->program_dir(@params)
 Function: returns the program directory, obtained from ENV variable.
 Returns:  string
 Args    :

=cut

sub program_dir {
    return $PROGRAM_DIR;
}

=head2  version

 Title   : version
 Usage   : n/a
 Function: Determine the version number of the program, which is
           non-discoverable for Meme
 Returns : undef
 Args    : none

=cut

sub version {
    return;
}

=head2 run

 Title   : run
 Usage   : $rm->run($seq1, $seq2, $seq3...);
 Function: Run Meme on the sequences/Bio::Map::* set as the argument
 Returns : Bio::AlignIO if sequence objects supplied, OR
           Bio::Map::Prediction if Bio::Map::* objects supplied
           undef if no executable found
 Args    : list of Bio::PrimarySeqI compliant objects, OR
           list of Bio::Map::GeneMap objects, OR
           list of Bio::Map::Gene objects, OR
           list of Bio::Map::PositionWithSequence objects

=cut

sub run {
    my ($self, @things) = @_;
    
    my $infile = $self->_setinput(@things);
    
    return $self->_run($infile);
}

=head2  _run

 Title   : _run
 Usage   : $rm->_run ($filename,$param_string)
 Function: internal function that runs meme
 Returns : as per run(), undef if no executable found
 Args    : the filename to the input sequence file

=cut

sub _run {
    my ($self, $infile) = @_;
    
    my $exe = $self->executable || return;
    
    my $outfile = $infile.".out";
    
    my $command = $exe.$self->_setparams($infile, $outfile);
    $self->debug("meme command = $command\n");
    
    open(my $pipe, "$command |") || $self->throw("meme call ($command) failed to start: $? | $!");
    my $error = '';
    while (<$pipe>) {
        print unless $self->quiet;
        $error .= $_;
    }
    close($pipe) || ($error ? $self->throw("meme call ($command) failed: $error") : $self->throw("meme call ($command) crashed: $?"));
    
    #my $status = system($cmd_str);
    #$self->throw("Meme call ($cmd_str) crashed: $?\n") unless $status == 0;
    
    my $aio = Bio::AlignIO->new(-format => 'meme', -file => $outfile);
    unless ($self->{map_mode}) {
        # return directly the AlignIO
        return $aio;
    }
    else {
        # use the AlignIO meme parser to generate a Bio::Map::Prediction and
        # return that
        my $pred = Bio::Map::Prediction->new(-source => "meme");
        while (my $aln = $aio->next_aln) {
            foreach my $seq ($aln->each_seq) {
                my $id = $seq->id;
                unless ($id) {
                    $self->warn("Got a sequence in the alignment with no id, but I need one to determine the map");
                    next;
                }
                my ($uid) = $id =~ /^([^\[]+)/;
                my $map = Bio::Map::GeneMap->get(-uid => $uid);
                
                my ($start, $end) = ($seq->start, $seq->end);
                if ($seq->strand == -1) {
                    my $length;
                    my ($pos_s, $pos_e) = $id =~ /\[(\d+)\.\.(\d+)\]$/;
                    if (defined($pos_s) && defined($pos_e)) {
                        $length = $pos_e - $pos_s + 1;
                    }
                    else {
                        $length = length($map->seq);
                    }
                    my $motif_length = $end - $start + 1;
                    $end = $length - $start + 1;
                    $start = $end - $motif_length + 1;
                }
                
                Bio::Map::Position->new(-element => $pred,
                                        -start => $start,
                                        -end => $end,
                                        -map => $map);
            }
        }
        delete $self->{map_mode};
        return $pred;
    }
}

=head2  _setparams()

 Title   : _setparams
 Usage   : Internal function, not to be called directly
 Function: Create parameter inputs for meme program
 Returns : parameter string to be passed to meme
 Args    : none

=cut

sub _setparams {
    my ($self, $infile, $outfile) = @_;
    
    my $param_string = ' '.$infile;
    
    # -text and -nostatus must be set
    $param_string .= ' -text -nostatus';
    
    $param_string .= $self->SUPER::_setparams(-params => \@PARAMS,
                                              -switches => \@SWITCHES,
                                              -dash => 1);
    
    $param_string .= " > $outfile";

    my $null = ($^O =~ m/mswin/i) ? 'NUL' : '/dev/null';
    $param_string .= " 2> $null" if $self->quiet || $self->verbose < 0;
    
    return $param_string;
}

=head2  _setinput()

 Title   : _setinput
 Usage   : Internal function, not to be called directly
 Function: writes input sequence to file and return the file name
 Returns : string (file name)
 Args    : as per run()

=cut

sub _setinput {
    my ($self, @inputs) = @_;
    $self->throw("At least two sequence or map objects must be supplied") unless @inputs >= 2;
    ref($inputs[0]) || $self->throw("Inputs must be object references");
    
    my ($fh, $outfile) = $self->io->tempfile(-dir => $self->tempdir);
    my $out = Bio::SeqIO->new(-fh => $fh, '-format' => 'fasta');
    
    my %done;
    foreach my $input (@inputs) {
        if ($input->isa('Bio::Map::MappableI')) {
            # we want to work on all its maps, since mappables themselves don't
            # have sequences
            push(@inputs, $input->known_maps);
            next;
        }
        
        $input->can('seq') || $self->throw("Supplied an input [$input] with no seq() method!");
        
        if ($input->isa('Bio::Map::EntityI')) {
            $self->{map_mode} = 1;
            
            if ($input->isa('Bio::Map::MapI')) {
                # change the id of the seq so we'll know what input object it
                # came from later
                my $id = $input->unique_id;
                next if $done{$id};
                $input->id($id);
                $done{$id} = 1;
                #*** should this be automatic in GeneMap? Anyway, we don't want
                #    to alter users genemap id here permanently...
            }
            else {
                my $id = $input->id;
                unless ($id) {
                    $input->id($input->map->unique_id.'['.$input->toString.']');
                }
            }
        }
        
        $out->write_seq($input);
    }
    close($fh);
    
    return $outfile;
}

=head1 Bio::Tools::Run::Wrapper methods

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
 Usage   : my $outfile = $codeml->outfile_name();
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
 Usage   : $codeml->cleanup();
 Function: Will cleanup the tempdir directory
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

1;
