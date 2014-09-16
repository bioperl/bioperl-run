# $Id$
#
# BioPerl module for Bio::Tools::Run::Maq::Config
#
# Please direct questions and support issues to <bioperl-l@bioperl.org>
#
# Cared for by Mark A. Jensen <maj@fortinbras.us>
#
# Copyright Mark A. Jensen
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Maq::Config - Configuration data for maq commands

=head1 SYNOPSIS

Used internally by L<Bio::Tools::Run::Maq>.

=head1 DESCRIPTION

This package exports information describing maq commands, parameters,
switches, and input and output filetypes for individual maq commands.

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

rather than to the module maintainer directly. Many experienced and
reponsive experts will be able look at the problem and quickly
address it. Please include a thorough description of the problem
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
the web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Mark A. Jensen

Email maj@fortinbras.us

Describe contact details here

=head1 CONTRIBUTORS

Additional contributors names and emails here

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

# Let the code begin...


package Bio::Tools::Run::Maq::Config;
use strict;
use warnings;
no warnings qw(qw);
use Bio::Root::Root;
use Exporter;
use base qw(Bio::Root::Root );

our (@ISA, @EXPORT, @EXPORT_OK);
push @ISA, 'Exporter';
@EXPORT = qw(
             @program_commands
             %command_prefixes
             %composite_commands
             @program_params
             @program_switches
             %param_translation
             %command_files
            );

@EXPORT_OK = qw();



our @program_commands = qw(
    run
    fasta2bfa
    fastq2bfq
    map
    mapmerge
    rmdup
    assemble
    indelpe
    indelsoa
    sol2sanger
    bfq2fastq
    mapass2maq
    mapview
    mapcheck
    pileup
    cns2fq
    cns2snp
    cns2view
    cns2ref
    cns2win
    fasta2csfa
    csmap2nt
    submap
    eland2maq
    export2maq
);

# composite commands: pseudo-commands that run a 
# sequence of commands
# composite command prefix => list of prefixes of commands this
#  composite command runs
#

our %composite_commands = (
    'run'        => [qw( map asm c2q )]
    );

# prefixes only for commands that take params/switches...
our %command_prefixes = (
    'fastq2bfq'  => 'q2q',
    'map'        => 'map',
    'assemble'   => 'asm',
    'mapview'    => 'mv',
    'mapcheck'   => 'mck',
    'pileup'     => 'pup',
    'cns2fq'     => 'c2q',
    'cns2win'    => 'c2w',
    'submap'     => 'sub',
    'eland2maq'  => 'l2m',
    'export2maq' => 'x2m',
    'run'        => 'run'
    );

our @program_params = qw(
    command
    q2q|n
    map|adaptor_file         
    map|first_read_length    
    map|max_hits             
    map|max_mismatches       
    map|max_outer_distance   
    map|max_outer_distance_rf
    map|mismatch_dump        
    map|mismatch_posn_dump   
    map|mismatch_thr         
    map|mutation_rate        
    map|second_read_length   
    map|unmapped_dump        
    asm|error_dep_coeff      
    asm|het_fraction         
    asm|max_mismatches       
    asm|max_quality_sum      
    asm|min_map_quality      
    asm|num_haplotypes       
    mck|max_mismatches       
    mck|min_map_quality      
    pup|max_mismatches       
    pup|max_quality_vals     
    pup|min_map_quality      
    pup|site_input_file      
    c2q|min_map_quality      
    c2q|min_read_depth       
    c2q|min_nbr_quality      
    c2q|max_read_depth       
    c2w|window_size          
    c2w|ref_seq              
    c2w|start_posn           
    c2w|end_posn             
    c2w|min_cons_quality     
    sub|max_mismatches       
    sub|max_quality_sum      
    sub|min_map_quality      
    l2q|def_qual             
    x2m|max_outer_distance   
    x2m|first_read_length    
    x2m|second_read_length   
    );

our @program_switches = qw(
    asm|single_end_quality 
    asm|discard_wrong_pairs
    mv|omit_seq_qual       
    mv|show_mismatch_posns 
    mck|single_end_quality 
    pup|single_end_quality 
    pup|discard_wrong_pairs
    pup|verbose            
    pup|show_base_posn     
    sub|discard_wrong_pairs
    x2m|retain_filt_reads  
);

