
=head1 NAME

Bio::Tools::Run::PiseApplication::gibbs_scan

=head1 SYNOPSIS

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::gibbs_scan

      Bioperl class for:

	GIBBS	scan a database with a sampled motif (Neuwald, Lawrence)

      Parameters:


		gibbs_scan (String)
			

		motif_file (InFile)
			Motif scan file (file.sn)
			pipe: gibbs_motif

		db (Excl)
			Database

		control_options (Paragraph)
			Control options

		e_value (Float)
			Maximum E-value detected (-e)

		p_value (Float)
			Minimum -log10(P-value) required for each motif (-E)

		repeats (Switch)
			Scan for repeats (-r)

		max_repeats (Integer)
			Maximum number of repeats per sequence (-M)

		min_repeats (Integer)
			Minimum number of repeats per sequence (-m)

		order (Switch)
			Require motifs to be in correct order (-o)

		product (Switch)
			Use product multinomial model instead of Gribskov method (-P)

		pseudo_count (Integer)
			Pseudo counts for product multinomial model (-p)

		shuffle (Switch)
			Shuffle input sequences (-S)

		seed (Integer)
			Seed for random number generator (-s)

		mask (Excl)
			Mask out sequence regions...

		heap (Integer)
			Size of heap for saving sequences (-h)

		output_options (Paragraph)
			Output options

		seqfile (Switch)
			Create sequence file for output (-c)

=cut

