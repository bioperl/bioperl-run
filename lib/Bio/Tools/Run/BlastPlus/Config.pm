#$Id$
package Bio::Tools::Run::BlastPlus::Config;
use strict;
use warnings;
no warnings qw(qw);
use Bio::Root::Root;
use Exporter;
use base qw(Bio::Root::Root);

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
             $program_name
             $program_dir
             $use_dash
             $join
            );

@EXPORT_OK = qw();

# getting the parms and switches from the usage string:

#$ blastp -h | perl -ne '@a = m/\[(.*?)\]/g; for $a (@a) { @b = split(/\s+/,$a); $b[0]=~s/-//; $ptr = (@b==1 ? \@s : \@p ); push @$ptr, $b[0]; } END { print "p arms\n", join("\n",@p), "\n\n", "switches\n", join("\n",@s); }'

# '*' indicates a 'pseudo'-program : i.e. each
# command has its own executable...

our $program_name = '*blast+';
our $use_dash = 'single';
our $join = ' ';

our @program_commands = qw(
  run
  blastn
  blastx
  tblastx
  tblastn
  blastp
  psiblast
  rpsblast
  rpstblastn
  makeblastdb
  blastdb_aliastool
  blastdbcmd
  blastdbcheck
  convert2blastmask
  dustmasker
  segmasker
  windowmasker
);

# full command => prefix
our %command_prefixes = (
  run    => 'run',
  blastn => 'bln',
  blastx => 'blx',
  tblastx => 'tbx',
  tblastn => 'tbn',
  blastp => 'blp',
  psiblast => 'psi',
  rpsblast => 'rps',
  rpstblastn => 'rpst',
  makeblastdb => 'mak',
  blastdb_aliastool => 'dba',
  blastdbcmd => 'dbc',
  blastdbcheck => 'dbk',
  convert2blastmask => 'c2m',
  dustmasker => 'dms',
  segmasker => 'sms',
  windowmasker => 'wms'
    );

# each elt : pfx|wrapper_parm_name

