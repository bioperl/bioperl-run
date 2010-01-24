#-*-perl-*-
#$Id: BEDTools.t kortsch $

use strict;
use warnings;
no warnings qw(once);
our $home;
BEGIN {
    $home = '.';	# set to '.' for Build use, 
						# '..' for debugging from .t file
    unshift @INC, $home;
    use Bio::Root::Test;
    test_begin(-tests => 119,
	       -requires_modules => [qw(IPC::Run Bio::Tools::Run::BEDTools)]);
}

use Bio::Tools::Run::WrapperBase;
use Bio::SeqIO;
use Bio::Tools::GuessSeqFormat;

my @commands = qw(
    bam_to_bed       fasta_from_bed       mask_fasta_from_bed  shuffle              window
    closest          genome_coverage      merge                slop
    complement       intersect            pair_to_bed          sort
    coverage         links                pair_to_pair         subtract
);

my %p = (
    'bam_to_bed'           => 0,
    'fasta_from_bed'       => 0,
    'mask_fasta_from_bed'  => 0,
    'shuffle'              => 2,
    'window'               => 3,
    'closest'              => 1,
    'genome_coverage'      => 1,
    'merge'                => 1,
    'slop'                 => 3,
    'complement'           => 0,
    'intersect'            => 1,
    'pair_to_bed'          => 2,
    'sort'                 => 0,
    'coverage'             => 0,
    'links'                => 3,
    'pair_to_pair'         => 2,
    'subtract'             => 1
    );

my %s = (
    'bam_to_bed'           => 2,
    'fasta_from_bed'       => 2,
    'mask_fasta_from_bed'  => 1,
    'shuffle'              => 1,
    'window'               => 5,
    'closest'              => 1,
    'genome_coverage'      => 1,
    'merge'                => 3,
    'slop'                 => 1,
    'complement'           => 0,
    'intersect'            => 8,
    'pair_to_bed'          => 2,
    'sort'                 => 6,
    'coverage'             => 1,
    'links'                => 0,
    'pair_to_pair'         => 1,
    'subtract'             => 1
    );

my ($rmsk_bed) = `find /usr -name 'rmsk.hg18.chr21.bed' 2>/dev/null`;
chomp $rmsk_bed;
my ($gene_bed) = `find /usr -name 'knownGene.hg18.chr21.bed' 2>/dev/null`;
chomp $gene_bed;

my ($mm8_genome) = `find /usr -name 'mouse.mm8.genome' 2>/dev/null`;
chomp $mm8_genome;
my ($mm9_genome) = `find /usr -name 'mouse.mm9.genome' 2>/dev/null`;
chomp $mm9_genome;
my ($hg18_genome) = `find /usr -name 'human.hg18.genome' 2>/dev/null`;
chomp $hg18_genome;
my ($hg19_genome) = `find /usr -name 'human.hg19.genome' 2>/dev/null`;
chomp $hg19_genome;

my $bam_file = test_input_file('Ft.bam');
my $bed_file = test_input_file('Ft.bed');
my $fas_file = test_input_file('Ft.frag.fas');
 
my %format_lookup = (
    'bam_to_bed'           => 'bed',
    'fasta_from_bed'       => 'fasta',
    'mask_fasta_from_bed'  => 'fasta',
    'shuffle'              => 'bed',
    'window'               => 'bedpe',
    'closest'              => 'bedpe',
    'genome_coverage'      => 'tab',
    'merge'                => 'bed',
    'slop'                 => 'bed',
    'complement'           => 'bed',
    'intersect'            => 'bed|bam',
    'pair_to_bed'          => 'bedpe|bam',
    'sort'                 => 'bed',
    'coverage'             => 'bed',
    'links'                => 'html',
    'pair_to_pair'         => 'bedpe',
    'subtract'             => 'bed'
    );

# test command functionality

ok my $bedtoolsfac = Bio::Tools::Run::BEDTools->new, "make a default factory";

is $bedtoolsfac->command, 'bam_to_bed', "default to command 'bam_to_bed'";

