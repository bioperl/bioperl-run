
=head1 NAME

Bio::Tools::Run::PiseApplication::phiblast

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::phiblast

      Bioperl class for:

	BLAST2	phi-blast - Pattern-Hit Initiated BLAST (Altschul, Madden, Schaeffer, Zhang, Miller, Lipman)

	References:

		R. Baeza-Yates and G. Gonnet, Communications of the ACM 35(1992), pp. 74-82.

		 S. Wu and U. Manber, Communications of the ACM 35(1992), pp. 83-91.


      Parameters:


		phiblast (Excl)
			Program (-p)

		pattern_file (Results)
			

		nb_proc (Integer)
			

		query (Sequence)
			Sequence File (-i)
			pipe: seqfile

		start_region (Integer)
			Start of required region in query (-S)

		end_region (Integer)
			End of required region in query (-1 indicates end of query) (-H)

		pattern (String)
			Pattern - Prosite syntax (-k)

		protein_db (Excl)
			protein db (-d)

		filter_opt (Paragraph)
			Filtering and masking options

		filter (Switch)
			Filter query sequence with SEG (-F)

		selectivity_opt (Paragraph)
			Selectivity options

		Expect (Integer)
			Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (-e)

		window (Integer)
			Multiple hits window size (zero for single hit algorithm) (-A)

		extend_hit (Integer)
			Threshold for extending hits (-f)

		dropoff (Integer)
			X dropoff value for gapped alignment (in bits) (-X)

		dropoff_z (Integer)
			X dropoff value for final gapped alignment (in bits) (-Z)

		scoring (Paragraph)
			Scoring option

		matrix (Excl)
			Matrix (-M)

		open_a_gap (Integer)
			Cost to open a gap (-G)

		extend_a_gap (Integer)
			Cost to extend a gap (-E)

		affichage (Paragraph)
			Report options

		Descriptions (Integer)
			How many short descriptions? (-v)

		Alignments (Integer)
			How many alignments? (-b)

		view_alignments (Excl)
			Alignment view options  (not with blastx/tblastx) (-m)

		html_output (String)
			Html output

		seqalign_file (OutFile)
			SeqAlign file (-J option must be true) (-O)

		believe (Switch)
			Believe the query defline (-J)

		html_file (Results)
			

		txtoutput (String)
			

		txt_file (Results)
			
			pipe: blast_output

=cut