#'
package Bio::Tools::Run::PiseApplication::gibbs_scan;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $gibbs_scan = Bio::Tools::Run::PiseApplication::gibbs_scan->new($remote, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::gibbs_scan object.
           This method should not be used directly, but rather by 
           a Bio::Factory::Pise instance:
           my $factory = Bio::Factory::Pise->new(-email => 'me@myhome');
           my $gibbs_scan = $factory->program('gibbs_scan');
 Example :
 Returns : An instance of Bio::Tools::Run::PiseApplication::gibbs_scan.

=cut

sub new {
    my ($class, $remote, $email, @params) = @_;
    my $self = $class->SUPER::new($remote, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/gibbs_scan.pm

    $self->{COMMAND}   = "gibbs_scan";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "GIBBS";

    $self->{DESCRIPTION}   = "scan a database with a sampled motif";

    $self->{AUTHORS}   = "Neuwald, Lawrence";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"gibbs_scan",
	"motif_file",
	"db",
	"control_options",
	"output_options",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"gibbs_scan",
	"motif_file", 	# Motif scan file (file.sn)
	"db", 	# Database
	"control_options", 	# Control options
	"e_value", 	# Maximum E-value detected (-e)
	"p_value", 	# Minimum -log10(P-value) required for each motif (-E)
	"repeats", 	# Scan for repeats (-r)
	"max_repeats", 	# Maximum number of repeats per sequence (-M)
	"min_repeats", 	# Minimum number of repeats per sequence (-m)
	"order", 	# Require motifs to be in correct order (-o)
	"product", 	# Use product multinomial model instead of Gribskov method (-P)
	"pseudo_count", 	# Pseudo counts for product multinomial model (-p)
	"shuffle", 	# Shuffle input sequences (-S)
	"seed", 	# Seed for random number generator (-s)
	"mask", 	# Mask out sequence regions...
	"heap", 	# Size of heap for saving sequences (-h)
	"output_options", 	# Output options
	"seqfile", 	# Create sequence file for output (-c)

    ];

    $self->{TYPE}  = {
	"gibbs_scan" => 'String',
	"motif_file" => 'InFile',
	"db" => 'Excl',
	"control_options" => 'Paragraph',
	"e_value" => 'Float',
	"p_value" => 'Float',
	"repeats" => 'Switch',
	"max_repeats" => 'Integer',
	"min_repeats" => 'Integer',
	"order" => 'Switch',
	"product" => 'Switch',
	"pseudo_count" => 'Integer',
	"shuffle" => 'Switch',
	"seed" => 'Integer',
	"mask" => 'Excl',
	"heap" => 'Integer',
	"output_options" => 'Paragraph',
	"seqfile" => 'Switch',

    };

    $self->{FORMAT}  = {
	"gibbs_scan" => {
		"perl" => '"/local/gensoft/bin/scan "',
	},
	"motif_file" => {
		"perl" => '" $value"',
	},
	"db" => {
		"perl" => ' " /local/gensoft/lib/gibbs/db/$value" ',
	},
	"control_options" => {
	},
	"e_value" => {
		"perl" => '(defined $value)? " -e$value" : ""',
	},
	"p_value" => {
		"perl" => '(defined $value)? " -E$value" : ""',
	},
	"repeats" => {
		"perl" => '($value)? " -r" : ""',
	},
	"max_repeats" => {
		"perl" => '(defined $value)? " -M$value" : ""',
	},
	"min_repeats" => {
		"perl" => '(defined $value)? " -m$value" : ""',
	},
	"order" => {
		"perl" => '($value)? " -o" : ""',
	},
	"product" => {
		"perl" => '($value)? " -P" : ""',
	},
	"pseudo_count" => {
		"perl" => '(defined $value)? " -p$value" : ""',
	},
	"shuffle" => {
		"perl" => '($value)? " -S" : ""',
	},
	"seed" => {
		"perl" => '(defined $value)? " -s$value" : ""',
	},
	"mask" => {
		"perl" => '($value)? " $value" : ""',
	},
	"heap" => {
		"perl" => '(defined $value)? " -h$value" : ""',
	},
	"output_options" => {
	},
	"seqfile" => {
		"perl" => '($value)? " -c" : "" ',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"gibbs_scan" => 0,
	"motif_file" => 2,
	"db" => 1,
	"control_options" => 4,
	"e_value" => 4,
	"p_value" => 4,
	"repeats" => 4,
	"max_repeats" => 4,
	"min_repeats" => 4,
	"order" => 4,
	"product" => 4,
	"pseudo_count" => 4,
	"shuffle" => 4,
	"seed" => 4,
	"mask" => 4,
	"heap" => 4,
	"output_options" => 4,
	"seqfile" => 4,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"gibbs_scan",
	"db",
	"motif_file",
	"control_options",
	"e_value",
	"p_value",
	"repeats",
	"max_repeats",
	"min_repeats",
	"order",
	"product",
	"pseudo_count",
	"shuffle",
	"seed",
	"mask",
	"heap",
	"output_options",
	"seqfile",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"gibbs_scan" => 1,
	"motif_file" => 0,
	"db" => 0,
	"control_options" => 0,
	"e_value" => 0,
	"p_value" => 0,
	"repeats" => 0,
	"max_repeats" => 0,
	"min_repeats" => 0,
	"order" => 0,
	"product" => 0,
	"pseudo_count" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"mask" => 0,
	"heap" => 0,
	"output_options" => 0,
	"seqfile" => 0,

    };

    $self->{ISCOMMAND}  = {
	"gibbs_scan" => 1,
	"motif_file" => 0,
	"db" => 0,
	"control_options" => 0,
	"e_value" => 0,
	"p_value" => 0,
	"repeats" => 0,
	"max_repeats" => 0,
	"min_repeats" => 0,
	"order" => 0,
	"product" => 0,
	"pseudo_count" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"mask" => 0,
	"heap" => 0,
	"output_options" => 0,
	"seqfile" => 0,

    };

    $self->{ISMANDATORY}  = {
	"gibbs_scan" => 0,
	"motif_file" => 1,
	"db" => 1,
	"control_options" => 0,
	"e_value" => 0,
	"p_value" => 0,
	"repeats" => 0,
	"max_repeats" => 0,
	"min_repeats" => 0,
	"order" => 0,
	"product" => 0,
	"pseudo_count" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"mask" => 0,
	"heap" => 0,
	"output_options" => 0,
	"seqfile" => 0,

    };

    $self->{PROMPT}  = {
	"gibbs_scan" => "",
	"motif_file" => "Motif scan file (file.sn)",
	"db" => "Database",
	"control_options" => "Control options",
	"e_value" => "Maximum E-value detected (-e)",
	"p_value" => "Minimum -log10(P-value) required for each motif (-E)",
	"repeats" => "Scan for repeats (-r)",
	"max_repeats" => "Maximum number of repeats per sequence (-M)",
	"min_repeats" => "Minimum number of repeats per sequence (-m)",
	"order" => "Require motifs to be in correct order (-o)",
	"product" => "Use product multinomial model instead of Gribskov method (-P)",
	"pseudo_count" => "Pseudo counts for product multinomial model (-p)",
	"shuffle" => "Shuffle input sequences (-S)",
	"seed" => "Seed for random number generator (-s)",
	"mask" => "Mask out sequence regions...",
	"heap" => "Size of heap for saving sequences (-h)",
	"output_options" => "Output options",
	"seqfile" => "Create sequence file for output (-c)",

    };

    $self->{ISSTANDOUT}  = {
	"gibbs_scan" => 0,
	"motif_file" => 0,
	"db" => 0,
	"control_options" => 0,
	"e_value" => 0,
	"p_value" => 0,
	"repeats" => 0,
	"max_repeats" => 0,
	"min_repeats" => 0,
	"order" => 0,
	"product" => 0,
	"pseudo_count" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"mask" => 0,
	"heap" => 0,
	"output_options" => 0,
	"seqfile" => 0,

    };

    $self->{VLIST}  = {

	"db" => ['sptrnrdb','sptrnrdb: non-redundant SWISS-PROT + TrEMBL','swissprot','swissprot (last release + updates)','sprel','swissprot release','swissprot_new','swissprot_new: updates','pir','pir: Protein Information Resource','nrprot','nrprot: NCBI non-redundant Genbank CDS translations+PDB+Swissprot+PIR','nrprot_month','nrprot_month: NCBI month non-redundant Genbank CDS translations+PDB+Swissprot+PIR','genpept','genpept: Genbank translations (last rel. + upd.)','genpept_new','genpept_new: genpept updates','gpbct','gpbct: genpept bacteries','gppri','gppri: primates','gpmam','gpmam: other mammals','gprod','gprod: rodents','gpvrt','gpvrt: other vertebrates','gpinv','gpinv: invertebrates','gppln','gppln: plants (including yeast)','gpvrl','gpvrl: virus','gpphg','gpphg: phages','gpsts','gpsts: STS','gpsyn','gpsyn: synthetic','gppat','gppat: patented','gpuna','gpuna: unatotated','gphtg','gphtg: GS (high throughput Genomic Sequencing)','nrl3d','nrl3d: sequences from PDB','prodom','prodom: protein domains','sbase','sbase: annotated domains sequences','embl','embl: Embl last release + updates','embl_new','embl_new: Embl updates','genbank','genbank: Genbank last release + updates','genbank_new','genbank_new: Genbank updates','gbbct','gbbct: genbank bacteria','gbpri','gbpri: primates','gbmam','gbmam: other mammals','gbrod','gbrod: rodents','gbvrt','gbvrt: other vertebrates','gbinv','gbinv: invertebrates','gbpln','gbpln: plants (including yeast)','gbvrl','gbvrl: virus','gbphg','gbphg: phages','gbest','gbest: EST (Expressed Sequence Tags)','gbsts','gbsts: STS (Sequence Tagged sites)','gbsyn','gbsyn: synthetic','gbpat','gbpat: patented','gbuna','gbuna: unannotated','gbgss','gbgss: Genome Survey Sequences','gbhtg','gbhtg: GS (high throughput Genomic Sequencing)','imgt','imgt: ImMunoGeneTics','borrelia','borrelia: Borrelia burgdorferi complete genome','ecoli','ecoli: Escherichia Coli complete genome','genitalium','genitalium: Mycoplasma Genitalium complete genome','pneumoniae','pneumoniae: Mycoplasma Pneumoniae complete genome','pylori','pylori: Helicobacter Pylori complete genome','subtilis','subtilis: Bacillus Subtilis complete genome','tuberculosis','tuberculosis: Mycobacterium tuberculosis complete genome','ypestis','Yersinia pestis unfinished genome','yeast','yeast: Yeast chromosomes',],
	"control_options" => ['e_value','p_value','repeats','max_repeats','min_repeats','order','product','pseudo_count','shuffle','seed','mask','heap',],
	"mask" => ['-X','-X: ... NOT matching motif(s)','-x','-x: ... matching motif(s)',],
	"output_options" => ['seqfile',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"db" => 'nrprot',
	"repeats" => '0',
	"order" => '0',
	"product" => '0',
	"seqfile" => '0',

    };

    $self->{PRECOND}  = {
	"gibbs_scan" => { "perl" => '1' },
	"motif_file" => { "perl" => '1' },
	"db" => { "perl" => '1' },
	"control_options" => { "perl" => '1' },
	"e_value" => { "perl" => '1' },
	"p_value" => { "perl" => '1' },
	"repeats" => { "perl" => '1' },
	"max_repeats" => {
		"perl" => '$repeats',
	},
	"min_repeats" => {
		"perl" => '$repeats',
	},
	"order" => { "perl" => '1' },
	"product" => { "perl" => '1' },
	"pseudo_count" => {
		"perl" => '$product',
	},
	"shuffle" => { "perl" => '1' },
	"seed" => { "perl" => '1' },
	"mask" => { "perl" => '1' },
	"heap" => { "perl" => '1' },
	"output_options" => { "perl" => '1' },
	"seqfile" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"motif_file" => {
		 "gibbs_motif" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"gibbs_scan" => 0,
	"motif_file" => 0,
	"db" => 0,
	"control_options" => 0,
	"e_value" => 0,
	"p_value" => 0,
	"repeats" => 0,
	"max_repeats" => 0,
	"min_repeats" => 0,
	"order" => 0,
	"product" => 0,
	"pseudo_count" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"mask" => 0,
	"heap" => 0,
	"output_options" => 0,
	"seqfile" => 0,

    };

    $self->{ISSIMPLE}  = {
	"gibbs_scan" => 0,
	"motif_file" => 1,
	"db" => 1,
	"control_options" => 0,
	"e_value" => 0,
	"p_value" => 0,
	"repeats" => 0,
	"max_repeats" => 0,
	"min_repeats" => 0,
	"order" => 0,
	"product" => 0,
	"pseudo_count" => 0,
	"shuffle" => 0,
	"seed" => 0,
	"mask" => 0,
	"heap" => 0,
	"output_options" => 0,
	"seqfile" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {

    };

    $self->{SCALEMIN}  = {

    };

    $self->{SCALEMAX}  = {

    };

    $self->{SCALEINC}  = {

    };

    $self->{INFO}  = {

    };

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/gibbs_scan.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

