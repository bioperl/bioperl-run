
=head1 NAME

Bio::Tools::Run::PiseApplication::hmmbuild

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::hmmbuild

      Bioperl class for:

	HMMER	hmmbuild - construct an HMM from a multiple sequence alignment (S. Eddy)

      Parameters:


		hmmbuild (String)


		alignfile (Sequence)
			Aligned sequences File
			pipe: hmmer_alig

		hmmfile (OutFile)


		hmmfile_res (Results)

			pipe: hmmer_HMM

		configure_options (Paragraph)
			Configure options

		multiple_local (Switch)
			multiple local alignments (-f)

		single_global (Switch)
			 single global alignment (-g)

		single_local (Switch)
			single local alignment (-s)

		output_options (Paragraph)
			 Output options 

		name (String)
			name the HMM (-n 'name')

		re_save (OutFile)
			Re-save the starting alignment to 'file', in SELEX format. (-o 'file')

		append (InFile)
			append the model to an existing HMMs file (-A)

		expert_options (Paragraph)
			Expert Options

		amino (Switch)
			Force the sequence alignment to be interpreted as amino acid sequences. (--amino)

		archpri (Float)
			Set the 'architecture prior' to x (--archpri x)

		binary (Switch)
			Write the HMM to hmmfile in HMMER binary format instead of readable ASCII text. (--binary)

		cfile (Switch)
			Save the observed emission and transition counts to a file (--cfile f)

		fast (Switch)
			Quickly and heuristically determine the architecture of the model (--fast)

		gapmax (Float)
			Controls the --fast model construction algorithm, (--gapmax x)

		hand (Switch)
			Specify the architecture of the model by hand (--hand)

		idlevel (Float)
			 (--idlevel x)

		noeff (Switch)
			Turn off the effective sequence number calculation (--noeff)

		nucleic (Switch)
			Force the alignment to be interpreted as nucleic acid sequence (--nucleic)

		null (InFile)
			null model (--null f)

		pam (InFile)
			heuristic PAM based prior (--pam f)

		pamwgt (Float)
			Controls the weight on a PAM-based prior. (--pamwgt x)

		pbswitch (Integer)
			PB weights (--pbswitch n)

		prior (InFile)
			Dirichlet prior (--prior f)

		swentry (Float)
			Controls the total probability that is distributed to local entries into the model (--swentry x)

		swexit (Float)
			Controls the total probability that is distributed to local exits from the model (--swexit x)

		verbose (Switch)
			Print more possibly useful stuff, such as the individual scores for each sequence in the alignment. (--verbose)

		wblosum (Switch)
			Use the BLOSUM filtering algorithm to weight the sequences (--wblosum)

		wgsc (Switch)
			Use the Gerstein/Sonnhammer/Chothia ad hoc sequence weighting algorithm. (--wgsc)

		wme (Switch)
			Use the Krogh/Mitchison maximum entropy algorithm to 'weight' the sequences. (--wme)

		wnone (Switch)
			Turn off all sequence weighting. (--wnone)

		wpb (Switch)
			Use the Henikoff position-based weighting scheme (--wpb)

		wvoronoi (Switch)
			Use the Sibbald/Argos Voronoi sequence weighting algorithm in place of the default GSC weighting. (--wvoronoi)

		counts_file (Results)


=cut

