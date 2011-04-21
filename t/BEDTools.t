#-*-perl-*-
#$Id: BEDTools.t kortsch $

use strict;
use warnings;
no warnings qw(once);
our $home;

my $v = 0; # private verbosity - this module only

BEGIN {
    $home = '.';	# set to '.' for Build use, 
			# '..' for debugging from .t file
    unshift @INC, $home;
    use Bio::Root::Test;
    test_begin(-tests => 423,
	       -requires_modules => [qw(IPC::Run Bio::Tools::Run::BEDTools)]);
}

use Bio::Tools::Run::WrapperBase;
use Bio::SeqIO;
use Bio::Tools::GuessSeqFormat;

# test command functionality

ok my $bedtoolsfac = Bio::Tools::Run::BEDTools->new, "make a default factory";
is $bedtoolsfac->command, 'bam_to_bed', "default to command 'bam_to_bed'";

my @commands = qw(
    annotate         fasta_from_bed       overlap              
    bam_to_bed       genome_coverage      pair_to_pair         
    bed_to_bam       graph_union          pair_to_bed          
    bed_to_IGV       group_by             shuffle              
    b12_to_b6        intersect            slop                 
    closest          links                sort                 
    complement       mask_fasta_from_bed  subtract             
    coverage         merge                window               
);


my %p = (
    'annotate'             => 0,
    'bam_to_bed'           => 2,
    'bed_to_bam'           => 1,
    'bed_to_IGV'           => 5,
    'b12_to_b6'            => 0,
    'closest'              => 1,
    'complement'           => 0,
    'coverage'             => 0,
    'fasta_from_bed'       => 0,
    'genome_coverage'      => 2,
    'graph_union'          => 2,
    'group_by'             => 3,
    'intersect'            => 1,
    'links'                => 3,
    'mask_fasta_from_bed'  => 0,
    'merge'                => 1,
    'overlap'              => 1,
    'pair_to_bed'          => 2,
    'pair_to_pair'         => 3,
    'shuffle'              => 2,
    'slop'                 => 3,
    'sort'                 => 0,
    'subtract'             => 1,
    'window'               => 3
     );

my %s = (
    'annotate'             => 4,
    'bam_to_bed'           => 6,
    'bed_to_bam'           => 2,
    'bed_to_IGV'           => 2,
    'b12_to_b6'            => 0,
    'closest'              => 2,
    'complement'           => 0,
    'coverage'             => 4,
    'fasta_from_bed'       => 3,
    'genome_coverage'      => 4,
    'graph_union'          => 2,
    'group_by'             => 0,
    'intersect'            => 11,
    'links'                => 0,
    'mask_fasta_from_bed'  => 1,
    'merge'                => 3,
    'overlap'              => 0,
    'pair_to_bed'          => 4,
    'pair_to_pair'         => 3,
    'shuffle'              => 1,
    'slop'                 => 1,
    'sort'                 => 6,
    'subtract'             => 1,
    'window'               => 5
    );

# Sorry to all those out there who don't have a find command
# - perhaps someone can add an alternative
my ($rmsk_bed) = `find /usr -name 'rmsk.hg18.chr21.bed' 2>/dev/null`;
chomp $rmsk_bed if $rmsk_bed;
my ($gene_bed) = `find /usr -name 'knownGene.hg18.chr21.bed' 2>/dev/null`;
chomp $gene_bed if $gene_bed;

my ($mm8_genome) = `find /usr -name 'mouse.mm8.genome' 2>/dev/null`;
chomp $mm8_genome if $mm8_genome;
my ($mm9_genome) = `find /usr -name 'mouse.mm9.genome' 2>/dev/null`;
chomp $mm9_genome if $mm9_genome;
my ($hg18_genome) = `find /usr -name 'human.hg18.genome' 2>/dev/null`;
chomp $hg18_genome if $hg18_genome;
my ($hg19_genome) = `find /usr -name 'human.hg19.genome' 2>/dev/null`;
chomp $hg19_genome if $hg19_genome;

my $bam_file = test_input_file('Ft.bam');
my $bed_file = test_input_file('Ft.bed');
my $bed12_file = test_input_file('Ft.bed12');
my $fas_file = test_input_file('Ft.frag.fas');
my $bedpe1_file = test_input_file('e_coli_1.bedpe');
my $bedpe2_file = test_input_file('e_coli_2.bedpe');
my $bed3_file = test_input_file('e_coli.bed3');
my $bg1_file = test_input_file('1.bg');
my $bg2_file = test_input_file('2.bg');
my $bg3_file = test_input_file('3.bg');
 
