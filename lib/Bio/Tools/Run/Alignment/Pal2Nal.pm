# $Id: Pal2Nal.pm,v 1.3 2007/05/25 10:14:55 sendu Exp $
#
# BioPerl module for Bio::Tools::Run::Alignment::Pal2Nal
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

Bio::Tools::Run::Alignment::Pal2Nal - Wrapper for Pal2Nal

=head1 SYNOPSIS

  use Bio::Tools::Run::Alignment::Pal2Nal;

  # Make a Pal2Nal factory
  $factory = Bio::Tools::Run::Alignment::Pal2Nal->new();

  # Run Pal2Nal with a protein alignment file and a multi-fasta nucleotide
  # file
  my $aln = $factory->run($protein_alignfilename, $nucleotide_filename);

  # or with Bioperl objects
  $aln = $factory->run($protein_bio_simplalign, [$nucleotide_bio_seq1,
                                                 $nucleotide_bio_seq2]);

  # combinations of files/ objects are possible

  # $aln isa Bio::SimpleAlign of the nucleotide sequences aligned according to
  # the protein alignment

=head1 DESCRIPTION

This is a wrapper for running the Pal2Nal perl script by Mikita Suyama. You
can get details here: http://coot.embl.de/pal2nal/. Pal2Nal is used for aligning
a set of nucleotide sequences based on an alignment of their translations.

You can try supplying normal pal2nal command-line arguments to new(), eg.
new() or calling arg-named methods (excluding the initial hyphen, eg.
$factory->(1) to set the - arg).


You will need to enable this Pal2Nal wrapper to find the pal2nal.pl script.
This can be done in (at least) three ways:

 1. Make sure the script is in your path.
 2. Define an environmental variable PAL2NALDIR which is a 
    directory which contains the script:
    In bash:

    export PAL2NALDIR=/home/username/pal2nal/

    In csh/tcsh:

    setenv PAL2NALDIR /home/username/pal2nal

 3. Include a definition of an environmental variable PAL2NALDIR in
    every script that will use this Pal2Nal wrapper module, e.g.:

    BEGIN { $ENV{PAL2NALDIR} = '/home/username/pal2nal/' }
    use Bio::Tools::Run::Alignment::Pal2Nal;

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

package Bio::Tools::Run::Alignment::Pal2Nal;
use strict;

use Bio::AlignIO;
use Bio::SeqIO;

use base qw(Bio::Tools::Run::Phylo::PhyloBase);

our $PROGRAM_NAME = 'pal2nal.pl';
our $PROGRAM_DIR = $ENV{'PAL2NALDIR'};

# methods for the pal2nal args we support
our @PARAMS   = qw(codontable);
our @SWITCHES = qw(blockonly nogap nomismatch);

# just to be explicit, args we don't support (yet) or we handle ourselves
our @UNSUPPORTED = qw(output html h nostderr);

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
 Usage   : $factory = Bio::Tools::Run::Alignment::Pal2Nal->new()
 Function: creates a new Pal2Nal factory.
 Returns : Bio::Tools::Run::Alignment::Pal2Nal
 Args    : Most options understood by pal2nal.pl can be supplied as key =>
           value pairs.

           These options can NOT be used with this wrapper:
           -output
           -html
           -h
           -nostderr

=cut

sub new {
    my ($class, @args) = @_;
    my $self = $class->SUPER::new(@args);
    
    $self->_set_from_args(\@args, -methods => [@PARAMS, @SWITCHES, 'quiet'],
                                  -create => 1);
    
    return $self;
}

=head2 run

 Title   : run
 Usage   : $result = $factory->run($protein_align_file, $multi_fasta_nucleotide);
           -or-
           $result = $factory->run($prot_align_object, [$bioseq_object1, ...]);
 Function: Runs pal2nal on a protein alignment and set of nucleotide sequences.
 Returns : Bio::SimpleAlign;
 Args    : The first argument represents a protein alignment, the second
           argument a set of nucleotide sequences.
           The alignment can be provided as an alignment file readable by
           Bio::AlignIO, or a Bio::Align::AlignI complient object (eg. a
           Bio::SimpleAlign).
           The nucleotide sequences can be provided as a single filename of a
           fasta file containing multiple nucleotide sequences, or an array ref
           of filenames, each file containing one sequence. Alternatively, an
           array ref of Bio::PrimarySeqI compliant objects can be supplied.
           
           In all cases, the protein alignment sequence names must correspond to
           the names of the supplied nucleotide sequences.

