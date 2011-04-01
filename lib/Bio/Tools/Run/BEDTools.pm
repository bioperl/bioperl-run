# $Id: BEDTools.pm kortsch $
#
# BioPerl module for Bio::Tools::Run::BEDTools
#
# Please direct questions and support issues to <bioperl-l@bioperl.org>
#
# Cared for by Dan Kortschak <dan.kortschak@adelaide.edu.au>
#
# Copyright Dan Kortschak
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::BEDTools - Run wrapper for the BEDTools suite of programs *BETA*

=head1 SYNOPSIS

 # use a BEDTools program
 $bedtools_fac = Bio::Tools::Run::BEDTools->new( -command => 'subtract' );
 $result_file = $bedtools_fac->run( -bed1 => 'genes.bed', -bed2 => 'mask.bed' );
 
 # if IO::Uncompress::Gunzip is available...
 $result_file = $bedtools_fac->run( -bed1 => 'genes.bed.gz', -bed2 => 'mask.bed.gz' );
 
 # be more strict
 $bedtools_fac->set_parameters( -strandedness => 1 );
 
 # and even more...
 $bedtools_fac->set_parameters( -minimum_overlap => 1e-6 );
 
 # create a Bio::SeqFeature::Collection object
 $features = $bedtools_fac->result( -want => 'Bio::SeqFeature::Collection' );
 
=head1 DEPRECATION WARNING

Most executables from BEDTools v>=2.10.1 can read GFF and VCF formats
in addition to BED format. This requires the use of a new input file param,
shown in the following documentation, '-bgv', in place of '-bed' for the
executables that can do this.

This behaviour breaks existing scripts.

=head1 DESCRIPTION

This module provides a wrapper interface for Aaron R. Quinlan and Ira M. Hall's
utilities C<BEDTools> that allow for (among other things):

=over

=item * Intersecting two BED files in search of overlapping features.

=item * Merging overlapping features.

=item * Screening for paired-end (PE) overlaps between PE sequences and existing genomic features.

=item * Calculating the depth and breadth of sequence coverage across defined "windows" in a genome. 

=back

