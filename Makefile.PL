## --Makefile.PL for Bioperl-pipeline distribution--##
## ----------------------------------------------------##
## $Id$
##----------------------------------------------------

#
# Basically this is a standard Makefile with a hash of
# needed packages which are tested at the start
#
# If you want help with this Makefile get in touch with
# the developers by sending a message to bioperl-l@bioperl.org.
require 5.005;
use ExtUtils::MakeMaker;



# All Bioperl dependencies on external modules are defined here
%packages = (
  'Algorithm::Diff'       =>'0.0/Compute intelligent differences between two files/generating consensus protein family descriptions/TribeMCL',
  'IO::String'            => '0.0/IO handle to read or write to a string/GenBank+GenPept sequence retrieval, Variation code/Bio::DB::*,Bio::Variation::*,Bio::Tools::Blast::Run::Webblast, Bio::Index::Blast',
  'File::Temp'            => '0.0/Temporary File creation/Bio::Root::IO uses if present/Bio::DB::WebDBSeqI, Bio::Seq::LargePrimarySeq',
  'XML::Parser::PerlSAX'  => '0.0/XML SAX parser/Pise Applications/Pise::Job',
  'HTML::Parser'	  => '0.0/HTML Parser/Pise Applications/Pise::Job',
  'Bio::Root::Version'       => '0.0/Bioperl//',
);

sub check_package {
    my ($name,$str) = @_;
    my ($ver,$desc,$expl,$module) = split( /\// , $str);
    if( !eval "require($name)") {
    	if ($name eq 'Bio::Root::Version') {
	  print "Bioperl-run absolutely needs Bioperl to work - It makes no sense without it\n";
	  exit(0);
	}
	print "External Module $name, $desc,\n is not installed on this computer.\n  The $module module in bioperl-run  needs it for $expl\n\n";
	return 1;
    }

    return 0;
}

#
# Generate sub testing package system
#
#

# make mini test targets for playing around with
# in testing...

opendir(DIR,"t") || warn "No test directory. Weird!";
@files = readdir(DIR);
shift @files;
shift @files;
foreach my $file (@files) {
    $file =~ /(\w+)\.t/ || next;
    $file = $1;
    $line = "test_$file :: pure_all\n\tPERL_DL_NONLAZY=1 \$(FULLPERL) -I\$(INST_ARCHLIB) -I\$(INST_LIB) -I\$(PERL_ARCHLIB) -I\$(PERL_LIB) -e \'use Test::Harness qw(&runtests \$\$verbose); \$\$verbose=\$(TEST_VERBOSE); runtests \@ARGV;\' t/$file.t\n";
    push(@tline,$line);
    push(@targets,$file);
    $tset  .= "$file \\\n";
}

$tline = join('',@tline);
$tline = "show_tests :\n\t\@echo \'type make test_<subtest> to run\'\n\t\@echo '$tset'\n$tline\n";

print STDERR "Generated sub tests. go make show_tests to see available subtests\n";

sub MY::postamble {
             $tline;
}

#
# Talk to Elia Stupka (<elia@fugu-sg.org>) or bioperl-l@bioperl.org for more info.
#

# Let the code begin...

my $NAME     = 'Bio';
my $DISTNAME = "bioperl-run";
my $VERSION  = "1.5.0-RC1";

my $proceed = "n";
if( $proceed =~ /^[yY]/) {
    my $address = prompt("Enter your email address (no default)",'');
   
    if (open T,">t/pise-email.test") {
print T "$address\n";
close T;
    } else { warn("Cannot open file t/pise-email.test for writing - no Pise tests will be run"); }
} else {
    if( -e "t/pise-email.test" ) {
unlink "t/pise-email.test";
    }
}
#$do_autoload_finesse = 0;
#$NAME     = 'Bio';
#$DISTNAME = "GFD";
#$VERSION  = "1.00";

$error = 0;
print "\n";
foreach $name ( keys %packages ) {
    if( &check_package($name,$packages{$name}) == 1 ) {
	$error = 1;
    }
}

if( $error == 1 ) {
    print <<QQ_ERROR_QQ;

Warning:

   There are some external packages and perl modules, listed above, which 
   bioperl-run uses. This only effects the functionality which is listed above:
the rest of bioperl-run will work fine.

   Enjoy the rest of bioperl-run, which you can use after going 'make install'

QQ_ERROR_QQ
}

# generate hash for prerequisites
# for use in WriteMakefile
my %prereq;
while (my ($key, $value) = each %packages) {
  my ($version,$desc,$expl,$module) = split( /\// , $value);
  $prereq{$key} = $version;
}

WriteMakefile(
  NAME         => $NAME,
  DISTNAME     => $DISTNAME,
  VERSION      => $VERSION,
  dist         => { COMPRESS     => 'gzip -9f',
                    SUFFIX       => '.gz',
		    DIST_DEFAULT => 'all tardist',
  },
  ($] ge '5.005') ? (
    'AUTHOR'   => 'Bioperl Team (bioperl-l@bioperl.org)',
    'ABSTRACT' => 'Bioperl Wrapper Toolkit',
  ) : (),
  realclean   => { FILES => join(' ', @BACKUP_FILES) },
  DIR         => [  ], # directories with other Makefile.PL's in them
  PREREQ_PM   => \%prereq,
  # Once 'nmake ppd' has been issued, the PPD needs to be modified for use with PPM4
  # For example, see http://www.bioperl.org/wiki/Create_a_Bioperl_PPM_Package
);

