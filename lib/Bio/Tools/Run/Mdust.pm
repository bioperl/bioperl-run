# $Id$
#
# BioPerl module for Bio::Tools::Mdust
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
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

Perl wrapper for the nucleic acid complexity filtering program
B<mdust> as available from TIGR via
L<http://www.tigr.org/tdb/tgi/software/>.  Takes a Bio::SeqI or
Bio::PrimarySeqI object of type DNA as input.

If a Bio::Seq::RichSeqI is passed then the low-complexity regions will
be added to the feature table of the target object as
Bio::SeqFeature::Generic items with primary tag = 'Excluded' .
Otherwise a new target object will be returned with low-complexity
regions masked (by N's or other character as specified by maskchar()).

The mdust executable must be in a directory specified with either the
PATH or MDUSTDIR environment variable.

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

use vars qw($AUTOLOAD $PROGRAMNAME @ARGNAMES @MASKCHARS $VERSION @ISA);

@ISA         = qw(Bio::Root::Root Bio::Tools::Run::WrapperBase);
@ARGNAMES    = qw(TARGET WSIZE CUTOFF MASKCHAR COORDS TMPDIR DEBUG);
$PROGRAMNAME = 'mdust';

@MASKCHARS   = qw(N X L);

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
  Notes		: All of the arguments can also be get/set with their own accessors, such as:
                  my $wsize = $mdust->wsize();

                  When processing multiple sequences, call Bio::Tools::Run::Mdust->new() once 
                  then pass each sequence as an argument to the target() or run() methods.
=cut

sub new {
    my ($proto, @args) = @_;
    my $pkg = ref($proto) || $proto;
    my %args;

    my $self = { wsize		=> undef,
		 cutoff		=> undef,
		 maskchar	=> undef,
		 coords		=> 0,
	     };

    bless ($self, $pkg);

    @args{@ARGNAMES} = $self->_rearrange(\@ARGNAMES, @args); 

    # load target first since it requires special handling
    $self->target($args{'TARGET'}) if ($args{'TARGET'});

    # package settings
    $self->{'coords'} = $args{'COORDS'} if (defined $args{'COORDS'});
    $self->{'tmpdir'} = $args{'TMPDIR'} || $ENV{'TMPDIR'} || $ENV{'TMP'} || '.';

    # mdust options
    $self->{'wsize'} = $args{'WSIZE'} if (defined $args{'WSIZE'});
    $self->{'cutoff'} = $args{'CUTOFF'} if (defined $args{'CUTOFF'});
    $self->{'maskchar'} = $args{'MASKCHAR'} if (defined $args{'CUTOFF'});


    # set debugging
    $self->verbose($args{'DEBUG'});
    return $self;
}

=head2 run

  Title		: run
  Usage		: $mdust->run();
  Purpose	: Run mdust on the target sequence
  Args		: target (optional) - Bio::Seq object of alphabet DNA for masking
  Returns	: Bio::Seq object with masked sequence or low-complexity regions added to feature table.

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

    # make sure program is available  - doesn't seem to check
    #my $executable = $self->executable('mdust', 1); 

    # add options
    my $mdust_cmd = $self->program_path;
    $mdust_cmd .= " -w " . $self->wsize if (defined $self->wsize);
    $mdust_cmd .= " -v " . $self->cutoff if (defined $self->cutoff);
    $mdust_cmd .= " -m " . $self->maskchar if (defined $self->maskchar);
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

    my $rval;

    if ($self->coords) { 
	$self->_parse_coords($maskedfile);
	$rval = $self->target;
    }
    else { # replace original seq w/ masked seq
	      my $seqin = Bio::SeqIO->new(-file=>$maskedfile, -format => 'Fasta');
	      $rval =  $seqin->next_seq
    }

    unlink $maskedfile unless $self->save_tempfiles;

    return $rval;

}

=head2 target

  Title		: target
  Usage		: $mdust->target($bio_seq)
  Purpose	: Set/get the target (sequence to be filtered).  
  Returns	: Target Bio::Seq object
  Args 		: Bio::SeqI or Bio::PrimarySeqI object using the DNA alphabet (optional)
  Note		: If coordinate parsing is selected ($mdust->coords = 1) then target
                  MUST be a Bio::Seq::RichSeqI object.  Passing a RichSeqI object automatically
                  turns on coordinate parsing.

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

    unless ($targobj->isa('Bio::SeqI') or ($targobj->isa('Bio::PrimarySeqI'))) {
	$self->throw( -text => "Target must be passed as a Bio::SeqI or Bio::PrimarySeqI object",
		      -class => 'Bio::Root::BadParameter',
		      -value => $targobj );
    } 


    if ($self->coords) {
	unless ($targobj->isa('Bio::Seq::RichSeqI')) {
	    $self->throw( -text => "Target must be passed as a Bio::Seq::RichSeqSeqI object when coords == 1",
			  -class => 'Bio::Root::BadParameter',
			  -value => $targobj );
	} 
    }	
    elsif ($targobj->isa('Bio::Seq::RichSeqI')) {
	$self->coords(1);
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

=head2 maskchar

  Title		: maskchar
  Usage		: $mdust->maskchar('N')
  Purpose      	: Set/get the character for masking low-complexity regions
  Returns	: True on success
  Args		: Either N (default), X or L (lower case)

=cut

sub maskchar {
    my ($self, $maskchar) = @_;

    return $self->{'maskchar'} unless (defined $maskchar);

    unless ( grep {$maskchar eq $_} @MASKCHARS ) {
	$self->throw( -text => "maskchar must be one of N, X or L",
		      -class => 'Bio::Root::BadParameter',
		      -value => $maskchar );
    }
    $self->{'maskchar'} = $maskchar;

    1;
}

sub DESTROY {
    my $self= shift;
    unless ( $self->save_tempfiles ) {
        $self->cleanup();
    }
    $self->SUPER::DESTROY();
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
