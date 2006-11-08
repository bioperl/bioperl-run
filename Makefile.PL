## --Makefile.PL for bioperl-run distribution--##
## ----------------------------------------------------##
## $Id$
##----------------------------------------------------

#
# Start with object preamble and setup of variables that might need changing
# in the future
#

require 5.006_001;
use strict;
use warnings;
use File::Spec::Functions;
use ExtUtils::MakeMaker;
use Cwd;

my $VERSION = 1.005002_003;
$VERSION = eval $VERSION;

# All Bioperl dependencies on external modules are defined here
# (these are mostly considered optional)
my %packages = (
  'Algorithm::Diff'       => '0.0/Compute intelligent differences between two files/generating consensus protein family descriptions/TribeMCL',
  'XML::Parser::PerlSAX'  => '0.0/XML SAX parser/Pise Applications/Pise::Job',
  'HTML::Parser'					=> '0.0/HTML Parser/Pise Applications/Pise::Job',
  'Bio::Root::Version'    => '1.005002/Bioperl/basic functionality/Everything',
);

# We don't want CPAN, Bundle::BioPerl et al. to know about these for various
# reasons (eg. because they would cause a circular dependency), so will exclude
# them from PREREQ_PM later on
my %exclude_from_prereqs = (
  
);

# These are really required
my %required = (
	'Bio::Root::Version' => 'Bioperl-core is fundamental to operation'
);


#
# Main code
#

# generate string for makefile that allows show_tests and make test_<testname>
# to work
opendir(DIR,"t") || die "No test directory. Cannot continue.";
my @files = readdir(DIR);
shift @files;
shift @files;
my ($tline, $tset);
foreach my $file (@files) {
  $file =~ /(\w+)\.t/ || next;
  $file = $1;
  my $path = catfile('t', $file);
  my $line = "test_$file :: pure_all\n\tPERL_DL_NONLAZY=1 \$(FULLPERL) -I\$(INST_ARCHLIB) -I\$(INST_LIB) -I\$(PERL_ARCHLIB) -I\$(PERL_LIB) -e \'use Test::Harness qw(&runtests \$\$verbose); \$\$verbose=\$(TEST_VERBOSE); runtests \@ARGV;\' $path.t\n";
  $tline .= $line;
  $tset  .= " $file \\\n";
}
$tline = "show_tests :\n\t\@echo \'type make test_<subtest> to run\'\n\t\@echo '$tset'\n$tline\n";
print STDERR "Generated sub tests. go make show_tests to see available subtests\n";

# we may end up creating extra files we would want to clean later; note them here
my @should_be_cleaned;

# ask questions about optional stuff to install/test
prompt_for_pise_email();

# notify about optional modules that haven't been installed, and generate hash
# for prereqs needed later in WriteMakefile
my %prereq;
my $error = 0;
print "\n*** Optional dependencies section ***\n";
while (my ($name, $value) = each %packages) {
  my ($ver, $desc, $expl, $module) = split( /\// , $value);
	no strict 'refs';
  if (! eval "require $name;" || ${$name.'::VERSION'} < $ver) {
    my @modules = split(',', $module);
    my $modules = join("\n * ", @modules);
    print "External Module '$name' >= $ver ($desc) is not installed on this computer.\n The following Bioperl-run modules need it for $expl:\n * $modules\n";
    $error = 1;
    
    if (exists $exclude_from_prereqs{$name}) {
      print "Additionally, it will not be considered a pre-requisite\n(and therefore will not be automatically installed by CPAN) because:\n $exclude_from_prereqs{$name}.\n\n";
    }
		elsif (exists $required{$name}) {
			print "Additionally, it is absolutely required\n(and therefore we will now die) because:\n $required{$name}.\n\n";
			$error = 2;
		}
    else {
      print "\n";
    }
  }
  
  unless (exists $exclude_from_prereqs{$name}) {
    $prereq{$name} = $ver;
  }
}
if ($error == 1) {
  print <<QQ_ERROR_QQ;
Information:

  Some perl modules are missing, listed above and below. The only
  functionality that will be affected is described above;
  the rest of bioperl will work fine without them.

  The installation of these external packages is very simple. You
  can read more about bioperl external dependencies in the INSTALL
  file or at:

  http://bioperl.org/wiki/Installing_BioPerl

  Enjoy the rest of bioperl, which you can use after going 'make install'

QQ_ERROR_QQ
}
elsif ($error == 2) {
	die "\n";
}
else {
	print "All dependencies are installed\n\n";
}

# write the makefile
WriteMakefile(
  NAME         => 'Bio',
  DISTNAME     => 'bioperl-run',
  VERSION      => $VERSION,
  dist         => { COMPRESS     => 'gzip -9f',
                    SUFFIX       => '.gz',
                    DIST_DEFAULT => 'all tardist'
                  },
  'AUTHOR'     => 'Bioperl Team (bioperl-l@bioperl.org)',
  'ABSTRACT'   => 'Bioinformatics Toolkit',
  # clean() is overridden and also gets rid of @should_be_cleaned
  realclean    => { FILES => join(' ', @should_be_cleaned) },
  PREREQ_PM    => \%prereq,
  # Once 'nmake ppd' has been issued, the PPD needs to be modified for use with PPM4
  # In addition, non-critical prereq's should be moved to a Bundle::BioPerl PPD
  # A bit of a pain, but better to have all the prereq's in the same place initially
  # TODO I'll (Nathan Haigh) added updated details to the wiki for doing this
);

exit;


#
# subroutines
#

sub prompt_for_pise_email {
  print "\n*** Pise Tests section *** \n";
	my $proceed = prompt("Do you want to run the Pise tests with a valid email address? y/n",'n');
	my $path = catfile('t', 'pise-email.test');
	if ($proceed =~ /^[yY]/) {
		my $address = prompt("Enter your email address",'');
		if ($address && open(T,">t/pise-email.test")) {
			print T "$address\n";
			close T;
		}
		else {
			warn("Cannot open file t/pise-email.test for writing, or no email supplied - Pise tests will be run without an email address");
		}
		push(@should_be_cleaned, $path);
	}
	else {
		if (-e $path) {
			unlink $path;
		}
	}
}


#
# override MakeMaker methods
#

sub MY::postamble {
  $tline;
}

package MY;

sub MY::clean {
  return shift->SUPER::clean(@_) . <<END;
\t-rm -rf @should_be_cleaned
END
}
