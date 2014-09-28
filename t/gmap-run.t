#!perl

use strict;
use warnings;

BEGIN {
    use Bio::Root::Test;
    use Bio::Tools::Run::Build::Test;
    skipall_unless_feature('[Alignment]Gmap');
    test_begin(-tests => 8);
    use_ok( 'Bio::Tools::Run::Alignment::Gmap' );
}

use Bio::SeqIO;

# load the slightly edited her2 sequence (don't expect exact match)
my $sio = Bio::SeqIO->new(-file=>'t/data/her2-edited.fasta' ,-format=>'fasta');
my @seq;
while(my $seq = $sio->next_seq()){
    push @seq,$seq;
}

my $gmapper = Bio::Tools::Run::Alignment::Gmap->new();

SKIP: {

test_skip(-tests => 7, -requires_executable => $gmapper);

my $result_handle = $gmapper->run(\@seq);

my $result;
$result .= $_ while (<$result_handle>);

like($result, qr|^>NM_004448 Homo sapiens|, 'Check query info line');
like($result, qr|md5:a7f28cc6e121f649fa8eb2d44805100e|, 'Check md5 info');
like($result, qr|1 E\t2 G\t\+17:\d+ \d+ G\tE|,
     'Does it look reasonable like -f 9 output');

$result = '';
$gmapper->flags('-A -5 -e -n 100');
$result_handle = $gmapper->run(\@seq);
$result .= $_ while (<$result_handle>);

like($result, qr|^>NM_004448 Homo sapiens|, 'Check query info line');
like($result, qr|md5:a7f28cc6e121f649fa8eb2d44805100e|, 'Check md5 info');
like($result, qr|Paths \(\d+\)|, 'Does it look like -A output (I)');
like($result, qr|Alignment for path \d+|, 'Does it look like -A output (II)');

}