my %format_lookup = (
    'annotate'             => 'bed',
    'bam_to_bed'           => 'bed',
    'bed_to_bam'           => 'bam',
    'bed_to_IGV'           => 'igv',
    'b12_to_b6'            => 'bed',
    'closest'              => 'bedpe',
    'complement'           => 'bed',
    'coverage'             => 'bed',
    'fasta_from_bed'       => 'fasta',
    'genome_coverage'      => 'tab',
    'graph_union'          => 'bg',
    'group_by'             => 'bed',
    'intersect'            => 'bed|bam',
    'links'                => 'html',
    'mask_fasta_from_bed'  => 'fasta',
    'merge'                => 'bed',
    'overlap'              => 'bed',
    'pair_to_bed'          => 'bedpe|bam',
    'pair_to_pair'         => 'bedpe',
    'slop'                 => 'bed',
    'shuffle'              => 'bed',
    'sort'                 => 'bed',
    'subtract'             => 'bed',
    'window'               => 'bedpe'
    );

my %result_lookup = (
    'annotate'             => 1385,  # OK
    'bam_to_bed'           => 1385,  # OK
    'fasta_from_bed'       => 1385,  # OK
    'mask_fasta_from_bed'  => 1,     # OK
    'shuffle'              => 828,   # OK
    'window'               => 74998, # OK
    'closest'              => 845,   # OK
    'genome_coverage'      => 38,    # OK
    'merge'                => 242,   # OK
    'slop'                 => 828,   # OK
    'complement'           => 291,   # OK - change in data provided by BEDTools or behaviour of complementBed? was 243
    'intersect'            => 72534, # OK
    'pair_to_bed'          => 2,     # OK
    'sort'                 => 828,   # OK
    'coverage'             => 57261, # OK
    'links'                => 11603, # OK
    'pair_to_pair'         => 497,   # OK
    'subtract'             => 57959, # OK
    'group_by'             => 1,     # OK
    'b12_to_b6'            => 1385,  # OK
    'overlap'              => 500    # OK
    );

