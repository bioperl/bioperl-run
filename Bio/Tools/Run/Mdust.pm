# $Id$
#
# BioPerl module for Bio::Tools::SiRNA
#
# Cared for by Donald Jackson, donald.jackson@bms.com
#
# Copyright Donald Jackson
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Mdust - Perl extension for Mdust nucleotide filtering 

=head1 SYNOPSIS

  use Bio::Tools::Run::Mdust;
  my $mdust = Bio::Tools::Run::Mdust->new();

  $mdust->run($bio_seq_object);

=head1 DESCRIPTION

Perl wrapper for the nucleic acid complexity filtering program B<mdust> as 
available from TIGR via L<http://www.tigr.org/tdb/tgi/software/>.  Takes a 
Bio::PrimarySeq object of type DNA as input. Returns a Bio::Seq 
object with the low-complexity regions changed to Ns, or a 
Bio::Seq::RichSeq object with the low-complexity regions identified as 
a Bio::SeqFeature::Generic with primary tag = 'Excluded'.

This module uses the environment variable MDUSTDIR to find the mdust 
program. Set MDUSTDIR to the directory containing the mdust binary.
For example, if mdust is installed as I</usr/local/bin/mdust>, set MDUSTDIR 
to I</usr/local/bin>.

=head1 SEE ALSO

L<mdust>, 
L<Bio::PrimarySeq>, 
L<Bio::Seq::RichSeq>, 
L<Bio::SeqFeature::Generic>

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
the web:

  http://bugzilla.bioperl.org/

=head1 AUTHOR

Donald Jackson (donald.jackson@bms.com)

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut


package Bio::Tools::Run::Mdust;

require 5.005_62;
use strict;

use Bio::SeqIO;
use Bio::SeqFeature::Generic;
use Bio::Root::Root;
use Bio::Root::IO;
use Bio::Tools::Run::WrapperBase;

use vars qw($AUTOLOAD $PROGRAMNAME @ARGNAMES $VERSION @ISA);

@ISA         = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);
@ARGNAMES    = qw(TARGET WSIZE CUTOFF MASKCHAR COORDS TMPDIR DEBUG);
$PROGRAMNAME = 'mdust';

=head2 new

  Title		: new
  Usage		: my $mdust = Bio::Tools::Run::Mdust->new( -target => $target_bioseq)
  Purpose 	: Create a new mdust object
  Returns 	: A Bio::Seq object
  Args		: target - Bio::Seq object for masking - alphabet MUST be DNA.
                  wsize - word size for masking (default = 3)
                  cutoff - cutoff score for masking (default = 28)
                  maskchar - character for replacing masked regions (default = N)
                  coords - boolean - indicate low-complexity regions as 
                           Bio::SeqFeature::Generic 
                           objects with primary tag 'Excluded', 
                           do not change sequence (default 0)
                  tmpdir - directory for storing temporary files
                  debug - boolean - toggle debugging output, 
                          do not remove temporary files
  Note		: All of the arguments can also be get/set with their own accessors, such as:
                  my $wsize = $mdust->wsize();

=cut

sub new {
    my ($proto, @args) = @_;
    my $pkg = ref($proto) || $proto;
    my %args;

    my $self = {};
    bless ($self, $pkg);

    @args{@ARGNAMES} = $self->_rearrange(\@ARGNAMES, @args); 

    # load target first since it requires special handling
    $self->target($args{'TARGET'}) if ($args{'TARGET'});

    # defaults are as per mdust executable
    $self->{'wsize'} = $args{'WSIZE'} || 3;
    $self->{'cutoff'} = $args{'CUTOFF'} || 28;
    $self->{'maskchar'} = $args{'MASKCHAR'} || 'N';
    $self->{'coords'} = $args{'COORDS'} || 0;
    $self->{'tmpdir'} = $args{'TMPDIR'} || $ENV{'TMPDIR'} || $ENV{'TMP'} || '.';
    # set debugging
    $self->verbose($args{'DEBUG'});
    return $self;
}

=head2 run

  Title		: run
  Usage		: $mdust->run();
  Purpose	: Run mdust on the target sequence
  Args		: target (optional) - Bio::Seq object of alphabet DNA for masking
  Returns	: Bio::Seq object (see 'new' for details)

=cut

sub run {
    my ($self, $target) = @_;

    if ($target) {
	$self->target($target);
    }

    return $self->_run_mdust;
}