SKIP : {
    test_skip( -requires_executable => $bedtoolsfac,
	       -tests => 24 );

    for (@commands) {
        ok( my $bedtoolsfac = Bio::Tools::Run::BEDTools->new(-command => $_),
            "make a factory using command '$_'" );
        is( my $command = $bedtoolsfac->command, $_, "factory command for '$_' is correct" );
        is( scalar $bedtoolsfac->available_parameters, $p{$_}+1+$s{$_}, "all available options for '$_'" );
        is( scalar $bedtoolsfac->available_parameters('params'), $p{$_}+1, "available parameters for '$_'" );
        is( scalar $bedtoolsfac->available_parameters('switches'), $s{$_}, "available switches for '$_'" );
        ok( $bedtoolsfac->version, "get version for '$_'" );

        for ($command) {
            m/^bam_to_bed$/ && do {
                ok( my $result = $bedtoolsfac->run( -bam => $bam_file ),
                    "can run command '$command'" );
                last;
            };
            m/^(?:fasta_from_bed|mask_fasta_from_bed)$/ && do {
                ok( my $result = $bedtoolsfac->run( -seq => $fas_file,
                                                    -bed => $bed_file ),
                    "can run command '$command'" );
                last;
            };
            m/^(?:merge|sort|links)$/ && do {
                ok( my $result = $bedtoolsfac->run( -bed => $gene_bed ),
                    "can run command '$command'" );
                last;
            };
            m/^(?:shuffle|slop|complement|genome_coverage)$/ && do {
                $bedtoolsfac->add_bidirectional(100) if $command eq 'slop';
                ok( my $result = $bedtoolsfac->run( -bed    => $gene_bed,
                                                    -genome => $hg18_genome ),
                    "can run command '$command'" );
                last;
            };
            m/^(?:window|closest|coverage|subtract|intersect)$/ && do {
                ok( my $result = $bedtoolsfac->run( -bed1 => $gene_bed,
                                                    -bed2 => $rmsk_bed ),
                    "can run command '$command'" );
                last;
            };
            m/^pair_to_pair$/ && do {
                # no test here yet
                last;
            };
            m/^pair_to_bed$/ && do {
                # no test here yet
                last;
            };
            do {
                # we should never get here - internal test
                ok( eval { 0 }, "all commands tested '$_'");
            };
            ok( eval { (-e $bedtoolsfac->result && -r _) }, "result files exists for command '$command'");
            ok( my $format = $bedtoolsfac->result( -want => 'format' ),
                "can return output format for command '$command'" );
            like( $format, qr/(?:$format_lookup{$command})/,
                "result claims to be in correct format for command '$command'" );
            unless ($command eq 'links') {
                my $guesser = Bio::Tools::SeqFormatGuesser->new( -file => $bedtoolsfac->result );
                for ($format_lookup{$command}) {
                    m/^(?:bed|bedpe|tab)$/ && do {
                        is( $guesser->guess, 'tab', "file format consistent with claim for '$command'" );
                        last;
                    };
                    m/^fasta$/ && do {
                        is( $guesser->guess, 'fasta', "file format consistent with claim for '$command'" );
                    }
                }
            }
            is( $bedtoolsfac->want('Bio::Root::IO'), 'Bio::Root::IO',
                "can set want to IO object for command '$command'" );
            ok( my $objres = $bedtoolsfac->result, "can get the basic object result for command '$command'" );
            like( ref($objres), qr/Bio::Root::IO/, "returned object is correct for command '$command'" );
                my $guesser = Bio::Tools::SeqFormatGuesser->new( -file => $bedtoolsfac->result );
            for ($format_lookup{$command}) {
                m/^(?:bed|bedpe)$/ && do {
                    ok( my $objres = $bedtoolsfac->result( -want => 'Bio::SeqSeqFeature::Collection' ),
                        "can get the specific object result for command '$command'" );
                    like( ref($objres), qr/Bio::SeqFeature::Collection/,
                        "returned object is correct for command '$command'" );
                    is( scalar $objres->get_all_features, 0,
                        "correct number of features for command '$command'" );
                    last;
                };
                m/^fasta$/ && do {
                    ok( my $objres = $bedtoolsfac->result( -want => 'Bio::SeqIO' ),
                        "can get the specific object result for command '$command'" );
                    like( ref($objres), qr/Bio::SeqIO/,
                        "returned object is correct for command '$command'" );
                    my $seq_count = 0;
                    while( my $seq = $objres->next_seq ) {
                        $seq_count++;
                    }
                    for ($command) {
                        m/^fasta_from_bed$/ && do {
                            is( $seq_count, 1385, "correct number of sequences for command '$command'" );
                            last;
                        };
                        m/^mask_fasta_from_bed$/ && do {
                            is( $seq_count, 1, "correct number of sequences for command '$command'" );
                        }
                    }
                }
            }            
        }
    }
}

1;