=cut

sub run {
    my ($self, $aln, $nucs) = @_;
    
    ($aln && $nucs) || $self->throw("alignment and nucleotides must be supplied");
    $aln = $self->_alignment($aln);
    
    # gaps must be -, not .
    my $fixed_aln = Bio::SimpleAlign->new();
    foreach my $seq ($aln->each_seq) {
        my $str = $seq->seq;
        $str =~ s/\./-/g;
        $fixed_aln->add_seq(Bio::LocatableSeq->new(-id => $seq->id, -seq => $str));
    }
    $self->_alignment($fixed_aln);
    
    my $nucs_file;
    if (-e $nucs) {
        $nucs_file = $nucs;
    }
    elsif (ref($nucs) eq 'ARRAY') {
        (my $tempfh, $nucs_file) = $self->io->tempfile('-dir' => $self->tempdir(), UNLINK => ($self->save_tempfiles ? 0 : 1));
        close($tempfh);
        my $sout = Bio::SeqIO->new(-file => ">".$nucs_file, -format => 'fasta');
        
        foreach my $nuc (@{$nucs}) {
            if (-e $nuc) {
                my $sin = Bio::SeqIO->new(-file => $nuc);
                while (my $nuc_seq = $sin->next_seq) {
                    $sout->write_seq($nuc_seq);
                }
            }
            elsif (ref($nuc) && $nuc->isa('Bio::PrimarySeqI')) {
                $sout->write_seq($nuc);
            }
            else {
                $self->throw("Don't understand nucleotide argument '$nuc'");
            }
        }
    }
    else {
        $self->throw("Don't understand nucleotide argument '$nucs'");
    }
    
    return $self->_run($nucs_file); 
}

sub _run {
    my ($self, $nucs_file) = @_;
    
    my $exe = $self->executable || return;
    
    my $aln_file = $self->_write_alignment;
    
    my ($rfh, $result_file) = $self->io->tempfile('-dir' => $self->tempdir(), UNLINK => ($self->save_tempfiles ? 0 : 1));
    my ($efh, $error_file) = $self->io->tempfile('-dir' => $self->tempdir(), UNLINK => ($self->save_tempfiles ? 0 : 1));
    close($rfh);
    undef $rfh;
    close($efh);
    undef $efh;
    my $command = $exe.$self->_setparams($aln_file, $nucs_file, $result_file, $error_file);
    $self->debug("pal2nal command = $command\n");
    
    system($command) && $self->throw("pal2nal call ($command) failed: $! | $?");
    open(my $errfh, '<', $error_file);
    my $errors;
    while (<$errfh>) {
        $errors .= $_;
    }
    close($errfh);
    $self->throw("pal2nal call ($command) had errors:\n$errors") if $errors;
    
    my $ain = Bio::AlignIO->new(-file => $result_file, -format => 'fasta');
    my $aln = $ain->next_aln;
    $ain->close;
    
    return $aln;
}

=head2 _setparams

 Title   : _setparams
 Usage   : Internal function, not to be called directly
 Function: Creates a string of params to be used in the command string
 Returns : string of params
 Args    : alignment and tree file names

=cut

sub _setparams {
    my ($self, $aln_file, $nucs_file, $result_file, $error_file) = @_;
    
    my $param_string = ' '.$aln_file;
    $param_string .= ' '.$nucs_file;
    $param_string .= $self->SUPER::_setparams(-params => \@PARAMS,
                                              -switches => \@SWITCHES,
                                              -dash => 1);
    $param_string .= ' -output fasta';
    
    $param_string .= " > $result_file 2> $error_file";
    
    return $param_string;
}

1;
