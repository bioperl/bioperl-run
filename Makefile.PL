
require 5.005;
use ExtUtils::MakeMaker;

my $NAME     = 'Bio';
my $DISTNAME = "bioperl-run";
my $VERSION  = "1.00";

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