#'
package Bio::Tools::Run::PiseApplication::hmmbuild;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $hmmbuild = Bio::Tools::Run::PiseApplication::hmmbuild->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::hmmbuild object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $hmmbuild = $factory->program('hmmbuild');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::hmmbuild.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmbuild.pm

    $self->{COMMAND}   = "hmmbuild";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "HMMER";

    $self->{DESCRIPTION}   = "hmmbuild - construct an HMM from a multiple sequence alignment";

    $self->{CATEGORIES}   =  [  

         "alignment:multiple",

         "hmm",
  ];

    $self->{AUTHORS}   = "S. Eddy";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"hmmbuild",
	"alignfile",
	"hmmfile",
	"hmmfile_res",
	"configure_options",
	"output_options",
	"expert_options",
	"counts_file",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"hmmbuild",
	"alignfile", 	# Aligned sequences File
	"hmmfile",
	"hmmfile_res",
	"configure_options", 	# Configure options
	"multiple_local", 	# multiple local alignments (-f)
	"single_global", 	#  single global alignment (-g)
	"single_local", 	# single local alignment (-s)
	"output_options", 	#  Output options 
	"name", 	# name the HMM (-n 'name')
	"re_save", 	# Re-save the starting alignment to 'file', in SELEX format. (-o 'file')
	"append", 	# append the model to an existing HMMs file (-A)
	"expert_options", 	# Expert Options
	"amino", 	# Force the sequence alignment to be interpreted as amino acid sequences. (--amino)
	"archpri", 	# Set the 'architecture prior' to x (--archpri x)
	"binary", 	# Write the HMM to hmmfile in HMMER binary format instead of readable ASCII text. (--binary)
	"cfile", 	# Save the observed emission and transition counts to a file (--cfile f)
	"fast", 	# Quickly and heuristically determine the architecture of the model (--fast)
	"gapmax", 	# Controls the --fast model construction algorithm, (--gapmax x)
	"hand", 	# Specify the architecture of the model by hand (--hand)
	"idlevel", 	#  (--idlevel x)
	"noeff", 	# Turn off the effective sequence number calculation (--noeff)
	"nucleic", 	# Force the alignment to be interpreted as nucleic acid sequence (--nucleic)
	"null", 	# null model (--null f)
	"pam", 	# heuristic PAM based prior (--pam f)
	"pamwgt", 	# Controls the weight on a PAM-based prior. (--pamwgt x)
	"pbswitch", 	# PB weights (--pbswitch n)
	"prior", 	# Dirichlet prior (--prior f)
	"swentry", 	# Controls the total probability that is distributed to local entries into the model (--swentry x)
	"swexit", 	# Controls the total probability that is distributed to local exits from the model (--swexit x)
	"verbose", 	# Print more possibly useful stuff, such as the individual scores for each sequence in the alignment. (--verbose)
	"wblosum", 	# Use the BLOSUM filtering algorithm to weight the sequences (--wblosum)
	"wgsc", 	# Use the Gerstein/Sonnhammer/Chothia ad hoc sequence weighting algorithm. (--wgsc)
	"wme", 	# Use the Krogh/Mitchison maximum entropy algorithm to 'weight' the sequences. (--wme)
	"wnone", 	# Turn off all sequence weighting. (--wnone)
	"wpb", 	# Use the Henikoff position-based weighting scheme (--wpb)
	"wvoronoi", 	# Use the Sibbald/Argos Voronoi sequence weighting algorithm in place of the default GSC weighting. (--wvoronoi)
	"counts_file",

    ];

    $self->{TYPE}  = {
	"hmmbuild" => 'String',
	"alignfile" => 'Sequence',
	"hmmfile" => 'OutFile',
	"hmmfile_res" => 'Results',
	"configure_options" => 'Paragraph',
	"multiple_local" => 'Switch',
	"single_global" => 'Switch',
	"single_local" => 'Switch',
	"output_options" => 'Paragraph',
	"name" => 'String',
	"re_save" => 'OutFile',
	"append" => 'InFile',
	"expert_options" => 'Paragraph',
	"amino" => 'Switch',
	"archpri" => 'Float',
	"binary" => 'Switch',
	"cfile" => 'Switch',
	"fast" => 'Switch',
	"gapmax" => 'Float',
	"hand" => 'Switch',
	"idlevel" => 'Float',
	"noeff" => 'Switch',
	"nucleic" => 'Switch',
	"null" => 'InFile',
	"pam" => 'InFile',
	"pamwgt" => 'Float',
	"pbswitch" => 'Integer',
	"prior" => 'InFile',
	"swentry" => 'Float',
	"swexit" => 'Float',
	"verbose" => 'Switch',
	"wblosum" => 'Switch',
	"wgsc" => 'Switch',
	"wme" => 'Switch',
	"wnone" => 'Switch',
	"wpb" => 'Switch',
	"wvoronoi" => 'Switch',
	"counts_file" => 'Results',

    };

    $self->{FORMAT}  = {
	"hmmbuild" => {
		"perl" => '"hmmbuild"',
	},
	"alignfile" => {
		"perl" => '" $value"',
	},
	"hmmfile" => {
		"perl" => '" $alignfile.hmm"',
	},
	"hmmfile_res" => {
	},
	"configure_options" => {
	},
	"multiple_local" => {
		"perl" => '($value) ? " -f" : ""',
	},
	"single_global" => {
		"perl" => '($value) ? " -g" : ""',
	},
	"single_local" => {
		"perl" => '($value) ? " -s" : ""',
	},
	"output_options" => {
	},
	"name" => {
		"perl" => '($value) ? " -n $value" : ""',
	},
	"re_save" => {
		"perl" => '($value)? " -o $value" : ""',
	},
	"append" => {
		"perl" => '($value) ? " -A $value" : ""',
	},
	"expert_options" => {
	},
	"amino" => {
		"perl" => '($value) ? " --amino" : ""',
	},
	"archpri" => {
		"perl" => '($value) ? " --archpri $value" : ""',
	},
	"binary" => {
		"perl" => '($value) ? " --binary" : ""',
	},
	"cfile" => {
		"perl" => '($value) ? " --cfile $alignfile.counts" : ""',
	},
	"fast" => {
		"perl" => '($value) ? " --fast" : ""',
	},
	"gapmax" => {
		"perl" => '($value) ? " --gapmax $value" : ""',
	},
	"hand" => {
		"perl" => '($value) ? " --hand" : ""',
	},
	"idlevel" => {
		"perl" => '($value) ? " --idlevel $value" : ""',
	},
	"noeff" => {
		"perl" => '($value) ? " --noeff" : ""',
	},
	"nucleic" => {
		"perl" => '($value) ? " --nucleic" : ""',
	},
	"null" => {
		"perl" => '($value) ? " --null $value" : ""',
	},
	"pam" => {
		"perl" => '($value) ? " --pam $value" : ""',
	},
	"pamwgt" => {
		"perl" => '($value)? " --pamwgt $value" : ""',
	},
	"pbswitch" => {
		"perl" => '($value) ? " --pbswitch $value" : ""',
	},
	"prior" => {
		"perl" => '($value) ? " --prior $value" : ""',
	},
	"swentry" => {
		"perl" => '($value) ? " --swentry $value" : ""',
	},
	"swexit" => {
		"perl" => '($value) ? " --swexit $value" : ""',
	},
	"verbose" => {
		"perl" => '($value) ? " --verbose" : ""',
	},
	"wblosum" => {
		"perl" => '($value) ? " --wblosum" : ""',
	},
	"wgsc" => {
		"perl" => '($value) ? " --wgsc" : ""',
	},
	"wme" => {
		"perl" => '($value) ? " --wme" : ""',
	},
	"wnone" => {
		"perl" => '($value) ? " --wnone" : ""',
	},
	"wpb" => {
		"perl" => '($value) ? " --wpb" : ""',
	},
	"wvoronoi" => {
		"perl" => '($value) ? " --wvoronoi" : ""',
	},
	"counts_file" => {
	},

    };

    $self->{FILENAMES}  = {
	"hmmfile_res" => '*.hmm',
	"counts_file" => '"$alignfile.counts"',

    };

    $self->{SEQFMT}  = {
	"alignfile" => [100,15],

    };

    $self->{GROUP}  = {
	"hmmbuild" => 0,
	"alignfile" => 3,
	"hmmfile" => 2,
	"configure_options" => 1,
	"multiple_local" => 1,
	"single_global" => 1,
	"single_local" => 1,
	"output_options" => 1,
	"name" => 1,
	"re_save" => 1,
	"append" => 1,
	"expert_options" => 1,
	"amino" => 1,
	"archpri" => 1,
	"binary" => 1,
	"cfile" => 1,
	"fast" => 1,
	"gapmax" => 1,
	"hand" => 1,
	"idlevel" => 1,
	"noeff" => 1,
	"nucleic" => 1,
	"null" => 1,
	"pam" => 1,
	"pamwgt" => 1,
	"pbswitch" => 1,
	"prior" => 1,
	"swentry" => 1,
	"swexit" => 1,
	"verbose" => 1,
	"wblosum" => 1,
	"wgsc" => 1,
	"wme" => 1,
	"wnone" => 1,
	"wpb" => 1,
	"wvoronoi" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"hmmbuild",
	"hmmfile_res",
	"counts_file",
	"wvoronoi",
	"configure_options",
	"multiple_local",
	"single_global",
	"single_local",
	"output_options",
	"name",
	"re_save",
	"append",
	"expert_options",
	"amino",
	"archpri",
	"binary",
	"cfile",
	"fast",
	"gapmax",
	"hand",
	"idlevel",
	"noeff",
	"nucleic",
	"null",
	"pam",
	"pamwgt",
	"pbswitch",
	"prior",
	"swentry",
	"swexit",
	"verbose",
	"wblosum",
	"wgsc",
	"wme",
	"wnone",
	"wpb",
	"hmmfile",
	"alignfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"hmmbuild" => 1,
	"alignfile" => 0,
	"hmmfile" => 1,
	"hmmfile_res" => 0,
	"configure_options" => 0,
	"multiple_local" => 0,
	"single_global" => 0,
	"single_local" => 0,
	"output_options" => 0,
	"name" => 0,
	"re_save" => 0,
	"append" => 0,
	"expert_options" => 0,
	"amino" => 0,
	"archpri" => 0,
	"binary" => 0,
	"cfile" => 0,
	"fast" => 0,
	"gapmax" => 0,
	"hand" => 0,
	"idlevel" => 0,
	"noeff" => 0,
	"nucleic" => 0,
	"null" => 0,
	"pam" => 0,
	"pamwgt" => 0,
	"pbswitch" => 0,
	"prior" => 0,
	"swentry" => 0,
	"swexit" => 0,
	"verbose" => 0,
	"wblosum" => 0,
	"wgsc" => 0,
	"wme" => 0,
	"wnone" => 0,
	"wpb" => 0,
	"wvoronoi" => 0,
	"counts_file" => 1,

    };

    $self->{ISCOMMAND}  = {
	"hmmbuild" => 1,
	"alignfile" => 0,
	"hmmfile" => 0,
	"hmmfile_res" => 0,
	"configure_options" => 0,
	"multiple_local" => 0,
	"single_global" => 0,
	"single_local" => 0,
	"output_options" => 0,
	"name" => 0,
	"re_save" => 0,
	"append" => 0,
	"expert_options" => 0,
	"amino" => 0,
	"archpri" => 0,
	"binary" => 0,
	"cfile" => 0,
	"fast" => 0,
	"gapmax" => 0,
	"hand" => 0,
	"idlevel" => 0,
	"noeff" => 0,
	"nucleic" => 0,
	"null" => 0,
	"pam" => 0,
	"pamwgt" => 0,
	"pbswitch" => 0,
	"prior" => 0,
	"swentry" => 0,
	"swexit" => 0,
	"verbose" => 0,
	"wblosum" => 0,
	"wgsc" => 0,
	"wme" => 0,
	"wnone" => 0,
	"wpb" => 0,
	"wvoronoi" => 0,
	"counts_file" => 0,

    };

    $self->{ISMANDATORY}  = {
	"hmmbuild" => 0,
	"alignfile" => 1,
	"hmmfile" => 0,
	"hmmfile_res" => 0,
	"configure_options" => 0,
	"multiple_local" => 0,
	"single_global" => 0,
	"single_local" => 0,
	"output_options" => 0,
	"name" => 0,
	"re_save" => 0,
	"append" => 0,
	"expert_options" => 0,
	"amino" => 0,
	"archpri" => 0,
	"binary" => 0,
	"cfile" => 0,
	"fast" => 0,
	"gapmax" => 0,
	"hand" => 0,
	"idlevel" => 0,
	"noeff" => 0,
	"nucleic" => 0,
	"null" => 0,
	"pam" => 0,
	"pamwgt" => 0,
	"pbswitch" => 0,
	"prior" => 0,
	"swentry" => 0,
	"swexit" => 0,
	"verbose" => 0,
	"wblosum" => 0,
	"wgsc" => 0,
	"wme" => 0,
	"wnone" => 0,
	"wpb" => 0,
	"wvoronoi" => 0,
	"counts_file" => 0,

    };

    $self->{PROMPT}  = {
	"hmmbuild" => "",
	"alignfile" => "Aligned sequences File",
	"hmmfile" => "",
	"hmmfile_res" => "",
	"configure_options" => "Configure options",
	"multiple_local" => "multiple local alignments (-f)",
	"single_global" => " single global alignment (-g)",
	"single_local" => "single local alignment (-s)",
	"output_options" => " Output options ",
	"name" => "name the HMM (-n 'name')",
	"re_save" => "Re-save the starting alignment to 'file', in SELEX format. (-o 'file')",
	"append" => "append the model to an existing HMMs file (-A)",
	"expert_options" => "Expert Options",
	"amino" => "Force the sequence alignment to be interpreted as amino acid sequences. (--amino)",
	"archpri" => "Set the 'architecture prior' to x (--archpri x)",
	"binary" => "Write the HMM to hmmfile in HMMER binary format instead of readable ASCII text. (--binary)",
	"cfile" => "Save the observed emission and transition counts to a file (--cfile f)",
	"fast" => "Quickly and heuristically determine the architecture of the model (--fast)",
	"gapmax" => "Controls the --fast model construction algorithm, (--gapmax x)",
	"hand" => "Specify the architecture of the model by hand (--hand)",
	"idlevel" => " (--idlevel x)",
	"noeff" => "Turn off the effective sequence number calculation (--noeff)",
	"nucleic" => "Force the alignment to be interpreted as nucleic acid sequence (--nucleic)",
	"null" => "null model (--null f)",
	"pam" => "heuristic PAM based prior (--pam f)",
	"pamwgt" => "Controls the weight on a PAM-based prior. (--pamwgt x)",
	"pbswitch" => "PB weights (--pbswitch n)",
	"prior" => "Dirichlet prior (--prior f)",
	"swentry" => "Controls the total probability that is distributed to local entries into the model (--swentry x)",
	"swexit" => "Controls the total probability that is distributed to local exits from the model (--swexit x)",
	"verbose" => "Print more possibly useful stuff, such as the individual scores for each sequence in the alignment. (--verbose)",
	"wblosum" => "Use the BLOSUM filtering algorithm to weight the sequences (--wblosum)",
	"wgsc" => "Use the Gerstein/Sonnhammer/Chothia ad hoc sequence weighting algorithm. (--wgsc)",
	"wme" => "Use the Krogh/Mitchison maximum entropy algorithm to 'weight' the sequences. (--wme)",
	"wnone" => "Turn off all sequence weighting. (--wnone)",
	"wpb" => "Use the Henikoff position-based weighting scheme (--wpb)",
	"wvoronoi" => "Use the Sibbald/Argos Voronoi sequence weighting algorithm in place of the default GSC weighting. (--wvoronoi)",
	"counts_file" => "",

    };

    $self->{ISSTANDOUT}  = {
	"hmmbuild" => 0,
	"alignfile" => 0,
	"hmmfile" => 0,
	"hmmfile_res" => 0,
	"configure_options" => 0,
	"multiple_local" => 0,
	"single_global" => 0,
	"single_local" => 0,
	"output_options" => 0,
	"name" => 0,
	"re_save" => 0,
	"append" => 0,
	"expert_options" => 0,
	"amino" => 0,
	"archpri" => 0,
	"binary" => 0,
	"cfile" => 0,
	"fast" => 0,
	"gapmax" => 0,
	"hand" => 0,
	"idlevel" => 0,
	"noeff" => 0,
	"nucleic" => 0,
	"null" => 0,
	"pam" => 0,
	"pamwgt" => 0,
	"pbswitch" => 0,
	"prior" => 0,
	"swentry" => 0,
	"swexit" => 0,
	"verbose" => 0,
	"wblosum" => 0,
	"wgsc" => 0,
	"wme" => 0,
	"wnone" => 0,
	"wpb" => 0,
	"wvoronoi" => 0,
	"counts_file" => 0,

    };

    $self->{VLIST}  = {

	"configure_options" => ['multiple_local','single_global','single_local',],
	"output_options" => ['name','re_save','append',],
	"expert_options" => ['amino','archpri','binary','cfile','fast','gapmax','hand','idlevel','noeff','nucleic','null','pam','pamwgt','pbswitch','prior','swentry','swexit','verbose','wblosum','wgsc','wme','wnone','wpb','wvoronoi',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"hmmfile" => '"$alignfile.hmm"',

    };

    $self->{PRECOND}  = {
	"hmmbuild" => { "perl" => '1' },
	"alignfile" => { "perl" => '1' },
	"hmmfile" => { "perl" => '1' },
	"hmmfile_res" => { "perl" => '1' },
	"configure_options" => { "perl" => '1' },
	"multiple_local" => { "perl" => '1' },
	"single_global" => { "perl" => '1' },
	"single_local" => { "perl" => '1' },
	"output_options" => { "perl" => '1' },
	"name" => { "perl" => '1' },
	"re_save" => { "perl" => '1' },
	"append" => { "perl" => '1' },
	"expert_options" => { "perl" => '1' },
	"amino" => { "perl" => '1' },
	"archpri" => { "perl" => '1' },
	"binary" => { "perl" => '1' },
	"cfile" => { "perl" => '1' },
	"fast" => { "perl" => '1' },
	"gapmax" => { "perl" => '1' },
	"hand" => { "perl" => '1' },
	"idlevel" => { "perl" => '1' },
	"noeff" => { "perl" => '1' },
	"nucleic" => { "perl" => '1' },
	"null" => { "perl" => '1' },
	"pam" => { "perl" => '1' },
	"pamwgt" => { "perl" => '1' },
	"pbswitch" => { "perl" => '1' },
	"prior" => { "perl" => '1' },
	"swentry" => { "perl" => '1' },
	"swexit" => { "perl" => '1' },
	"verbose" => { "perl" => '1' },
	"wblosum" => { "perl" => '1' },
	"wgsc" => { "perl" => '1' },
	"wme" => { "perl" => '1' },
	"wnone" => { "perl" => '1' },
	"wpb" => { "perl" => '1' },
	"wvoronoi" => { "perl" => '1' },
	"counts_file" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"hmmfile_res" => {
		 '1' => "hmmer_HMM",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"alignfile" => {
		 "hmmer_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"hmmbuild" => 0,
	"alignfile" => 0,
	"hmmfile" => 0,
	"hmmfile_res" => 0,
	"configure_options" => 0,
	"multiple_local" => 0,
	"single_global" => 0,
	"single_local" => 0,
	"output_options" => 0,
	"name" => 0,
	"re_save" => 0,
	"append" => 0,
	"expert_options" => 0,
	"amino" => 0,
	"archpri" => 0,
	"binary" => 0,
	"cfile" => 0,
	"fast" => 0,
	"gapmax" => 0,
	"hand" => 0,
	"idlevel" => 0,
	"noeff" => 0,
	"nucleic" => 0,
	"null" => 0,
	"pam" => 0,
	"pamwgt" => 0,
	"pbswitch" => 0,
	"prior" => 0,
	"swentry" => 0,
	"swexit" => 0,
	"verbose" => 0,
	"wblosum" => 0,
	"wgsc" => 0,
	"wme" => 0,
	"wnone" => 0,
	"wpb" => 0,
	"wvoronoi" => 0,
	"counts_file" => 0,

    };

    $self->{ISSIMPLE}  = {
	"hmmbuild" => 0,
	"alignfile" => 0,
	"hmmfile" => 0,
	"hmmfile_res" => 0,
	"configure_options" => 0,
	"multiple_local" => 0,
	"single_global" => 0,
	"single_local" => 0,
	"output_options" => 0,
	"name" => 0,
	"re_save" => 0,
	"append" => 0,
	"expert_options" => 0,
	"amino" => 0,
	"archpri" => 0,
	"binary" => 0,
	"cfile" => 0,
	"fast" => 0,
	"gapmax" => 0,
	"hand" => 0,
	"idlevel" => 0,
	"noeff" => 0,
	"nucleic" => 0,
	"null" => 0,
	"pam" => 0,
	"pamwgt" => 0,
	"pbswitch" => 0,
	"prior" => 0,
	"swentry" => 0,
	"swexit" => 0,
	"verbose" => 0,
	"wblosum" => 0,
	"wgsc" => 0,
	"wme" => 0,
	"wnone" => 0,
	"wpb" => 0,
	"wvoronoi" => 0,
	"counts_file" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"configure_options" => [
		" By default, the model is configured to find one or more nonoverlapping alignments to the complete model. This is analogous to the behavior of the hmmls program of HMMER 1. To configure the model for a single global alignment, use the -g option; to configure the model for multiple local alignments a la the old program hmmfs, use the -f option; and to configure the model for a single local alignment (a la standard Smith/Waterman, or the old hmmsw program), use the -s option. ",
	],
	"multiple_local" => [
		"Configure the model for finding multiple domains per sequence, where each domain can be a local (fragmentary) alignment. This is analogous to the old hmmfs program of HMMER 1.",
	],
	"single_global" => [
		"Configure the model for finding a single global alignment to a target sequence, analogous to the standard Needleman/Wunsch algorithm or the old hmms program of HMMER 1. ",
	],
	"single_local" => [
		"Configure the model for finding a single local alignment per target sequence. This is analogous to the standard Smith/Waterman algorithm or the hmmsw program of HMMER 1. ",
	],
	"name" => [
		"-n name. Name this HMM \'name\'. \'name\' can be any string of non-whitespace characters (e.g. one \'word\'). There is no length limit (at least not one imposed by HMMER; your shell will complain about command line lengths first).",
	],
	"re_save" => [
		"Re-save the starting alignment to \'file\', in SELEX format. The columns which were assigned to match states will be marked with x\'s in an #=RF annotation line. If either the --hand or -- construction options were chosen, the alignment may have been slightly altered to be compatible with Plan 7 transitions, so saving the final alignment and comparing to the starting alignment can let you view these alterations. See the User\'s Guide for more information on this arcane side effect. ",
	],
	"append" => [
		" Append this model to an existing hmmfile rather than creating hmmfile. Useful for building HMM libraries (like Pfam). (-A)",
	],
	"amino" => [
		" --amino . Force the sequence alignment to be interpreted as amino acid sequences. Normally HMMER autodetects whether the alignment is protein or DNA, but sometimes alignments are so small that autodetection is ambiguous. See --nucleic.",
	],
	"archpri" => [
		"Set the \'architecture prior\' used by MAP architecture construction to x, where x is a probability between 0 and 1. This parameter governs a geometric prior distribution over model lengths. As x increases, longer models are favored a priori. As x decreases, it takes more residue conservation in a column to make a column a \'consensus\' match column in the model architecture. The 0.85 default has been chosen empirically as a reasonable setting.",
	],
	"cfile" => [
		"Save the observed emission and transition counts to f after the architecture has been determined (e.g. after residues/gaps have been assigned to match, delete, and insert states). This option is used in HMMER development for generating data files useful for training new Dirichlet priors. The format of count files is documented in the User\'s Guide.",
	],
	"fast" => [
		"Quickly and heuristically determine the architecture of the model by assigning all columns with more than a certain fraction of gap characters to insert states. By default this fraction is 0.5, and it can be changed using the --gapmax option. The default construction algorithm is a maximum posteriori (MAP) algorithm, which is slower.",
	],
	"gapmax" => [
		"Controls the --fast model construction algorithm, but if --fast is not being used, has no effect. If a column has more than a fraction x of gap symbols in it, it gets assigned to an insert column. x is a frequency from 0 to 1, and by default is set to 0.5. Higher values of x mean more columns get assigned to consensus, and models get longer; smaller values of x mean fewer columns get assigned to consensus, and models get smaller.",
	],
	"hand" => [
		"Specify the architecture of the model by hand: the alignment file must be in SELEX format, and the #=RF annotation line is used to specify the architecture. Any column marked with a non-gap symbol (such as an `x\', for instance) is assigned as a consensus (match) column in the model.",
	],
	"idlevel" => [
		"Controls both the determination of effective sequence number and the behavior of the --wblosum weighting option. The sequence alignment is clustered by percent identity, and the number of clusters at a cutoff threshold of x is used to determine the effective sequence number. Higher values of x give more clusters and higher effective sequence numbers; lower values of x give fewer clusters and lower effective sequence numbers. x is a fraction from 0 to 1, and by default is set to 0.62 (corresponding to the clustering level used in constructing the BLOSUM62 substitution matrix).",
	],
	"noeff" => [
		"Turn off the effective sequence number calculation, and use the true number of sequences instead. This will usually reduce the sensitivity of the final model (so don\'t do it without good reason!)",
	],
	"nucleic" => [
		"Force the alignment to be interpreted as nucleic acid sequence, either RNA or DNA. Normally HMMER autodetects whether the alignment is protein or DNA, but sometimes alignments are so small that autodetection is ambiguous. See --amino.",
	],
	"null" => [
		"Read a null model from f. The default for protein is to use average amino acid frequencies from Swissprot 34 and p1 = 350/351; for nucleic acid, the default is to use 0.25 for each base and p1 = 1000/1001. For documentation of the format of the null model file and further explanation of how the null model is used, see the User\'s Guide.",
	],
	"pam" => [
		"Apply a heuristic PAM- (substitution matrix-) based prior instead of the default mixture Dirichlet. The substitution matrix is read from f. See --pamwgt.",
	],
	"pamwgt" => [
		"Controls the weight on a PAM-based prior. Only has effect if --pam option is also in use. x is a positive real number, 20.0 by default. x is the number of \'pseudocounts\' contributed by the heuristic prior. Very high values of x can force a scoring system that is entirely driven by the substitution matrix, making HMMER somewhat approximate Gribskov profiles.",
	],
	"pbswitch" => [
		"For alignments with a very large number of sequences, the GSC, BLOSUM, and Voronoi weighting schemes are slow; they\'re O(N^2) for N sequences. Henikoff position-based weights (PB weights) are more efficient. At or above a certain threshold sequence number n hmmbuild will switch from GSC, BLOSUM, or Voronoi weights to PB weights. To disable this switching behavior (at the cost of compute time, set n to be something larger than the number of sequences in your alignment.",
	],
	"prior" => [
		"Read a Dirichlet prior from f, replacing the default mixture Dirichlet. The format of prior files is documented in the User\'s Guide, and an example is given in the Demos directory of the HMMER distribution.",
	],
	"swentry" => [
		"Controls the total probability that is distributed to local entries into the model, versus starting at the beginning of the model as in a global alignment. x is a probability from 0 to 1, and by default is set to 0.5. Higher values of x mean that hits that are fragments on their left (N or 5\'-terminal) side will be penalized less, but complete global alignments will be penalized more. Lower values of x mean that fragments on the left will be penalized more, and global alignments on this side will be favored. This option only affects the configurations that allow local alignments, e.g. -s and -f; unless one of these options is also activated, this option has no effect. You have independent control over local/global alignment behavior for the N/C (5\'/3\') termini of your target sequences using --swentry and -swexit.",
	],
	"swexit" => [
		"Controls the total probability that is distributed to local exits from the model, versus ending an alignment at the end of the model as in a global alignment. x is a probability from 0 to 1, and by default is set to 0.5. Higher values of x mean that hits that are fragments on their right (C or 3\'-terminal) side will be penalized less, but complete global alignments will be penalized more. Lower values of x mean that fragments on the right will be penalized more, and global alignments on this side will be favored. This option only affects the configurations that allow local alignments, e.g. -s and -f; unless one of these options is also activated, this option has no effect. You have independent control over local/global alignment behavior for the N/C (5\'/3\') termini of your target sequences using --swentry and -swexit.",
	],
	"wblosum" => [
		"Use the BLOSUM filtering algorithm to weight the sequences, instead of the default. Cluster the sequences at a given percentage identity (see --idlevel); assign each cluster a total weight of 1.0, distributed equally amongst the members of that cluster.",
	],
	"wgsc" => [
		"Use the Gerstein/Sonnhammer/Chothia ad hoc sequence weighting algorithm. This is already the default, so this option has no effect (unless it follows another option in the --w family, in which case it overrides it).",
	],
	"wme" => [
		"Use the Krogh/Mitchison maximum entropy algorithm to \'weight\' the sequences. This supercedes the Eddy/Mitchison/Durbin maximum discrimination algorithm, which gives almost identical weights but is less robust. ME weighting seems to give a marginal increase in sensitivity over the default GSC weights, but takes a fair amount of time.",
	],

    };

    $self->{SCALEMIN}  = {

    };

    $self->{SCALEMAX}  = {

    };

    $self->{SCALEINC}  = {

    };

    $self->{INFO}  = {

    };

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/hmmbuild.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