our @program_params = qw(
command
tbn|import_search_strategy
tbn|export_search_strategy
tbn|db
tbn|dbsize
tbn|gilist
tbn|negative_gilist
tbn|entrez_query
tbn|subject
tbn|subject_loc
tbn|query
tbn|out
tbn|evalue
tbn|word_size
tbn|gapopen
tbn|gapextend
tbn|xdrop_ungap
tbn|xdrop_gap
tbn|xdrop_gap_final
tbn|searchsp
tbn|db_gencode
tbn|frame_shift_penalty
tbn|max_intron_length
tbn|seg
tbn|soft_masking
tbn|matrix
tbn|threshold
tbn|culling_limit
tbn|best_hit_overhang
tbn|best_hit_score_edge
tbn|window_size
tbn|query_loc
tbn|outfmt
tbn|num_descriptions
tbn|num_alignments
tbn|max_target_seqs
tbn|num_threads
tbn|comp_based_stats
tbn|in_pssm
blx|import_search_strategy
blx|export_search_strategy
blx|db
blx|dbsize
blx|gilist
blx|negative_gilist
blx|entrez_query
blx|db_soft_mask
blx|subject
blx|subject_loc
blx|query
blx|out
blx|evalue
blx|word_size
blx|gapopen
blx|gapextend
blx|xdrop_ungap
blx|xdrop_gap
blx|xdrop_gap_final
blx|searchsp
blx|frame_shift_penalty
blx|max_intron_length
blx|seg
blx|soft_masking
blx|matrix
blx|threshold
blx|culling_limit
blx|best_hit_overhang
blx|best_hit_score_edge
blx|window_size
blx|query_loc
blx|strand
blx|query_gencode
blx|outfmt
blx|num_descriptions
blx|num_alignments
blx|max_target_seqs
blx|num_threads
bln|import_search_strategy
bln|export_search_strategy
bln|task
bln|db
bln|dbsize
bln|gilist
bln|negative_gilist
bln|entrez_query
bln|db_soft_mask
bln|subject
bln|subject_loc
bln|query
bln|out
bln|evalue
bln|word_size
bln|gapopen
bln|gapextend
bln|perc_identity
bln|xdrop_ungap
bln|xdrop_gap
bln|xdrop_gap_final
bln|searchsp
bln|penalty
bln|reward
bln|min_raw_gapped_score
bln|template_type
bln|template_length
bln|dust
bln|filtering_db
bln|window_masker_taxid
bln|window_masker_db
bln|soft_masking
bln|culling_limit
bln|best_hit_overhang
bln|best_hit_score_edge
bln|window_size
bln|use_index
bln|index_name
bln|query_loc
bln|strand
bln|outfmt
bln|num_descriptions
bln|num_alignments
bln|max_target_seqs
bln|num_threads
blp|import_search_strategy
blp|export_search_strategy
blp|task
blp|db
blp|dbsize
blp|gilist
blp|negative_gilist
blp|entrez_query
blp|db_soft_mask
blp|subject
blp|subject_loc
blp|query
blp|out
blp|evalue
blp|word_size
blp|gapopen
blp|gapextend
blp|xdrop_ungap
blp|xdrop_gap
blp|xdrop_gap_final
blp|searchsp
blp|seg
blp|soft_masking
blp|matrix
blp|threshold
blp|culling_limit
blp|best_hit_overhang
blp|best_hit_score_edge
blp|window_size
blp|query_loc
blp|outfmt
blp|num_descriptions
blp|num_alignments
blp|max_target_seqs
blp|num_threads
blp|comp_based_stats
psi|import_search_strategy
psi|export_search_strategy
psi|db
psi|dbsize
psi|gilist
psi|negative_gilist
psi|entrez_query
psi|subject
psi|subject_loc
psi|query
psi|out
psi|evalue
psi|word_size
psi|gapopen
psi|gapextend
psi|xdrop_ungap
psi|xdrop_gap
psi|xdrop_gap_final
psi|searchsp
psi|seg
psi|soft_masking
psi|matrix
psi|threshold
psi|culling_limit
psi|best_hit_overhang
psi|best_hit_score_edge
psi|window_size
psi|query_loc
psi|outfmt
psi|num_descriptions
psi|num_alignments
psi|max_target_seqs
psi|num_threads
psi|comp_based_stats
psi|gap_trigger
psi|num_iterations
psi|out_pssm
psi|out_ascii_pssm
psi|in_msa
psi|in_pssm
psi|pseudocount
psi|inclusion_ethresh
psi|phi_pattern
rpst|import_search_strategy
rpst|export_search_strategy
rpst|db
rpst|dbsize
rpst|gilist
rpst|negative_gilist
rpst|entrez_query
rpst|query
rpst|out
rpst|evalue
rpst|word_size
rpst|xdrop_ungap
rpst|xdrop_gap
rpst|xdrop_gap_final
rpst|searchsp
rpst|query_gencode
rpst|seg
rpst|soft_masking
rpst|window_size
rpst|query_loc
rpst|strand
rpst|outfmt
rpst|num_descriptions
rpst|num_alignments
rpst|max_target_seqs
rpst|num_threads
mak|in
mak|dbtype
mak|title
mak|mask_data
mak|out
mak|max_file_sz
mak|taxid
mak|taxid_map
mak|logfile
dba|gi_file_in
dba|gi_file_out
dba|db
dba|dbtype
dba|title
dba|gilist
dba|out
dba|dblist
dba|num_volumes
dba|logfile
tbx|import_search_strategy
tbx|export_search_strategy
tbx|db
tbx|dbsize
tbx|gilist
tbx|negative_gilist
tbx|entrez_query
tbx|subject
tbx|subject_loc
tbx|query
tbx|out
tbx|evalue
tbx|word_size
tbx|gapopen
tbx|gapextend
tbx|xdrop_ungap
tbx|xdrop_gap
tbx|xdrop_gap_final
tbx|searchsp
tbx|max_intron_length
tbx|seg
tbx|soft_masking
tbx|matrix
tbx|threshold
tbx|culling_limit
tbx|best_hit_overhang
tbx|best_hit_score_edge
tbx|window_size
tbx|query_loc
tbx|strand
tbx|query_gencode
tbx|db_gencode
tbx|outfmt
tbx|num_descriptions
tbx|num_alignments
tbx|max_target_seqs
tbx|num_threads
dbc|db
dbc|dbtype
dbc|entry
dbc|entry_batch
dbc|pig
dbc|range
dbc|strand
dbc|mask_sequence_with
dbc|out
dbc|outfmt
dbc|line_length
c2m|in
c2m|out
c2m|outfmt
dms|in
dms|out
dms|window
dms|level
dms|linker
dms|outfmt
sms|in
sms|out
sms|infmt
sms|outfmt
sms|window
sms|locut
sms|hicut
wms|ustat
wms|in
wms|out
wms|checkdup
wms|window
wms|t_extend
wms|t_thres
wms|t_high
wms|t_low
wms|set_t_high
wms|set_t_low
wms|infmt
wms|outfmt
wms|sformat
wms|convert
wms|fa_list
wms|mem
wms|smem
wms|unit
wms|genome_size
wms|dust
wms|dust_level
wms|exclude_ids
wms|ids
wms|text_match
wms|use_ba
);