sub program_dir {
        return Bio::Root::IO->catfile($ENV{MDUSTDIR}) if $ENV{MDUSTDIR};
}


sub program_name {
    return $PROGRAMNAME;
}

sub _run_mdust {
    # open a pipe to the mdust command.  Pass in sequence(s?) as fasta 
    # files on STDIN, recover filtered seqs on STDOUT
    my ($self) = @_;
    
    my $target = $self->target or warn "No target sequence specified\n" && return undef;

    # make sure program is available 
    my $executable = $self->executable('mdust', 1);

    # add options
    my $mdust_cmd = $executable;
    $mdust_cmd .= " -w " . $self->wsize;
    $mdust_cmd .= " -v " . $self->cutoff;
    $mdust_cmd .= " -m " . $self->maskchar;
    $mdust_cmd .= " -c" if ($self->coords);
    print STDERR "Running mdust: $mdust_cmd\n" if ($self->debug);
    my $maskedfile = $self->_maskedfile;
    eval {
	my $pid = open (MDUST, "| $mdust_cmd > $maskedfile"); # bind STDIN of mdust to filehandle

	local $| = 1;
	my $seqout = Bio::SeqIO->new(-fh => \*MDUST, -format => 'Fasta');
	$seqout->write_seq($target);
	close MDUST; # need to do this to get output to flush!
    };

    $self->throw($@) if ($@);

    if ($self->coords) { 
	$self->_parse_coords($maskedfile);
    }
    else { # replace original seq w/ masked seq
	      my $seqin = Bio::SeqIO->new(-file=>$maskedfile, -format => 'Fasta');
	      my $masked = $seqin->next_seq();
	# now swap masked seq for original
	$target->seq( $masked->seq );
    }
    unlink $maskedfile unless $self->save_tempfiles;

    return 1;

}

=head2 target

  Title		: target
  Usage		: $mdust->target($bio_seq)
  Purpose	: Set/get the target (sequence to be filtered).  
  Returns	: Target Bio::Seq object
  Args 		: Bio::Seq object using the DNA alphabet (optional)

=cut

sub target {
    my ($self, $targobj) = @_;

    if ($targobj) {
	return $self->_set_target($targobj);
    }
    else {
	return $self->{'target'};
    }

}

sub _set_target {
    my ($self, $targobj) = @_;
    unless ($targobj->isa('Bio::SeqI')) {
	$self->throw( -text => "Target must be passed as a Bio::Seq object",
		      -class => 'Bio::Root::BadParameter',
		      -value => $targobj );
    } 
    unless ($targobj->alphabet eq 'dna') {
	$self->throw( -text => "Target must be a DNA sequence",
		      -class => 'Bio::Root::BadParameter',
		      -value => $targobj );
    }

    $self->{'target'} = $targobj;
    return 1;

}

sub _maskedfile {
    my ($self, $file) = @_;
    my $tmpdir = $self->tempdir;

    if ($file) {
	$self->{'maskedfile'} = $file;
	# add some sanity chex for writability?
    }
    elsif (!$self->{'maskedfile'}) {
	($self->{'maskedfh'},$self->{'maskedfile'}) = 
	    $self->io->tempfile(-dir=>$self->tempdir());
    }
    return $self->{'maskedfile'};

}

sub _parse_coords {
    my ($self, $file) = @_;
    my $target = $self->target;
    open(FILE, $file) or die "Unable to open $file: $!";
    while (<FILE>) {
	chomp;
	s/\r//;
	my ($seq, $length, $mstart, $mstop) = split(/\t/);

	# add masked region as a SeqFeature in target
	my $masked = Bio::SeqFeature::Generic->new( -start 		=> $mstart,
						    -end 		=> $mstop,
						    );
	$masked->primary_tag('Excluded');
	$masked->source_tag('mdust');

	$target->add_SeqFeature($masked);
    }
    return 1;
}


sub DESTROY {
    my ($self) = @_;
    undef $self;
    return 1;
}

sub AUTOLOAD {
    my ($self, $value) = @_;
    my $name = $AUTOLOAD;
    $name =~ s/.+:://;

    return if ($name eq 'DESTROY');


    if (defined $value) {
	$self->{$name} = $value;
    }

    unless (exists $self->{$name}) {
	warn "Attribute $name not defined for ", ref($self), "\n" if ($self->debug);
  	return undef;
    }

    return $self->{$name};
}

1;
