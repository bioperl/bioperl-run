
require 5.005;
use ExtUtils::MakeMaker;

my $NAME     = 'Bio';
my $DISTNAME = "bioperl-run";
my $VERSION  = "1.00";

my $proceed = prompt("Do you want to run the Pise tests (requires a network connection) y/n",'n');
if( $proceed =~ /^[yY]/) {
    my $address = prompt("Enter your email address (devnull\@pasteur.fr is default)",'devnull@pasteur.fr');
    
    if (open T,">t/pise-email.test") {
	print T "$address\n"; 
	close T;
    } else { warn("Cannot open file t/pise-email.test for writing - no Pise tests will be run"); } 
} else {
    if( -e "t/pise-email.test" ) {
	unlink "t/pise-email.test";
    }
}

WriteMakefile(
    NAME	=> $NAME,
    DISTNAME    => $DISTNAME,
    VERSION     => $VERSION,
    'dist'      => {  COMPRESS     => 'gzip -9f',
                      SUFFIX       => '.gz', 
                      DIST_DEFAULT => 'all tardist',
                   },
    ($] ge '5.005')  ? (
	'AUTHOR' => 'Bioperl Team (bioperl-l@bioperl.org)',
	'ABSTRACT' => 'Bioinformatics Toolkit',
	) : (),
     'realclean'  => {  FILES        => '' }
);