SKIP : {
    test_skip( -requires_executable => $bedtoolsfac,
	       -tests => 421 );

    COMMAND : for (@commands) {

        $v && diag("Testing command: '$_'");
        ok( my $bedtoolsfac = Bio::Tools::Run::BEDTools->new(-command => $_),
            "make a factory using command '$_'" );
        $v && diag(" return command");
        is( my $command = $bedtoolsfac->command, $_, "factory command for '$_' is correct" );
        $v && diag(" return switches and params");
        is( scalar $bedtoolsfac->available_parameters, $p{$_}+1+$s{$_}, "all available options for '$_'" );
        is( scalar $bedtoolsfac->available_parameters('params'), $p{$_}+1, "available parameters for '$_'" );
        is( scalar $bedtoolsfac->available_parameters('switches'), $s{$_}, "available switches for '$_'" );
        $v && diag(" return executable version");
        ok( $bedtoolsfac->version, "get version for '$_'" );

        for ($command) {
            $v && diag(" run command as default");
            m/^annotate$/ && do {
                ok( my $result = $bedtoolsfac->run( -bgv => $bed_file,
                                                    -ann => [$bed3_file] ),
                    "can run command '$command'" );
                last;
            };
            m/^bam_to_bed$/ && do {
                ok( my $result = $bedtoolsfac->run( -bam => $bam_file ),
                    "can run command '$command'" );
                last;
            };
            m/^(?:fasta_from_bed|mask_fasta_from_bed)$/ && do {
                ok( my $result = $bedtoolsfac->run( -seq => $fas_file,
                                                    -bgv => $bed_file ),
                    "can run command '$command'" );
                last;
            };
            m/^(?:bed_to_IGV|merge|sort|links)$/ && do {
                ok( my $result = $bedtoolsfac->run( -bgv => $gene_bed ),
                    "can run command '$command'" );
                last;
            };
            m/^(?:bed_to_bam|shuffle|slop|complement)$/ && do {
                is( $bedtoolsfac->add_bidirectional(100), 100,
                    "can set parameter -add_bidirectional => 100 " ) if $command eq 'slop';
                ok( my $result = $bedtoolsfac->run( -bgv    => $gene_bed,
                                                    -genome => $hg18_genome ),
                    "can run command '$command'" );
                last;
            };
            m/^genome_coverage$/ && do {
                ok( my $result = $bedtoolsfac->run( -bed    => $gene_bed,
                                                    -genome => $hg18_genome ),
                    "can run command '$command'" );
                last;
            };
            m/^(?:window|closest|coverage|subtract|intersect)$/ && do {
                ok( my $result = $bedtoolsfac->run( -bgv1 => $gene_bed,
                                                    -bgv2 => $rmsk_bed ),
                    "can run command '$command'" );
                last;
            };
            m/^pair_to_pair$/ && do {
                is( $bedtoolsfac->type('neither'), 'neither',
                    "can set parameter -type => 'neither'" );
                ok( my $result = $bedtoolsfac->run( -bedpe1 => $bedpe1_file,
                                                    -bedpe2 => $bedpe2_file ),
                    "can run command '$command'" );
                last;
            };
            m/^pair_to_bed$/ && do {
                ok( my $result = $bedtoolsfac->run( -bedpe => $bedpe1_file,
                                                    -bgv => $bed3_file ),
                    "can run command '$command'" );
                last;
            };
            m/^overlap$/ && do {
            	is( $bedtoolsfac->columns('2,3,5,6'), '2,3,5,6',
                    "can set parameter -columns => '2,3,5,6' " );
                ok( my $result = $bedtoolsfac->run( -bed => $bedpe1_file, ),
                    "can run command '$command'" );
                last;
            };
            m/^b12_to_b6$/ && do {
                ok( my $result = $bedtoolsfac->run( -bed => $bed12_file, ),
                    "can run command '$command'" );
                last;
            };
            m/^group_by$/ && do {
            	is( $bedtoolsfac->group(1), 1,
                    "can set parameter -group => 1 " );
            	is( $bedtoolsfac->columns('2,2,3,3'), '2,2,3,3',
                    "can set parameter -columns => '2,2,3,3' " );
            	is( $bedtoolsfac->operations('min,max,min,max'), 'min,max,min,max',
                    "can set parameter -operations => 'min,max,min,max' " );
                ok( my $result = $bedtoolsfac->run( -bed => $bed3_file ),
                    "can run command '$command'" );
                last;
            };
			m/^graph_union$/ && do {
                ok( my $result = $bedtoolsfac->run( -bg => [$bg1_file, $bg2_file, $bg2_file] ),
                    "can run command '$command'" );
                last;
			};
            do {
                # we should never get here - internal test
                fail( "all commands tested - missed '$_'");
            };
        }

        $v && diag(" check file has been written");
        ok( eval { (-e $bedtoolsfac->result && -r _) }, "result files exists for command '$command'");
        $v && diag(" check can get internal result format description and confirm it");
        ok( my $format = $bedtoolsfac->result( -want => 'format' ),
            "can return output format for command '$command'" );
        like( $format, qr/(?:$format_lookup{$command})/,
            "result claims to be in correct format for command '$command'" );
        $v && diag(" check can get internal result file name value");
        ok( my $file = $bedtoolsfac->result(-want=>'raw'),
            "can return output file for command '$command'" );
        if ($command eq 'links') {
            $v && diag(" check result file is html and correct size");
            ok eval { (-e $file)&&(-r _) }, "make readable output";
            open (FILE, $file);
            my $lines =(my $first_line)= <FILE>;
            close FILE;         
            like( $first_line, qr/\<html\>/, " - html tag line");
            is( $lines, $result_lookup{$command}, " - number of lines");
        } elsif ($command eq 'genome_coverage') {
            $v && diag(" check result file is correct size");
            ok eval { (-e $file)&&(-r _) }, "make readable output";
            open (FILE, $file);
            my $lines =()= <FILE>;
            close FILE;         
            is( $lines, $result_lookup{$command}, " - number of lines");
        } else {
            $v && diag(" check can get internal result format matches result file");
            my $guesser = Bio::Tools::GuessSeqFormat->new( -file => $file );
            for ($format_lookup{$command}) {
                m/^(?:bed|bedpe|tab)$/ && do {
                    is( $guesser->guess, 'tab', "file format of '$file' consistent with claim for '$command'" );
                    last;
                };
                m/^fasta$/ && do {
                    is( $guesser->guess, 'fasta', "file format consistent with claim for '$command'" );
                }
            }
        }
        $v && diag(" check can get and set wanted result type");
        is( $bedtoolsfac->want('Bio::Root::IO'), 'Bio::Root::IO',
            "can set want to IO object for command '$command'" );
        $v && diag(" check can get a Bio::Root::IO object");
        ok( my $objres = $bedtoolsfac->result, "can get the basic object result for command '$command'" );
        $v && diag(" - check can it is actually a Bio::Root::IO object");
        isa_ok( $objres, 'Bio::Root::IO', "returned object is correct for command '$command'" );
        for ($format_lookup{$command}) {
            $v && diag(" check can can get format-specific result object if supported");
            m/(?:bed|bedpe)/ && do {
                $v && diag(" - Bio::SeqFeature::Collection");
                ok( my $objres = $bedtoolsfac->result( -want => 'Bio::SeqFeature::Collection' ),
                    "can get the specific object result for command '$command'" );
                isa_ok( $objres, 'Bio::SeqFeature::Collection',
                    "returned object is correct for command '$command'" );
                $v && diag(" - correct number of features");
                is( scalar $objres->get_all_features, $result_lookup{$command},
                    "correct number of features for command '$command'" );
                last;
            };
            m/^fasta$/ && do {
                $v && diag(" - Bio::SeqIO");
                ok( my $objres = $bedtoolsfac->result( -want => 'Bio::SeqIO' ),
                    "can get the specific object result for command '$command'" );
                isa_ok( $objres, 'Bio::SeqIO',
                    "returned object is correct for command '$command'" );
                my $seq_count = 0;
                while( my $seq = $objres->next_seq ) {
                    $seq_count++;
                }
                $v && diag(" - correct number of sequences");
                is( $seq_count, $result_lookup{$command}, "correct number of sequences for command '$command'" );
            }
        }            
    }
}

1;
