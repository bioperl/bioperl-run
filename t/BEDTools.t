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
    test_begin(-tests => 305,
	       -requires_modules => [qw(IPC::Run Bio::Tools::Run::BEDTools)]);
}

use Bio::Tools::Run::WrapperBase;
use Bio::SeqIO;
use Bio::Tools::GuessSeqFormat;

# test command functionality

ok my $bedtoolsfac = Bio::Tools::Run::BEDTools->new, "make a default factory";
is $bedtoolsfac->command, 'bam_to_bed', "default to command 'bam_to_bed'";

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
my $bedpe1_file = test_input_file('e_coli_1.bedpe');
my $bedpe2_file = test_input_file('e_coli_2.bedpe');
my $bed3_file = test_input_file('e_coli.bed3');
 
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

my %result_lookup = (
    'bam_to_bed'           => 1385,  # OK
    'fasta_from_bed'       => 1385,  # OK
    'mask_fasta_from_bed'  => 1,     # OK
    'shuffle'              => 828,   # OK
    'window'               => 74998, # OK
    'closest'              => 845,   # OK
    'genome_coverage'      => 38,    # OK
    'merge'                => 242,   # OK
    'slop'                 => 828,   # OK
    'complement'           => 243,   # OK
    'intersect'            => 72534, # OK
    'pair_to_bed'          => 2,     # OK
    'sort'                 => 828,   # OK
    'coverage'             => 57261, # OK
    'links'                => 11603, # OK
    'pair_to_pair'         => 497,   # OK
    'subtract'             => 57959  # OK
    );

SKIP : {
    test_skip( -requires_executable => $bedtoolsfac,
	       -tests => 303 );

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
                is( $bedtoolsfac->add_bidirectional(100), 100,
                    "can set parameter -add_bidirectional => 100 " ) if $command eq 'slop';
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
                is( $bedtoolsfac->type('neither'), 'neither',
                    "can set parameter -type => 'neither'" );
                ok( my $result = $bedtoolsfac->run( -bedpe1 => $bedpe1_file,
                                                    -bedpe2 => $bedpe2_file ),
                    "can run command '$command'" );
                last;
            };
            m/^pair_to_bed$/ && do {
                ok( my $result = $bedtoolsfac->run( -bedpe => $bedpe1_file,
                                                    -bed => $bed3_file ),
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