# each elt : pfx|wrapper_switch_name
our @program_switches = qw(
tbn|h
tbn|help
tbn|ungapped
tbn|lcase_masking
tbn|parse_deflines
tbn|show_gis
tbn|html
tbn|remote
tbn|use_sw_tback
tbn|version
blx|h
blx|help
blx|ungapped
blx|lcase_masking
blx|parse_deflines
blx|show_gis
blx|html
blx|remote
blx|version
bln|h
bln|help
bln|no_greedy
bln|ungapped
bln|lcase_masking
bln|parse_deflines
bln|show_gis
bln|html
bln|remote
bln|version
blp|h
blp|help
blp|lcase_masking
blp|parse_deflines
blp|show_gis
blp|html
blp|ungapped
blp|remote
blp|use_sw_tback
blp|version
psi|h
psi|help
psi|lcase_masking
psi|parse_deflines
psi|show_gis
psi|html
psi|remote
psi|use_sw_tback
psi|version
rpst|h
rpst|help
rpst|ungapped
rpst|lcase_masking
rpst|parse_deflines
rpst|show_gis
rpst|html
rpst|remote
rpst|version
mak|h
mak|help
mak|parse_seqids
mak|hash_index
mak|version
dba|h
dba|help
dba|version
tbx|h
tbx|help
tbx|lcase_masking
tbx|parse_deflines
tbx|show_gis
tbx|html
tbx|remote
tbx|version
dbc|h
dbc|help
dbc|info
dbc|target_only
dbc|get_dups
dbc|ctrl_a
dbc|version
c2m|h
c2m|help
c2m|parse_seqids
c2m|version
dms|h
dms|help
dms|xmlhelp
dms|parse_seqids
dms|version-full
sms|h
sms|help
sms|xmlhelp
sms|parse_seqids
sms|version-full
wms|h
wms|help
wms|xmlhelp
wms|parse_seqids
wms|version-full
wms|mk_counts
);

#each pair : pfx|wrapper_opt_name => command_line_name (without dashes)
# for blast+, the options are all long and mnemonic, so a param translation 
# isn't required. In CommandExts, a parameter name should be passed through 
# as-is, if a translation is not found---.
our %param_translation = (
    );

our %composite_commands = (
    );

our %command_files = (
    );

1;
