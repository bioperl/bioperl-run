# This is -*-Perl-*- code
## Bioperl Test Harness Script for Modules

use strict;

BEGIN {
    use Bio::Root::Test;
    test_begin(
        -tests => 14,
    );
    use_ok('Bio::Root::IO');
    use_ok('Bio::Tools::Run::Phylo::ExaML');
    use_ok('Bio::AlignIO');
}

END { unlink glob "ExaML_*.*"; }

ok(my $examl = Bio::Tools::Run::Phylo::ExaML->new( -quiet => 1), "Make the object");
isa_ok( $examl, 'Bio::Tools::Run::Phylo::ExaML');

# define input
my $alignfile = test_input_file('testaln.phylip');
my $starttree = test_input_file('primates.tre');

SKIP: {
    test_skip(
        -requires_executable => $examl,
        -tests               => 6
    );

    # Run examl with phylip alignment and starting tree
    my $tree = $examl->run($alignfile, $starttree);
	ok( defined($tree), "Tree is defined" );
	isa_ok( $tree, 'Bio::Tree::TreeI');	

	# Test examl with no starting tree given, NJ starttree will be generated
	$tree = $examl->run($alignfile);
	ok( defined($tree), "Tree is defined" );
	isa_ok( $tree, 'Bio::Tree::TreeI');	

	# The working directory could be different, i.e. -w set
	$examl->w($examl->tempdir);
	$tree = $examl->run($alignfile, $starttree);
	ok( defined($tree), "Tree is defined" );
	isa_ok( $tree, 'Bio::Tree::TreeI');	
}

# test examl in parallel mode, in case 'mpirun' can be found in PATH
$ENV{'MPIRUN'} = 'mpirun' if scalar (grep {defined $_} map { -f "$_/mpirun" && -x "$_/mpirun" } (split /:/, $ENV{'PATH'}));

SKIP: {
	 test_skip(
		 -requires_env => 'MPIRUN',
		 -requires_executable => $examl,
		 -tests        => 3,
	 );
	 $examl = Bio::Tools::Run::Phylo::ExaML->new( -quiet => 1);
	 ok($examl->mpirun($ENV{'MPIRUN'}), "set mpirun");
	 my $tree = $examl->run($alignfile, $starttree);
	 ok( defined($tree), "Tree is defined" );
	 isa_ok( $tree, 'Bio::Tree::TreeI');	
}