#'
package Bio::Tools::Run::PiseApplication::phiblast;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $phiblast = Bio::Tools::Run::PiseApplication::phiblast->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::phiblast object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $phiblast = $factory->program('phiblast');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::phiblast.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/phiblast.pm

    $self->{COMMAND}   = "phiblast";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "BLAST2";

    $self->{DESCRIPTION}   = "phi-blast - Pattern-Hit Initiated BLAST";

    $self->{AUTHORS}   = "Altschul, Madden, Schaeffer, Zhang, Miller, Lipman";

    $self->{REFERENCE}   = [

         "R. Baeza-Yates and G. Gonnet, Communications of the ACM 35(1992), pp. 74-82.",

         " S. Wu and U. Manber, Communications of the ACM 35(1992), pp. 83-91.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"phiblast",
	"pattern_file",
	"nb_proc",
	"query",
	"start_region",
	"end_region",
	"pattern",
	"protein_db",
	"filter_opt",
	"selectivity_opt",
	"scoring",
	"affichage",
	"html_file",
	"txtoutput",
	"txt_file",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"phiblast", 	# Program (-p)
	"pattern_file",
	"nb_proc",
	"query", 	# Sequence File (-i)
	"start_region", 	# Start of required region in query (-S)
	"end_region", 	# End of required region in query (-1 indicates end of query) (-H)
	"pattern", 	# Pattern - Prosite syntax (-k)
	"protein_db", 	# protein db (-d)
	"filter_opt", 	# Filtering and masking options
	"filter", 	# Filter query sequence with SEG (-F)
	"selectivity_opt", 	# Selectivity options
	"Expect", 	# Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (-e)
	"window", 	# Multiple hits window size (zero for single hit algorithm) (-A)
	"extend_hit", 	# Threshold for extending hits (-f)
	"dropoff", 	# X dropoff value for gapped alignment (in bits) (-X)
	"dropoff_z", 	# X dropoff value for final gapped alignment (in bits) (-Z)
	"scoring", 	# Scoring option
	"matrix", 	# Matrix (-M)
	"open_a_gap", 	# Cost to open a gap (-G)
	"extend_a_gap", 	# Cost to extend a gap (-E)
	"affichage", 	# Report options
	"Descriptions", 	# How many short descriptions? (-v)
	"Alignments", 	# How many alignments? (-b)
	"view_alignments", 	# Alignment view options  (not with blastx/tblastx) (-m)
	"html_output", 	# Html output
	"seqalign_file", 	# SeqAlign file (-J option must be true) (-O)
	"believe", 	# Believe the query defline (-J)
	"html_file",
	"txtoutput",
	"txt_file",

    ];

    $self->{TYPE}  = {
	"phiblast" => 'Excl',
	"pattern_file" => 'Results',
	"nb_proc" => 'Integer',
	"query" => 'Sequence',
	"start_region" => 'Integer',
	"end_region" => 'Integer',
	"pattern" => 'String',
	"protein_db" => 'Excl',
	"filter_opt" => 'Paragraph',
	"filter" => 'Switch',
	"selectivity_opt" => 'Paragraph',
	"Expect" => 'Integer',
	"window" => 'Integer',
	"extend_hit" => 'Integer',
	"dropoff" => 'Integer',
	"dropoff_z" => 'Integer',
	"scoring" => 'Paragraph',
	"matrix" => 'Excl',
	"open_a_gap" => 'Integer',
	"extend_a_gap" => 'Integer',
	"affichage" => 'Paragraph',
	"Descriptions" => 'Integer',
	"Alignments" => 'Integer',
	"view_alignments" => 'Excl',
	"html_output" => 'String',
	"seqalign_file" => 'OutFile',
	"believe" => 'Switch',
	"html_file" => 'Results',
	"txtoutput" => 'String',
	"txt_file" => 'Results',

    };

    $self->{FORMAT}  = {
	"phiblast" => {
		"perl" => '"blastpgp -p $value -k pattern.dat"',
	},
	"pattern_file" => {
	},
	"nb_proc" => {
		"perl" => '" -a 2"',
	},
	"query" => {
		"perl" => '" -i $query" ',
	},
	"start_region" => {
		"perl" => '(defined $value && $value != $vdef)? " -S $value" : ""',
	},
	"end_region" => {
		"perl" => '(defined $value && $value != $vdef)? " -H $value" : ""',
	},
	"pattern" => {
		"perl" => '"ID  PATTERN\\nPA  $value\\n//\\n" ',
	},
	"protein_db" => {
		"perl" => ' " -d $value" ',
	},
	"filter_opt" => {
	},
	"filter" => {
		"perl" => '($value) ? " -F T" : ""',
	},
	"selectivity_opt" => {
	},
	"Expect" => {
		"perl" => '(defined $value && $value != $vdef)? " -e $value":""',
	},
	"window" => {
		"perl" => '(defined $value && $value != $vdef)? " -A $value" : ""',
	},
	"extend_hit" => {
		"perl" => '($value)? " -f $value" : ""',
	},
	"dropoff" => {
		"perl" => '(defined $value)? " -X $value":""',
	},
	"dropoff_z" => {
		"perl" => '(defined $value && $value != $vdef)? " -Z $value" : ""',
	},
	"scoring" => {
	},
	"matrix" => {
		"perl" => '($value && $value ne $vdef)? " -M $value" : ""',
	},
	"open_a_gap" => {
		"perl" => '(defined $value && $value != $vdef)? " -G $value":""',
	},
	"extend_a_gap" => {
		"perl" => '(defined $value && $value != $vdef)? " -E $value":""',
	},
	"affichage" => {
	},
	"Descriptions" => {
		"perl" => '(defined $value && $value != $vdef)? " -v $value":""',
	},
	"Alignments" => {
		"perl" => '(defined $value && $value != $vdef)? " -b $value":""',
	},
	"view_alignments" => {
		"perl" => '($value)? " -m $value" : "" ',
	},
	"html_output" => {
		"perl" => ' " && html4blast -o phiblast.html -s -g phiblast.txt" ',
	},
	"seqalign_file" => {
		"perl" => '($value)? " -O $value" : ""',
	},
	"believe" => {
		"perl" => '($value)? " -J":""',
	},
	"html_file" => {
	},
	"txtoutput" => {
		"perl" => '" > phiblast.txt"',
	},
	"txt_file" => {
	},

    };

    $self->{FILENAMES}  = {
	"pattern_file" => 'pattern.dat',
	"html_file" => 'phiblast.html',
	"txt_file" => 'phiblast.txt',

    };

    $self->{SEQFMT}  = {
	"query" => [8],

    };

    $self->{GROUP}  = {
	"phiblast" => 1,
	"nb_proc" => 6,
	"query" => 3,
	"start_region" => 5,
	"end_region" => 5,
	"pattern" => 3,
	"protein_db" => 2,
	"filter_opt" => 4,
	"filter" => 4,
	"selectivity_opt" => 5,
	"Expect" => 5,
	"window" => 5,
	"extend_hit" => 5,
	"dropoff" => 5,
	"dropoff_z" => 5,
	"scoring" => 4,
	"matrix" => 5,
	"open_a_gap" => 4,
	"extend_a_gap" => 5,
	"Descriptions" => 5,
	"Alignments" => 5,
	"view_alignments" => 4,
	"html_output" => 20,
	"seqalign_file" => 4,
	"believe" => 4,
	"txtoutput" => 19,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"pattern_file",
	"txt_file",
	"html_file",
	"affichage",
	"phiblast",
	"protein_db",
	"query",
	"pattern",
	"open_a_gap",
	"filter",
	"view_alignments",
	"seqalign_file",
	"believe",
	"filter_opt",
	"scoring",
	"dropoff_z",
	"matrix",
	"start_region",
	"extend_a_gap",
	"end_region",
	"Descriptions",
	"Alignments",
	"selectivity_opt",
	"Expect",
	"window",
	"extend_hit",
	"dropoff",
	"nb_proc",
	"txtoutput",
	"html_output",

    ];

    $self->{SIZE}  = {
	"pattern" => 80,

    };

    $self->{ISHIDDEN}  = {
	"phiblast" => 0,
	"pattern_file" => 0,
	"nb_proc" => 1,
	"query" => 0,
	"start_region" => 0,
	"end_region" => 0,
	"pattern" => 0,
	"protein_db" => 0,
	"filter_opt" => 0,
	"filter" => 0,
	"selectivity_opt" => 0,
	"Expect" => 0,
	"window" => 0,
	"extend_hit" => 0,
	"dropoff" => 0,
	"dropoff_z" => 0,
	"scoring" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"html_output" => 1,
	"seqalign_file" => 0,
	"believe" => 0,
	"html_file" => 0,
	"txtoutput" => 1,
	"txt_file" => 0,

    };

    $self->{ISCOMMAND}  = {
	"phiblast" => 1,
	"pattern_file" => 0,
	"nb_proc" => 0,
	"query" => 0,
	"start_region" => 0,
	"end_region" => 0,
	"pattern" => 0,
	"protein_db" => 0,
	"filter_opt" => 0,
	"filter" => 0,
	"selectivity_opt" => 0,
	"Expect" => 0,
	"window" => 0,
	"extend_hit" => 0,
	"dropoff" => 0,
	"dropoff_z" => 0,
	"scoring" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"html_output" => 0,
	"seqalign_file" => 0,
	"believe" => 0,
	"html_file" => 0,
	"txtoutput" => 0,
	"txt_file" => 0,

    };

    $self->{ISMANDATORY}  = {
	"phiblast" => 1,
	"pattern_file" => 0,
	"nb_proc" => 0,
	"query" => 1,
	"start_region" => 0,
	"end_region" => 0,
	"pattern" => 1,
	"protein_db" => 1,
	"filter_opt" => 0,
	"filter" => 0,
	"selectivity_opt" => 0,
	"Expect" => 0,
	"window" => 0,
	"extend_hit" => 0,
	"dropoff" => 0,
	"dropoff_z" => 0,
	"scoring" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"html_output" => 0,
	"seqalign_file" => 0,
	"believe" => 0,
	"html_file" => 0,
	"txtoutput" => 0,
	"txt_file" => 0,

    };

    $self->{PROMPT}  = {
	"phiblast" => "Program (-p)",
	"pattern_file" => "",
	"nb_proc" => "",
	"query" => "Sequence File (-i)",
	"start_region" => "Start of required region in query (-S)",
	"end_region" => "End of required region in query (-1 indicates end of query) (-H)",
	"pattern" => "Pattern - Prosite syntax (-k)",
	"protein_db" => "protein db (-d)",
	"filter_opt" => "Filtering and masking options",
	"filter" => "Filter query sequence with SEG (-F)",
	"selectivity_opt" => "Selectivity options",
	"Expect" => "Expect: upper bound on the expected frequency of chance occurrence of a set of HSPs (-e)",
	"window" => "Multiple hits window size (zero for single hit algorithm) (-A)",
	"extend_hit" => "Threshold for extending hits (-f)",
	"dropoff" => "X dropoff value for gapped alignment (in bits) (-X)",
	"dropoff_z" => "X dropoff value for final gapped alignment (in bits) (-Z)",
	"scoring" => "Scoring option",
	"matrix" => "Matrix (-M)",
	"open_a_gap" => "Cost to open a gap (-G)",
	"extend_a_gap" => "Cost to extend a gap (-E)",
	"affichage" => "Report options",
	"Descriptions" => "How many short descriptions? (-v)",
	"Alignments" => "How many alignments? (-b)",
	"view_alignments" => "Alignment view options  (not with blastx/tblastx) (-m)",
	"html_output" => "Html output",
	"seqalign_file" => "SeqAlign file (-J option must be true) (-O)",
	"believe" => "Believe the query defline (-J)",
	"html_file" => "",
	"txtoutput" => "",
	"txt_file" => "",

    };

    $self->{ISSTANDOUT}  = {
	"phiblast" => 0,
	"pattern_file" => 0,
	"nb_proc" => 0,
	"query" => 0,
	"start_region" => 0,
	"end_region" => 0,
	"pattern" => 0,
	"protein_db" => 0,
	"filter_opt" => 0,
	"filter" => 0,
	"selectivity_opt" => 0,
	"Expect" => 0,
	"window" => 0,
	"extend_hit" => 0,
	"dropoff" => 0,
	"dropoff_z" => 0,
	"scoring" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"html_output" => 0,
	"seqalign_file" => 0,
	"believe" => 0,
	"html_file" => 0,
	"txtoutput" => 0,
	"txt_file" => 0,

    };

    $self->{VLIST}  = {

	"phiblast" => ['patseedp','patseedp: normal phiblast mode','seedp','seedp: restrict to a subset of pattern occurences',],
	"protein_db" => ['sptrnrdb','sptrnrdb: non-redundant SWISS-PROT + TrEMBL','swissprot','swissprot (last release + updates)','sprel','swissprot release','swissprot_new','swissprot_new: updates','pir','pir: Protein Information Resource','nrprot','nrprot: NCBI non-redundant Genbank CDS translations+PDB+Swissprot+PIR','nrprot_month','nrprot_month: NCBI month non-redundant Genbank CDS translations+PDB+Swissprot+PIR','genpept','genpept: Genbank translations (last rel. + upd.)','genpept_new','genpept_new: genpept updates','gpbct','gpbct: genpept bacteries','gppri','gppri: primates','gpmam','gpmam: other mammals','gprod','gprod: rodents','gpvrt','gpvrt: other vertebrates','gpinv','gpinv: invertebrates','gppln','gppln: plants (including yeast)','gpvrl','gpvrl: virus','gpphg','gpphg: phages','gpsts','gpsts: STS','gpsyn','gpsyn: synthetic','gppat','gppat: patented','gpuna','gpuna: unatotated','gphtg','gphtg: GS (high throughput Genomic Sequencing)','nrl3d','nrl3d: sequences from PDB','prodom','prodom: protein domains','sbase','sbase: annotated domains sequences',],
	"filter_opt" => ['filter',],
	"selectivity_opt" => ['Expect','window','extend_hit','dropoff','dropoff_z',],
	"scoring" => ['matrix','open_a_gap','extend_a_gap',],
	"matrix" => ['PAM30','PAM30','PAM70','PAM70','BLOSUM80','BLOSUM80','BLOSUM62','BLOSUM62','BLOSUM45','BLOSUM45',],
	"affichage" => ['Descriptions','Alignments','view_alignments','html_output','seqalign_file','believe',],
	"view_alignments" => ['0','0: pairwise','1','1: master-slave showing identities','2','2: master-slave no identities','3','3: flat master-slave, show identities','4','4: flat master-slave, no identities','5','5: query-anchored no identities and blunt ends','6','6: flat query-anchored, no identities and blunt ends','7','7: XML Blast output','8','8: Tabular output',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"start_region" => '1',
	"end_region" => '-1',
	"protein_db" => 'sptrnrdb',
	"filter" => '0',
	"Expect" => '10',
	"window" => '40',
	"extend_hit" => '0',
	"dropoff_z" => '25',
	"matrix" => 'BLOSUM62',
	"open_a_gap" => '11',
	"extend_a_gap" => '1',
	"Descriptions" => '500',
	"Alignments" => '250',
	"view_alignments" => '0',
	"html_output" => '1',
	"believe" => '0',

    };

    $self->{PRECOND}  = {
	"phiblast" => { "perl" => '1' },
	"pattern_file" => { "perl" => '1' },
	"nb_proc" => { "perl" => '1' },
	"query" => { "perl" => '1' },
	"start_region" => { "perl" => '1' },
	"end_region" => { "perl" => '1' },
	"pattern" => { "perl" => '1' },
	"protein_db" => { "perl" => '1' },
	"filter_opt" => { "perl" => '1' },
	"filter" => { "perl" => '1' },
	"selectivity_opt" => { "perl" => '1' },
	"Expect" => { "perl" => '1' },
	"window" => { "perl" => '1' },
	"extend_hit" => { "perl" => '1' },
	"dropoff" => { "perl" => '1' },
	"dropoff_z" => { "perl" => '1' },
	"scoring" => { "perl" => '1' },
	"matrix" => { "perl" => '1' },
	"open_a_gap" => { "perl" => '1' },
	"extend_a_gap" => { "perl" => '1' },
	"affichage" => { "perl" => '1' },
	"Descriptions" => { "perl" => '1' },
	"Alignments" => { "perl" => '1' },
	"view_alignments" => { "perl" => '1' },
	"html_output" => {
		"perl" => 'not $view_alignments',
	},
	"seqalign_file" => {
		"perl" => '$believe',
	},
	"believe" => { "perl" => '1' },
	"html_file" => { "perl" => '1' },
	"txtoutput" => { "perl" => '1' },
	"txt_file" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"txt_file" => {
		 '1' => "blast_output",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"query" => {
		 "seqfile" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"phiblast" => 0,
	"pattern_file" => 0,
	"nb_proc" => 0,
	"query" => 0,
	"start_region" => 0,
	"end_region" => 0,
	"pattern" => 0,
	"protein_db" => 0,
	"filter_opt" => 0,
	"filter" => 0,
	"selectivity_opt" => 0,
	"Expect" => 0,
	"window" => 0,
	"extend_hit" => 0,
	"dropoff" => 0,
	"dropoff_z" => 0,
	"scoring" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"html_output" => 0,
	"seqalign_file" => 0,
	"believe" => 0,
	"html_file" => 0,
	"txtoutput" => 0,
	"txt_file" => 0,

    };

    $self->{ISSIMPLE}  = {
	"phiblast" => 0,
	"pattern_file" => 0,
	"nb_proc" => 0,
	"query" => 1,
	"start_region" => 0,
	"end_region" => 0,
	"pattern" => 1,
	"protein_db" => 1,
	"filter_opt" => 0,
	"filter" => 0,
	"selectivity_opt" => 0,
	"Expect" => 1,
	"window" => 0,
	"extend_hit" => 0,
	"dropoff" => 0,
	"dropoff_z" => 0,
	"scoring" => 0,
	"matrix" => 0,
	"open_a_gap" => 0,
	"extend_a_gap" => 0,
	"affichage" => 0,
	"Descriptions" => 0,
	"Alignments" => 0,
	"view_alignments" => 0,
	"html_output" => 0,
	"seqalign_file" => 0,
	"believe" => 0,
	"html_file" => 0,
	"txtoutput" => 0,
	"txt_file" => 0,

    };

    $self->{PARAMFILE}  = {
	"pattern" => "pattern.dat",

    };

    $self->{COMMENT}  = {
	"phiblast" => [
		"PHI-BLAST (Pattern-Hit Initiated BLAST) is a search program that combines matching of regular expressions with local alignments surrounding the match. The calculation of local alignments is done using a method very similar to (and much of the same code as) gapped BLAST.",
		"Program modes:",
		". patseedp: normal phiblast mode",
		". seedp: Restrict the search for local alignments to a subset of the pattern occurrences in the query. This program option requires the user to specify the location(s) of the interesting pattern occurrence(s) in the pattern file (for the syntax see below). When there are multiple pattern occurrences in the query it may be important to decide how many are of interest because the E-value for matches is effectively multiplied by the number of interesting pattern occurrences.",
	],
	"pattern" => [
		"Given a protein sequence S and a regular expression pattern P occurring in S, PHI-BLAST helps answer the question: What other protein sequences both contain an occurrence of P and are homologous to S in the vicinity of the pattern occurrences?",
		"Rules for pattern syntax:",
		"The syntax for patterns in PHI-BLAST follows the conventions of PROSITE. When using the stand-alone program, it is permissible to have multiple patterns in a file separated by a blank line between patterns. ",
		"Valid protein characters for PHI-BLAST patterns:",
		"ABCDEFGHIKLMNPQRSTVWXYZU",
		"Other useful delimiters:",
		"[ ] means any one of the characters enclosed in the brackets e.g., [LFYT] means one occurrence of L or F or Y or T",
		" - means nothing (this is a spacer character used by PROSITE) x with nothing following means any residue",
		"x(5) means 5 positions in which any residue is allowed (and similarly for any other single number in parentheses after x)",
		"x(2,4) means 2 to 4 positions where any residue is allowed, and similarly for any other two numbers separated by a comma; the first number should be < the second number.",
		"Example:",
		"PA [LIVM]-x-D-x(2)-[GA]-[NQS]-K-G-T-G-x-W",
	],
	"filter_opt" => [
		"This options also takes a string as an argument.  One may use such a string to change the specific parameters of seg or invoke other filters. Please see the \'Filtering Strings\' section (below) for details.",
	],
	"Expect" => [
		"The statistical significance threshold for reporting matches against database sequences; the default value is 10, such that 10 matches are expected to be found merely by chance, according to the stochastic model of Karlin and Altschul (1990). If the statistical significance ascribed to a match is greater than the EXPECT threshold, the match will not be reported. Lower EXPECT thresholds are more stringent, leading to fewer chance matches being reported. Fractional values are acceptable. ",
	],
	"window" => [
		"When multiple hits method is used, this		parameter defines the distance from last hit on the		same diagonal to the new one.",
		"Zero means single hit algorithm.",
	],
	"extend_hit" => [
		"Blast seeks first short word pairs whose aligned score reaches at least this value (default for blastp is 11) (T in the NAR paper and in Blast 1.4)",
	],
	"dropoff" => [
		"This is the value that control the path graph region explored by Blast during a gapped extension (Xg in the NAR paper) (default for blastp is 15).",
	],
	"dropoff_z" => [
		"This parameter controls the dropoff for the final reported alignment. See also the -X parameter.",
	],
	"extend_a_gap" => [
		"Limited values for gap existence and extension are supported for these three programs. Some supported and suggested values are:",
		"Existence Extension",
		"10 1",
		"10 2",
		"11 1",
		"8 2",
		"9 2",
		"(source: NCBI Blast page)",
	],
	"Descriptions" => [
		"Maximum number of database sequences for which one-line descriptions will be reported (-v).",
	],
	"Alignments" => [
		"Maximum number of database sequences for which high-scoring segment pairs will be reported (-b).",
	],
	"seqalign_file" => [
		"SeqAlign is in ASN.1 format, so that it can be read with NCBI tools (such as sequin). This allows one to view the results in different formats.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/phiblast.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