(see L<http://code.google.com/p/bedtools/> for manuals and downloads).


=head1 OPTIONS

C<BEDTools> is a suite of 17 commandline executable. This module attempts to 
provide and options comprehensively. You can browse the choices like so:

 $bedtools_fac = Bio::Tools::Run::BEDTools->new;

 # all bowtie commands
 @all_commands = $bedtools_fac->available_parameters('commands');
 @all_commands = $bedtools_fac->available_commands; # alias

 # just for default command ('bam_to_bed')
 @btb_params = $bedtools_fac->available_parameters('params');
 @btb_switches = $bedtools_fac->available_parameters('switches');
 @btb_all_options = $bedtools_fac->available_parameters();

Reasonably mnemonic names have been assigned to the single-letter
command line options. These are the names returned by
C<available_parameters>, and can be used in the factory constructor
like typical BioPerl named parameters.

As a number of options are mutually exclusive, and the interpretation of
intent is based on last-pass option reaching bowtie with potentially unpredicted
results. This module will prevent inconsistent switches and parameters
from being passed.

See L<http://code.google.com/p/bedtools/> for details of BEDTools options.

=head1 FILES

When a command requires filenames, these are provided to the C<run> method, not
the constructor (C<new()>). To see the set of files required by a command, use
C<available_parameters('filespec')> or the alias C<filespec()>:

  $bedtools_fac = Bio::Tools::Run::BEDTools->new( -command => 'pair_to_bed' );
  @filespec = $bedtools_fac->filespec;

This example returns the following array:

 #bedpe
 #bam
 bed
 #out

This indicates that the bed (C<BEDTools> BED format) file MUST be
specified, and that the out, bedpe (C<BEDTools> BEDPE format) and bam 
(C<SAM> binary format) file MAY be specified (Note that in this case you
MUST provide ONE of bedpe OR bam, the module at this stage does not allow
this information to be queried). Use these in the C<run> call like so:

 $bedtools_fac->run( -bedpe => 'paired.bedpe',
                     -bgv => 'genes.bed',
                     -out => 'overlap' );

The object will store the programs STDERR output for you in the C<stderr()> 
attribute:

 handle_bed_warning($bedtools_fac) if ($bedtools_fac->stderr =~ /Usage:/);

For the commands 'fasta_from_bed' and 'mask_fasta_from_bed' STDOUT will also
be captured in the C<stdout()> attribute by default and all other commands
can be forced to capture program output in STDOUT by setting the -out
filespec parameter to '-'.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support

Please direct usage questions or support issues to the mailing list:

L<bioperl-l@bioperl.org>

Rather than to the module maintainer directly. Many experienced and
reponsive experts will be able look at the problem and quickly
address it. Please include a thorough description of the problem
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
the web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Dan Kortschak

 Email dan.kortschak adelaide.edu.au

=head1 CONTRIBUTORS

Additional contributors names and emails here

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

# Let the code begin...


package Bio::Tools::Run::BEDTools;
use strict;
our $HAVE_IO_UNCOMPRESS;

BEGIN {
    eval 'require IO::Uncompress::Gunzip; $HAVE_IO_UNCOMPRESS = 1';
}

use IPC::Run;

# Object preamble - inherits from Bio::Root::Root

use lib '../../..';
use Bio::Tools::Run::BEDTools::Config;
use Bio::Tools::Run::WrapperBase;
use Bio::Tools::Run::WrapperBase::CommandExts;
use Bio::Tools::GuessSeqFormat;
use Bio::SeqFeature::Generic;
use Bio::SeqFeature::Collection;
use Bio::SeqIO;
use File::Sort qw( sort_file );

use base qw( Bio::Tools::Run::WrapperBase );

## BEDTools
our $program_name = '*bedtools';
our $default_cmd = 'bam_to_bed';

# Note: Other globals imported from Bio::Tools::Run::BEDTools::Config
our $qual_param = undef;
our $use_dash = 'single';
our $join = ' ';

our %strand_translate = (
	'+' => 1,
	'-' => -1,
	'.' => 0
	);

=head2 new()

 Title   : new
 Usage   : my $obj = new Bio::Tools::Run::BEDTools();
 Function: Builds a new Bio::Tools::Run::BEDTools object
 Returns : an instance of Bio::Tools::Run::BEDTools
 Args    :

=cut

sub new {
	my ($class,@args) = @_;
	unless (grep /command/, @args) {
		push @args, '-command', $default_cmd;
	}
	my $self = $class->SUPER::new(@args);
	foreach (keys %command_executables) {
		$self->executables($_, $self->_find_executable($command_executables{$_}));
	}
	$self->want($self->_rearrange([qw(WANT)],@args));
	$self->parameters_changed(1); # set on instantiation, per Bio::ParameterBaseI
	return $self;
}

=head2 run()

 Title   : run
 Usage   : $result = $bedtools_fac->run(%params);
 Function: Run a BEDTools command.
 Returns : Command results (file, IO object or Bio object)
 Args    : Dependent on filespec for command. 
           See $bedtools_fac->filespec and BEDTools Manual.
           Also accepts -want => '(raw|format|<object_class>)' - see want().
 Note    : gzipped inputs are allowed if IO::Uncompress::Gunzip
           is available

=cut

sub run {
	my $self = shift;

	my ($ann, $bed, $bg, $bgv, $bgv1, $bgv2, $bam, $bedpe, $bedpe1, $bedpe2, $seq, $genome, $out);
	
	if (!(@_ % 2)) {
		my %args = @_;
		if ((grep /^-\w+/, keys %args) == keys %args) {
			($ann, $bed, $bg, $bgv, $bgv1, $bgv2, $bam, $bedpe, $bedpe1, $bedpe2, $seq, $genome, $out) =
				$self->_rearrange([qw( ANN BED BG BGV BGV1 BGV2 BAM 
				                       BEDPE BEDPE1 BEDPE2
				                       SEQ GENOME OUT )], @_);
		} else {
			$self->throw("Badly formed named args: ".join(' ',@_));
		}
	} else {
		if (grep /^-\w+/, @_) {
			$self->throw("Badly formed named args: ".join(' ',@_));
		} else {
			$self->throw("Require named args.");
		}
	}

	# Sanity checks
	$self->executable || $self->throw("No executable!");
	my $cmd = $self->command if $self->can('command');

	for ($cmd) {

=pod

           Command              	<in>			<out>

           annotate             bgv		ann(s)		#out

=cut
		m/^annotate$/ && do {
			$bgv = $self->_uncompress($bgv);
			$self->_validate_file_input(-bgv => $bgv) || $self->throw("File '$bgv' not BED/GFF/VCF format.");
			@$ann = map {
				my $a = $_;
	            $a = $self->_uncompress($a);
				$self->_validate_file_input(-ann => $a) || $self->throw("File '$a' not BED/GFF/VCF format.");
				$a;
			} @$ann;
			last;
		};
		
=pod

           graph_union	        bg_files			#out

=cut
		m/^graph_union$/ && do {
			@$bg = map {
				my $g = $_;
	            $g = $self->_uncompress($g);
				$self->_validate_file_input(-bg => $g) || $self->throw("File '$a' not BedGraph format.");
				$g;
			} @$bg;
			last;
		};
		
=pod

           fasta_from_bed       seq		bgv		#out

           mask_fasta_from_bed  seq		bgv		#out

=cut
		m/fasta_from_bed$/ && do {
			($out // 0) eq '-' &&
				$self->throw("Cannot capture results in STDOUT with sequence commands.");
			$seq = $self->_uncompress($seq);
			$self->_validate_file_input(-seq => $seq) || $self->throw("File '$seq' not fasta format.");
			$bgv = $self->_uncompress($bgv);
			$self->_validate_file_input(-bgv => $bgv) || $self->throw("File '$bgv' not BED/GFF/VCF format.");
			last;
		};
		
=pod

           bam_to_bed           bam 				#out

=cut

		m/^bam_to_bed$/ && do {
			$bam = $self->_uncompress($bam);
			$self->_validate_file_input(-bam => $bam) || $self->throw("File '$bam' not BAM format.");
			last;
		};


=pod

           bed_to_IGV           bgv 				#out

           merge                bgv 				#out

           sort                 bgv 				#out

           links                bgv 				#out

=cut

		m/^(?:bed_to_IGV|merge|sort|links)$/ && do {
			$bgv = $self->_uncompress($bgv);
			$self->_validate_file_input(-bgv => $bgv) || $self->throw("File '$bgv' not BED/GFF/VCF format.");
		};

=pod

           b12_to_b6            bed 				#out

           overlap              bed 				#out

           group_by             bed 				#out

=cut

		m/^(?:b12_to_b6|overlap|group_by)$/ && do {
			$bed = $self->_uncompress($bed);
			$self->_validate_file_input(-bed => $bed) || $self->throw("File '$bgv' not BED format.");
			if ($cmd eq 'group_by') {
				my $c =(my @c)= split(",",$self->columns);
				my $o =(my @o)= split(",",$self->operations);
				unless ($c > 0 && $o == $c) {
					$self->throw("The command 'group_by' requires "."paired "x($o == $c)."'-columns' and '-operations' parameters");
				}
			}
			last;
		};

=pod

           bed_to_bam           bgv 				#out

           shuffle              bgv 		genome		#out

           slop                 bgv 		genome		#out

           complement           bgv 		genome		#out

=cut

		m/^(?:bed_to_bam|shuffle|slop|complement)$/ && do {
			$bgv = $self->_uncompress($bgv);
			$self->_validate_file_input(-bgv => $bgv) || $self->throw("File '$bgv' not BED/GFF/VCF format.");
			$genome = $self->_uncompress($genome);
			$self->_validate_file_input(-genome => $genome) || $self->throw("File '$genome' not genome format.");
			if ($cmd eq 'slop') {
				my $l = defined $self->add_to_left;
				my $r = defined $self->add_to_right;
				my $b = defined $self->add_bidirectional;
				# I think I have a lisp
				unless (($l && $r) || ($b xor ($l || $r))) {
					$self->throw("The command 'slop' requires an unambiguous description of the slop you want");
				}
			}
			last;
		};

=pod

           genome_coverage      bed 		genome		#out

=cut

		m/^genome_coverage$/ && do {
			$bed = $self->_uncompress($bed);
			$self->_validate_file_input(-bed => $bed) || $self->throw("File '$bed' not BED format.");
			$genome = $self->_uncompress($genome);
			$self->_validate_file_input(-genome => $genome) || $self->throw("File '$genome' not genome format.");
			my ($th, $tf) = $self->io->tempfile( -dir => $self->tempdir(), -suffix => '.bed' );
			$th->close;
			sort_file({k => 1, I => $bed, o => $tf});
			$bed = $tf;
			last;
		};

=pod

           window               bgv1		bgv2		#out

           closest              bgv1		bgv2		#out

           coverage             bgv1		bgv2		#out

           subtract             bgv1		bgv2		#out

=cut

		m/^(?:window|closest|coverage|subtract)$/ && do {
			$bgv1 = $self->_uncompress($bgv1);
			$self->_validate_file_input(-bgv1 => $bgv1) || $self->throw("File '$bgv1' not BED/GFF/VCF format.");
			$bgv2 = $self->_uncompress($bgv2);
			$self->_validate_file_input(-bgv2 => $bgv2) || $self->throw("File '$bgv2' not BED/GFF/VCF format.");
		};

=pod

           pair_to_pair         bedpe1		bedpe2		#out

=cut
		m/^pair_to_pair$/ && do {
			$bedpe1 = $self->_uncompress($bedpe1);
			$self->_validate_file_input(-bedpe1 => $bedpe1) || $self->throw("File '$bedpe1' not BEDPE format.");
			$bedpe2 = $self->_uncompress($bedpe2);
			$self->_validate_file_input(-bedpe2 => $bedpe2) || $self->throw("File '$bedpe2' not BEDPE format.");
			last;
		};

=pod

           intersect            bgv1|bam	bgv2		#out

=cut
		m/^intersect$/ && do {
			$bgv1 = $self->_uncompress($bgv1);
			$bam = $self->_uncompress($bam);
			($bam && $self->_validate_file_input(-bam => $bam)) || ($bgv1 && $self->_validate_file_input(-bgv1 => $bgv1)) ||
				$self->throw("File in position 1. not correct format.");
			$bgv2 = $self->_uncompress($bgv2);
			$self->_validate_file_input(-bgv2 => $bgv2) || $self->throw("File '$bgv2' not BED/GFF/VCF format.");			
			last;
		};

=pod

           pair_to_bed          bedpe|bam	bgv		#out

           bgv* signifies any of BED, GFF or VCF. ann is a bgv.
           
           NOTE: Replace 'bgv' with 'bed' unless $use_bgv is set.


=cut

		m/^pair_to_bed$/ && do {
			$bedpe = $self->_uncompress($bedpe);
			$bam = $self->_uncompress($bam);
			($bam && $self->_validate_file_input(-bam => $bam)) || ($bedpe && $self->_validate_file_input(-bedpe => $bedpe)) ||
				$self->throw("File in position 1. not correct format.");
			$bgv = $self->_uncompress($bgv);
			$self->_validate_file_input(-bgv => $bgv) || $self->throw("File '$bed' not BED/GFF/VCF format.");
			last;
		}
	}
	
	my %params = (    
		'-ann'        => $ann,
		'-bam'        => $bam,
		'-bed'        => $bed,
		'-bgv'        => $bgv,
		'-bg'         => $bg,
		'-bgv1'       => $bgv1,
		'-bgv2'       => $bgv2,
		'-bedpe'      => $bedpe,
		'-bedpe1'     => $bedpe1,
		'-bedpe2'     => $bedpe2,
		'-seq'        => $seq,
		'-genome'     => $genome
	);
	map {
		delete $params{$_} unless defined $params{$_}
	} keys %params;

	my $format = $self->_determine_format(\%params);
	my $suffix = '.'.$format;
	
	if (!defined $out) {
		my ($outh, $outf) = $self->io->tempfile( -dir => $self->tempdir(), -suffix => $suffix );
		$outh->close;
		$out = $outf;
	} elsif ($out ne '-') {
		$out .= $suffix;
	} else {
		undef $out;
	}
	$params{'-out'} = $out if defined $out;

	$self->_run(%params);

	$self->{'_result'}->{'file_name'} = $out // '-';
	$self->{'_result'}->{'format'} = $format;
	$self->{'_result'}->{'file'} = defined $out ? Bio::Root::IO->new( -file => $out ) : undef;
	
	return $self->result;
}

sub _uncompress {
        my ($self, $file) = @_;

	return if !defined $file;

        return $file unless ($file =~ m/\.gz[^.]*$/);

	return $file unless (-e $file && -r _); # other people will deal with this

        unless ($HAVE_IO_UNCOMPRESS) {
                croak( "IO::Uncompress::Gunzip not available, can't expand '$file'" );
        }
        my ($tfh, $tf) = $self->io->tempfile( -dir => $self->tempdir() );
        my $z = IO::Uncompress::Gunzip->new($file);
        while (my $block = $z->getline) { print $tfh $block }
        close $tfh;

        return $tf
}

=head2 want()

 Title   : want
 Usage   : $bowtiefac->want( $class )
 Function: make factory return $class, or 'raw' results in file
           or 'format' for result format
           All commands can return Bio::Root::IO
           commands returning:       can return object:
           - BED or BEDPE            - Bio::SeqFeature::Collection
           - sequence                - Bio::SeqIO
 Returns : return wanted type
 Args    : [optional] string indicating class or raw of wanted result

=cut

sub want {
	my $self = shift;
	return $self->{'_want'} = shift if @_;
	return $self->{'_want'};
}

=head2 result()

 Title   : result
 Usage   : $bedtoolsfac->result( [-want => $type|$format] )
 Function: return result in wanted format
 Returns : results
 Args    : [optional] hashref of wanted type
 Note    : -want arg does not persist between result() call when
           specified in result(), for persistence, use want()

=cut

sub result {
	my ($self, @args) = @_;
	
	my $want = $self->_rearrange([qw(WANT)],@args);
	$want ||= $self->want;
	my $cmd = $self->command if $self->can('command');
	my $format = $self->{'_result'}->{'format'};
	my $file_name = $self->{'_result'}->{'file_name'};

	return $self->{'_result'}->{'format'} if (defined $want && $want eq 'format');
	return $self->{'_result'}->{'file_name'} if (!$want || $want eq 'raw');
	return $self->{'_result'}->{'file'} if ($want =~ m/^Bio::Root::IO/); # this will be undef if -out eq '-'
	
	for ($format) { # these are dissected more finely than seems resonable to allow easy extension 
		m/bed/ && do {
			for ($want) {
				m/Bio::SeqFeature::Collection/ && do {
					unless (defined $self->{'_result'}->{'object'} &&
						ref($self->{'_result'}->{'object'}) =~ m/^Bio::SeqFeature::Collection/) {
							$self->{'_result'}->{'object'} = $self->_read_bed;
					}
					return $self->{'_result'}->{'object'};
				};
				$self->warn("Cannot make '$_' for $format.");
				return;
			}
			last;
		};
		m/bedpe/ && do {
			for ($want) {
				m/Bio::SeqFeature::Collection/ && do {
					unless (defined $self->{'_result'}->{'object'} &&
						ref($self->{'_result'}->{'object'}) =~ m/^Bio::SeqFeature::Collection/) {
							$self->{'_result'}->{'object'} = $self->_read_bedpe;
					}
					return $self->{'_result'}->{'object'};
				};
				$self->warn("Cannot make '$_' for $format.");
				return;
			}
			last;
		};
		m/bam/ && do {
			$self->warn("Cannot make '$_' for $format.");
			return;
		};
		m/^(?:fasta|raw)$/ && do {
			for ($want) {
				m/Bio::SeqIO/ && do {
					$file_name eq '-' && $self->throw("Cannot make a SeqIO object from STDOUT.");
					unless (defined $self->{'_result'}->{'object'} &&
						ref($self->{'_result'}->{'object'}) =~ m/^Bio::SeqIO/) {
							$self->{'_result'}->{'object'} =
								Bio::SeqIO->new(-file => $file_name,
								                -format => $format);
					}
					return $self->{'_result'}->{'object'};
				};
				$self->warn("Cannot make '$_' for $format.");
				return;
			}
			last;
		};
		m/tab/ && do {
			$self->warn("Cannot make '$_' for $format.");
			return;
		};
		m/igv/ && do {
			$self->warn("Cannot make '$_' for $format.");
			return;
		};
		m/html/ && do {
			$self->warn("Cannot make '$_' for $format.");
			return;
		};
		do {
			$self->warn("Result format '$_' not recognised - have you called run() yet?");
		}
	}
}

=head2 _determine_format()

 Title   : _determine_format( $has_run )
 Usage   : $bedtools-fac->_determine_format
 Function: determine the format of output for current options
 Returns : format of bowtie output
 Args    : [optional] boolean to indicate result exists

=cut

sub _determine_format {
        my ($self, $params) = @_;

	my $cmd = $self->command if $self->can('command');
	my $format = $format_lookup{$cmd};
	
	#special cases - dependent on switches and files
	for ($cmd) {
		m/^intersect$/ && do {
			return 'bed' if !defined $$params{'-bam'} || $self->write_bed;
			return 'bam';
		};
		m/^pair_to_bed$/ && do {
			return 'bedpe' if !defined $$params{'-bam'} || $self->write_bedpe;
			return 'bam';
		};
		m/^fasta_from_bed$/ && do {
			return $self->output_tab_format ? 'tab' : 'fasta';
		}
	}

	return $format;
}

=head2 _read_bed()

 Title   : _read_bed()
 Usage   : $bedtools_fac->_read_bed
 Function: return a Bio::SeqFeature::Collection object from a BED file 
 Returns : Bio::SeqFeature::Collection
 Args    : 

=cut

sub _read_bed {
	my ($self) = shift;
	
	my @features;
	
	if ($self->{'_result'}->{'file_name'} ne '-') {
		my $in = $self->{'_result'}->{'file'};
		while (my $feature = $in->_readline) {
			chomp $feature;
			push @features, _read_bed_line($feature);
		}
	} else {
		for my $feature (split("\cJ", $self->stdout)) {
			push @features, _read_bed_line($feature);
		}
	}
	
	my $collection = Bio::SeqFeature::Collection->new;
	$collection->add_features(\@features);
	
	return $collection;
}

sub _read_bed_line {
	my $feature = shift;

	my ($chr, $start, $end, $name, $score, $strand,
	    $thick_start, $thick_end, $item_RGB, $block_count, $block_size, $block_start) =
		split("\cI",$feature);
	$strand ||= '.'; # BED3 doesn't have strand data - for 'merge' and 'complement'
	
	return Bio::SeqFeature::Generic->new( -seq_id  => $chr,
	                                      -primary => $name,
	                                      -start   => $start,
	                                      -end     => $end,
	                                      -strand  => $strand_translate{$strand},
	                                      -score   => $score,
	                                      -tag     => { thick_start => $thick_start,
	                                                    thick_end   => $thick_end,
	                                                    item_RGB    => $item_RGB,
	                                                    block_count => $block_count,
	                                                    block_size  => $block_size,
	                                                    block_start => $block_size }
	                                    );
}

=head2 _read_bedpe()

 Title   : _read_bedpe()
 Usage   : $bedtools_fac->_read_bedpe
 Function: return a Bio::SeqFeature::Collection object from a BEDPE file 
 Returns : Bio::SeqFeature::Collection
 Args    : 

=cut

sub _read_bedpe {
	my ($self) = shift;
	
	my @features;
	
	if ($self->{'_result'}->{'file_name'} ne '-') {
		my $in = $self->{'_result'}->{'file'};
		while (my $feature = $in->_readline) {
			chomp $feature;
			push @features, _read_bedpe_line($feature);
		}
	} else {
		for my $feature (split("\cJ", $self->stdout)) {
			push @features, _read_bedpe_line($feature);
		}
	}
	
	my $collection = Bio::SeqFeature::Collection->new;
	$collection->add_features(\@features);
	
	return $collection;
}

sub _read_bedpe_line {
	my $feature = shift;
	
	my ($chr1, $start1, $end1, $chr2, $start2, $end2, $name, $score, $strand1, $strand2, @add) =
		split("\cI",$feature);
	$strand1 ||= '.';
	$strand2 ||= '.';
	
	return Bio::SeqFeature::FeaturePair->new( -primary       => $name,
	                                          -seq_id        => $chr1,
	                                          -start         => $start1,
	                                          -end           => $end1,
	                                          -strand        => $strand_translate{$strand1},

	                                          -hprimary_tag  => $name,
	                                          -hseqname      => $chr2,
	                                          -hstart        => $start2,
	                                          -hend          => $end2,
	                                          -hstrand       => $strand_translate{$strand2},
	
	                                          -score         => $score
	                                        );
}

=head2 _validate_file_input()

 Title   : _validate_file_input
 Usage   : $bedtools_fac->_validate_file_input( -type => $file )
 Function: validate file type for file spec
 Returns : file type if valid type for file spec
 Args    : hash of filespec => file_name

=cut

sub _validate_file_input {
	my ($self, @args) = @_;
	my (%args);
	if (grep (/^-/, @args) && (@args > 1)) { # named parms
		$self->throw("Wrong number of args - requires one named arg") if (@args > 2);
		s/^-// for @args;
		%args = @args;
	} else {
		$self->throw("Must provide named filespec");
	}
	
	for (keys %args) {
		m/bam/ && do {
			return 'bam';
		};
		do {
			return unless ( -e $args{$_} && -r _ );
			my $guesser = Bio::Tools::GuessSeqFormat->new(-file=>$args{$_});
			return $guesser->guess if grep {$guesser->guess =~ m/$_/} @{$accepted_types{$_}};
		}
	}
	return;
}

=head2 version()

 Title   : version
 Usage   : $version = $bedtools_fac->version()
 Function: Returns the program version (if available)
 Returns : string representing location and version of the program

=cut

sub version{
	my ($self) = @_;

	my $cmd = $self->command if $self->can('command');

	defined $cmd or $self->throw("No command defined - cannot determine program executable");

	# new bahaviour for some BEDTools executables - breaks previous approach to getting version
	# $dummy can be any non-recognised parameter - '-version' works for most
	my $dummy = '-version';
	$dummy = '-examples' if $cmd =~ /graph_union/;

	my ($in, $out, $err);
	my $dum;
	$in = \$dum;
	$out = \$self->{'stdout'};
	$err = \$self->{'stderr'};

	# Get program executable
	my $exe = $self->executable;

	my @ipc_args = ( $exe, $dummy );
	
	eval {
		IPC::Run::run(\@ipc_args, $in, $out, $err) or
			die ("There was a problem running $exe : $!");
	};
	# We don't bother trying to catch this: version is returned as an illegal file seek

	my @details = split("\n",$self->stderr);
	(my $version) = grep /^Program: .*$/, @details;
	$version =~ s/^Program: //;

	return $version;
}

sub available_commands { shift->available_parameters('commands') };

sub filespec { shift->available_parameters('filespec') };

1;