our %param_translation = (
    'q2q|n'                        => 'n',
    'map|max_mismatches'           => 'n',
    'map|max_outer_distance'       => 'a',
    'map|max_outer_distance_rf'    => 'A',
    'map|first_read_length'        => '1',
    'map|second_read_length'       => '2',
    'map|mutation_rate'            => 'm',
    'map|adaptor_file'             => 'd',
    'map|unmapped_dump'            => 'u',
    'map|mismatch_thr'             => 'e',
    'map|mismatch_dump'            => 'H',
    'map|max_hits'                 => 'C',
    'map|mismatch_posn_dump'       => 'N',
    'asm|error_dep_coeff'          => 't',
    'asm|het_fraction'             => 'r',
    'asm|max_mismatches'           => 'm',
    'asm|max_quality_sum'          => 'Q',
    'asm|min_map_quality'          => 'q',
    'asm|num_haplotypes'           => 'N',
    'mck|max_mismatches'           => 'm',
    'mck|min_map_quality'          => 'q',
    'pup|max_mismatches'           => 'm',
    'pup|max_quality_vals'         => 'Q',
    'pup|min_map_quality'          => 'q',
    'pup|site_input_file'          => 'l',
    'c2q|min_map_quality'          => 'Q',
    'c2q|min_read_depth'           => 'd',
    'c2q|min_nbr_quality'          => 'n',
    'c2q|max_read_depth'           => 'D',
    'c2w|window_size'              => 'w',
    'c2w|ref_seq'                  => 'c',
    'c2w|start_posn'               => 'b',
    'c2w|end_posn'                 => 'e',
    'c2w|min_cons_quality'         => 'q',
    'sub|max_mismatches'           => 'm',
    'sub|max_quality_sum'          => 'Q',
    'sub|min_map_quality'          => 'q',
    'l2q|def_qual'                 => 'q',
    'x2m|max_outer_distance'       => 'a',
    'x2m|first_read_length'        => '1',
    'x2m|second_read_length'       => '2',
    'asm|single_end_quality'       => 's',
    'asm|discard_wrong_pairs'      => 'p',
    'mv|omit_seq_qual'             => 'b',
    'mv|show_mismatch_posns'       => 'N',
    'mck|single_end_quality'       => 's',
    'pup|single_end_quality'       => 's',
    'pup|discard_wrong_pairs'      => 'p',
    'pup|verbose'                  => 'v',
    'pup|show_base_posn'           => 'P',
    'sub|discard_wrong_pairs'      => 'p',
    'x2m|retain_filt_reads'        => 'n'
    );

#
# the order in the arrayrefs is the order required
# on the command line
#
# the strings in the arrayrefs (less special chars)
# become the keys for named parameters to run_maq
# 
# special chars:
#
# '#' implies optional
# '*' implies variable number of this type
# <|> implies stdin/stdout redirect
#

our %command_files = (
    'run'        => [qw( faq fas faq )],
    'fastq2bfq'  => [qw( faq bfq )],
    'fasta2bfa'  => [qw( fas bfa )],
    'map'        => [qw( map bfa bfq1 #bfq2 2>#log )],
    'mapmerge'   => [qw( out_map *in_map )],
    'rmdup'      => [qw( out_map in_map )],
    'assemble'   => [qw( cns bfa map 2>#log )],
    'indelpe'    => [qw( bfa map >txt )],
    'indelsoa'   => [qw( bfa map >txt )],
    'sol2sanger' => [qw( in_faq out_faq )],
    'bfq2fastq'  => [qw( bfq faq )],
    'mapass2maq' => [qw( in_map out_map )],
    'mapview'    => [qw( map >txt )],
    'mapcheck'   => [qw( bfa map >txt )],
    'pileup'     => [qw( bfa map >txt )],
    'cns2fq'     => [qw( cns >faq )],
    'cns2snp'    => [qw( cns >txt )],
    'cns2view'   => [qw( cns >txt )],
    'cns2ref'    => [qw( cns >fas )],
    'cns2win'    => [qw( cns >txt )],
    'fasta2csfa' => [qw( in_fas >out_fas )],
    'csmap2nt'   => [qw( out_map bfa in_map )],
    'submap'     => [qw( out_map in_map )],
    'eland2maq'  => [qw( map lis eld )],
    'export2maq' => [qw( map lis xpt )]
    );

INIT {
    # add subcommand params and switches for
    # composite commands
    my @sub_params;
    my @sub_switches;
    foreach my $cmd (keys %composite_commands) {
	foreach my $subcmd ( @{$composite_commands{$cmd}} ) {
	    my @sub_program_params = grep /^$subcmd\|/, @program_params;
	    my @sub_program_switches = grep /^$subcmd\|/, @program_switches;
	    for (@sub_program_params) {
		m/^$subcmd\|(.*)/;
		push @sub_params, "$cmd\|${subcmd}_".$1;
	    }
	    for (@sub_program_switches) {
		m/^$subcmd\|(.*)/;
		push @sub_switches, "$cmd\|${subcmd}_".$1;
	    }
	}
    }
    push @program_params, @sub_params;
    push @program_switches, @sub_switches;
    # translations for subcmd params/switches not necessary
}
1;
