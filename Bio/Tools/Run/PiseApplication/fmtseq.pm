# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::fmtseq
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::fmtseq

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::fmtseq

      Bioperl class for:

	fmtseq	sequence conversion (J. R. Knight)


      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/fmtseq.html 
         for available values):


		fmtseq (String)

		seq (InFile)
			Sequence File
			pipe: readseq_ok_alig

		outfile (OutFile)
			pipe: seqsfile

		outformat (Excl)
			Output Sequence Format

		gapin (Excl)
			Set the gap symbol for the input (-gapin)

		informat (Excl)
			Input sequence format (-inf[ormat])

		caselower (Switch)
			convert to lowercase (-c)

		CASEUPPER (Switch)
			convert to upper case (-C)

		degap (Switch)
			Remove gaps from sequences (-degap)

		gapout (Excl)
			Set the gap symbol for the output (-gapout)

		list (Switch)
			Only list sequence information (-li)

		long (Switch)
			Long form conversion (input header included as comment) (-long)

		raw (Excl)
			Gaps in sequences (-raw)

		reverse (Switch)
			Reverse-complement each sequence (-re)

		interleave (Excl)
			Output interleaved sequences (-interleave)

		width (Integer)
			Sequence line width (-width)

		tab (Integer)
			Indent sequence (-tab)

		colspace (Integer)
			Add space columms in sequence lines (-colspace)

		gapcount (Excl)
			Count gap chars in sequence numbers (-gapcount)

		nameleft (Integer)
			Name on left side (-nameleft)

		nameright (Integer)
			Name on left side (-nameright)

		nametop (Switch)
			Name at top (-nametop)

		numleft (Excl)
			Sequence index on left/right side

		numtop (Excl)
			Index on top/bottom

		match (Switch)
			Replace matches to first sequence with . (-match)

		interline (Integer)
			How many blank line(s) between sequence blocks (-interline)

		skipempty (Switch)
			Do not output lines with only gap characters (-skipempty)

		bigalign (Switch)
			Convert FASTA program output to big alignment (-bigalign)

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via
email or the web:

  bioperl-bugs@bioperl.org
  http://bioperl.org/bioperl-bugs/

=head1 AUTHOR

Catherine Letondal (letondal@pasteur.fr)

=head1 COPYRIGHT

Copyright (C) 2003 Institut Pasteur & Catherine Letondal.
All Rights Reserved.

This module is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 DISCLAIMER

This software is provided "as is" without warranty of any kind.

=head1 SEE ALSO

=over

=item *

http://bioweb.pasteur.fr/seqanal/interfaces/fmtseq.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::fmtseq;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $fmtseq = Bio::Tools::Run::PiseApplication::fmtseq->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::fmtseq object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $fmtseq = $factory->program('fmtseq');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::fmtseq.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/fmtseq.pm

    $self->{COMMAND}   = "fmtseq";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "fmtseq";

    $self->{DESCRIPTION}   = "sequence conversion";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "J. R. Knight";

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"fmtseq",
	"seq",
	"outfile",
	"outformat",
	"input",
	"output",
	"bigalign",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"fmtseq",
	"seq", 	# Sequence File
	"outfile",
	"outformat", 	# Output Sequence Format
	"input", 	# Input parameters
	"gapin", 	# Set the gap symbol for the input (-gapin)
	"informat", 	# Input sequence format (-inf[ormat])
	"output", 	# Output parameters
	"caselower", 	# convert to lowercase (-c)
	"CASEUPPER", 	# convert to upper case (-C)
	"degap", 	# Remove gaps from sequences (-degap)
	"gapout", 	# Set the gap symbol for the output (-gapout)
	"list", 	# Only list sequence information (-li)
	"long", 	# Long form conversion (input header included as comment) (-long)
	"raw", 	# Gaps in sequences (-raw)
	"reverse", 	# Reverse-complement each sequence (-re)
	"prettyoptions", 	# Pretty-print options
	"interleave", 	# Output interleaved sequences (-interleave)
	"width", 	# Sequence line width (-width)
	"tab", 	# Indent sequence (-tab)
	"colspace", 	# Add space columms in sequence lines (-colspace)
	"gapcount", 	# Count gap chars in sequence numbers (-gapcount)
	"nameleft", 	# Name on left side (-nameleft)
	"nameright", 	# Name on left side (-nameright)
	"nametop", 	# Name at top (-nametop)
	"numleft", 	# Sequence index on left/right side
	"numtop", 	# Index on top/bottom
	"match", 	# Replace matches to first sequence with . (-match)
	"interline", 	# How many blank line(s) between sequence blocks (-interline)
	"skipempty", 	# Do not output lines with only gap characters (-skipempty)
	"bigalign", 	# Convert FASTA program output to big alignment (-bigalign)

    ];

    $self->{TYPE}  = {
	"fmtseq" => 'String',
	"seq" => 'InFile',
	"outfile" => 'OutFile',
	"outformat" => 'Excl',
	"input" => 'Paragraph',
	"gapin" => 'Excl',
	"informat" => 'Excl',
	"output" => 'Paragraph',
	"caselower" => 'Switch',
	"CASEUPPER" => 'Switch',
	"degap" => 'Switch',
	"gapout" => 'Excl',
	"list" => 'Switch',
	"long" => 'Switch',
	"raw" => 'Excl',
	"reverse" => 'Switch',
	"prettyoptions" => 'Paragraph',
	"interleave" => 'Excl',
	"width" => 'Integer',
	"tab" => 'Integer',
	"colspace" => 'Integer',
	"gapcount" => 'Excl',
	"nameleft" => 'Integer',
	"nameright" => 'Integer',
	"nametop" => 'Switch',
	"numleft" => 'Excl',
	"numtop" => 'Excl',
	"match" => 'Switch',
	"interline" => 'Integer',
	"skipempty" => 'Switch',
	"bigalign" => 'Switch',

    };

    $self->{FORMAT}  = {
	"fmtseq" => {
		"perl" => ' "fmtseq -p -all " ',
	},
	"seq" => {
		"perl" => '" < $value"',
	},
	"outfile" => {
		"perl" => '""',
	},
	"outformat" => {
		"perl" => '" -f$value"',
	},
	"input" => {
	},
	"gapin" => {
		"perl" => '($value)? " -gapin=$value" : ""',
	},
	"informat" => {
		"perl" => '($value)? " -informat=$value" : ""',
	},
	"output" => {
	},
	"caselower" => {
		"perl" => ' ($value)? " -c":""',
	},
	"CASEUPPER" => {
		"perl" => ' ($value)? " -C":""',
	},
	"degap" => {
		"perl" => ' ($value)? " -degap":""',
	},
	"gapout" => {
		"perl" => ' ($value)? " -gapout=$value":""',
	},
	"list" => {
		"perl" => ' ($value)? " -li":""',
	},
	"long" => {
		"perl" => ' ($value)? " -long":""',
	},
	"raw" => {
		"perl" => ' ($value)? " -$value":""',
	},
	"reverse" => {
		"perl" => ' ($value)? " -re":""',
	},
	"prettyoptions" => {
	},
	"interleave" => {
		"perl" => ' ($value)? " -$value":""',
	},
	"width" => {
		"perl" => ' (defined $value)?" -width=$value":""',
	},
	"tab" => {
		"perl" => ' (defined $value)?" -tab=$value":""',
	},
	"colspace" => {
		"perl" => ' (defined $value)?" -colspace=$value":""',
	},
	"gapcount" => {
		"perl" => ' (defined $value)? " -$value" : "" ',
	},
	"nameleft" => {
		"perl" => '($value) ? " -nameleft=$value" : "" ',
	},
	"nameright" => {
		"perl" => '($value) ? " -nameright=$value" : "" ',
	},
	"nametop" => {
		"perl" => ' ($value)? " -nametop" : "" ',
	},
	"numleft" => {
		"perl" => '($value)? " -num$value" : "" ',
	},
	"numtop" => {
		"perl" => ' ($value)? " -num$value" : "" ',
	},
	"match" => {
		"perl" => ' ($value)? " -match=." : "" ',
	},
	"interline" => {
		"perl" => ' (defined $value)?" -interline=$value":""',
	},
	"skipempty" => {
		"perl" => ' ($value)? " -skipempty" : "" ',
	},
	"bigalign" => {
		"perl" => ' ($value)? " -bigalign" : "" ',
	},

    };

    $self->{FILENAMES}  = {

    };

    $self->{SEQFMT}  = {

    };

    $self->{GROUP}  = {
	"fmtseq" => 0,
	"seq" => 10,
	"outformat" => 1,
	"input" => 1,
	"gapin" => 1,
	"informat" => 1,
	"output" => 1,
	"caselower" => 1,
	"CASEUPPER" => 1,
	"degap" => 1,
	"gapout" => 1,
	"list" => 1,
	"long" => 1,
	"raw" => 1,
	"reverse" => 1,
	"prettyoptions" => 2,
	"interleave" => 2,
	"width" => 2,
	"tab" => 2,
	"colspace" => 2,
	"gapcount" => 2,
	"nameleft" => 2,
	"nameright" => 2,
	"nametop" => 3,
	"numleft" => 2,
	"numtop" => 2,
	"match" => 2,
	"interline" => 2,
	"skipempty" => 2,
	"bigalign" => 1,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"fmtseq",
	"outfile",
	"bigalign",
	"outformat",
	"input",
	"gapin",
	"informat",
	"output",
	"caselower",
	"CASEUPPER",
	"degap",
	"gapout",
	"list",
	"long",
	"raw",
	"reverse",
	"prettyoptions",
	"interleave",
	"width",
	"tab",
	"colspace",
	"gapcount",
	"nameleft",
	"nameright",
	"numleft",
	"numtop",
	"match",
	"interline",
	"skipempty",
	"nametop",
	"seq",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"fmtseq" => 1,
	"seq" => 0,
	"outfile" => 1,
	"outformat" => 0,
	"input" => 0,
	"gapin" => 0,
	"informat" => 0,
	"output" => 0,
	"caselower" => 0,
	"CASEUPPER" => 0,
	"degap" => 0,
	"gapout" => 0,
	"list" => 0,
	"long" => 0,
	"raw" => 0,
	"reverse" => 0,
	"prettyoptions" => 0,
	"interleave" => 0,
	"width" => 0,
	"tab" => 0,
	"colspace" => 0,
	"gapcount" => 0,
	"nameleft" => 0,
	"nameright" => 0,
	"nametop" => 0,
	"numleft" => 0,
	"numtop" => 0,
	"match" => 0,
	"interline" => 0,
	"skipempty" => 0,
	"bigalign" => 0,

    };

    $self->{ISCOMMAND}  = {
	"fmtseq" => 1,
	"seq" => 0,
	"outfile" => 0,
	"outformat" => 0,
	"input" => 0,
	"gapin" => 0,
	"informat" => 0,
	"output" => 0,
	"caselower" => 0,
	"CASEUPPER" => 0,
	"degap" => 0,
	"gapout" => 0,
	"list" => 0,
	"long" => 0,
	"raw" => 0,
	"reverse" => 0,
	"prettyoptions" => 0,
	"interleave" => 0,
	"width" => 0,
	"tab" => 0,
	"colspace" => 0,
	"gapcount" => 0,
	"nameleft" => 0,
	"nameright" => 0,
	"nametop" => 0,
	"numleft" => 0,
	"numtop" => 0,
	"match" => 0,
	"interline" => 0,
	"skipempty" => 0,
	"bigalign" => 0,

    };

    $self->{ISMANDATORY}  = {
	"fmtseq" => 0,
	"seq" => 1,
	"outfile" => 0,
	"outformat" => 1,
	"input" => 0,
	"gapin" => 0,
	"informat" => 0,
	"output" => 0,
	"caselower" => 0,
	"CASEUPPER" => 0,
	"degap" => 0,
	"gapout" => 0,
	"list" => 0,
	"long" => 0,
	"raw" => 0,
	"reverse" => 0,
	"prettyoptions" => 0,
	"interleave" => 0,
	"width" => 0,
	"tab" => 0,
	"colspace" => 0,
	"gapcount" => 0,
	"nameleft" => 0,
	"nameright" => 0,
	"nametop" => 0,
	"numleft" => 0,
	"numtop" => 0,
	"match" => 0,
	"interline" => 0,
	"skipempty" => 0,
	"bigalign" => 0,

    };

    $self->{PROMPT}  = {
	"fmtseq" => "",
	"seq" => "Sequence File",
	"outfile" => "",
	"outformat" => "Output Sequence Format",
	"input" => "Input parameters",
	"gapin" => "Set the gap symbol for the input (-gapin)",
	"informat" => "Input sequence format (-inf[ormat])",
	"output" => "Output parameters",
	"caselower" => "convert to lowercase (-c)",
	"CASEUPPER" => "convert to upper case (-C)",
	"degap" => "Remove gaps from sequences (-degap)",
	"gapout" => "Set the gap symbol for the output (-gapout)",
	"list" => "Only list sequence information (-li)",
	"long" => "Long form conversion (input header included as comment) (-long)",
	"raw" => "Gaps in sequences (-raw)",
	"reverse" => "Reverse-complement each sequence (-re)",
	"prettyoptions" => "Pretty-print options",
	"interleave" => "Output interleaved sequences (-interleave)",
	"width" => "Sequence line width (-width)",
	"tab" => "Indent sequence (-tab)",
	"colspace" => "Add space columms in sequence lines (-colspace)",
	"gapcount" => "Count gap chars in sequence numbers (-gapcount)",
	"nameleft" => "Name on left side (-nameleft)",
	"nameright" => "Name on left side (-nameright)",
	"nametop" => "Name at top (-nametop)",
	"numleft" => "Sequence index on left/right side",
	"numtop" => "Index on top/bottom",
	"match" => "Replace matches to first sequence with . (-match)",
	"interline" => "How many blank line(s) between sequence blocks (-interline)",
	"skipempty" => "Do not output lines with only gap characters (-skipempty)",
	"bigalign" => "Convert FASTA program output to big alignment (-bigalign)",

    };

    $self->{ISSTANDOUT}  = {
	"fmtseq" => 0,
	"seq" => 0,
	"outfile" => 1,
	"outformat" => 0,
	"input" => 0,
	"gapin" => 0,
	"informat" => 0,
	"output" => 0,
	"caselower" => 0,
	"CASEUPPER" => 0,
	"degap" => 0,
	"gapout" => 0,
	"list" => 0,
	"long" => 0,
	"raw" => 0,
	"reverse" => 0,
	"prettyoptions" => 0,
	"interleave" => 0,
	"width" => 0,
	"tab" => 0,
	"colspace" => 0,
	"gapcount" => 0,
	"nameleft" => 0,
	"nameright" => 0,
	"nametop" => 0,
	"numleft" => 0,
	"numtop" => 0,
	"match" => 0,
	"interline" => 0,
	"skipempty" => 0,
	"bigalign" => 0,

    };

    $self->{VLIST}  = {

	"outformat" => ['1','1. Raw','2','2. Plain','3','3. EMBL','4','4. Swiss-Prot','5','5. GenBank','6','6. PIR (codata)','7','7. ASN.1','8','8. FASTA (Pearson)','9','9. FASTA','12','12. NBRF','13','13. NBRF-old','14','14. IG/Stanford','15','15. IG-old','16','16. GCG','17','17. MSF','18','18. PHYLIP','19','19. PHYLIP-Interleaved','20','20. PHYLIP-Sequential','21','21. Clustalw','22','22. Pretty',],
	"input" => ['gapin','informat',],
	"gapin" => ['.','\'.\'','-','\'-\'',],
	"informat" => ['1','1. Raw','2','2. Plain','3','3. EMBL','4','4. Swiss-Prot','5','5. GenBank','6','6. PIR (codata)','7','7. ASN.1','9','9. FASTA','10','10. FASTA-output','11','11. BLAST-output','12','12. NBRF','13','13. NBRF-old','14','14. IG/Stanford','15','15. IG-old','16','16. GCG','17','17. MSF','18','18. PHYLIP','19','19. PHYLIP-Interleaved','20','20. PHYLIP-Sequential','21','21. Clustalw',],
	"output" => ['caselower','CASEUPPER','degap','gapout','list','long','raw','reverse','prettyoptions',],
	"gapout" => ['.','\'.\'','-','\'-\'',],
	"raw" => ['raw','leave gaps','noraw','do not leave gaps',],
	"prettyoptions" => ['interleave','width','tab','colspace','gapcount','nameleft','nameright','nametop','numleft','numtop','match','interline','skipempty',],
	"interleave" => ['interleave','interleave','nointerleave','nointerleave',],
	"gapcount" => ['gapcount','gap count','nogapcount','no gap count',],
	"numleft" => ['left','left','right','right',],
	"numtop" => ['top','top','bot','bottom',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {

    };

    $self->{VDEF}  = {
	"outfile" => '"fmtseq.out"',
	"outformat" => '9',
	"nametop" => '0',
	"match" => '0',
	"skipempty" => '0',

    };

    $self->{PRECOND}  = {
	"fmtseq" => { "perl" => '1' },
	"seq" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"outformat" => { "perl" => '1' },
	"input" => { "perl" => '1' },
	"gapin" => { "perl" => '1' },
	"informat" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"caselower" => { "perl" => '1' },
	"CASEUPPER" => { "perl" => '1' },
	"degap" => { "perl" => '1' },
	"gapout" => { "perl" => '1' },
	"list" => { "perl" => '1' },
	"long" => { "perl" => '1' },
	"raw" => { "perl" => '1' },
	"reverse" => { "perl" => '1' },
	"prettyoptions" => { "perl" => '1' },
	"interleave" => { "perl" => '1' },
	"width" => { "perl" => '1' },
	"tab" => { "perl" => '1' },
	"colspace" => { "perl" => '1' },
	"gapcount" => { "perl" => '1' },
	"nameleft" => { "perl" => '1' },
	"nameright" => { "perl" => '1' },
	"nametop" => { "perl" => '1' },
	"numleft" => { "perl" => '1' },
	"numtop" => { "perl" => '1' },
	"match" => { "perl" => '1' },
	"interline" => { "perl" => '1' },
	"skipempty" => { "perl" => '1' },
	"bigalign" => { "perl" => '1' },

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outfile" => {
		 '$outformat !~ /2./ ' => "seqsfile",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"seq" => {
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"fmtseq" => 0,
	"seq" => 0,
	"outfile" => 0,
	"outformat" => 0,
	"input" => 0,
	"gapin" => 0,
	"informat" => 0,
	"output" => 0,
	"caselower" => 0,
	"CASEUPPER" => 0,
	"degap" => 0,
	"gapout" => 0,
	"list" => 0,
	"long" => 0,
	"raw" => 0,
	"reverse" => 0,
	"prettyoptions" => 0,
	"interleave" => 0,
	"width" => 0,
	"tab" => 0,
	"colspace" => 0,
	"gapcount" => 0,
	"nameleft" => 0,
	"nameright" => 0,
	"nametop" => 0,
	"numleft" => 0,
	"numtop" => 0,
	"match" => 0,
	"interline" => 0,
	"skipempty" => 0,
	"bigalign" => 0,

    };

    $self->{ISSIMPLE}  = {
	"fmtseq" => 0,
	"seq" => 1,
	"outfile" => 0,
	"outformat" => 1,
	"input" => 0,
	"gapin" => 0,
	"informat" => 0,
	"output" => 0,
	"caselower" => 0,
	"CASEUPPER" => 0,
	"degap" => 0,
	"gapout" => 0,
	"list" => 0,
	"long" => 0,
	"raw" => 0,
	"reverse" => 0,
	"prettyoptions" => 0,
	"interleave" => 0,
	"width" => 0,
	"tab" => 0,
	"colspace" => 0,
	"gapcount" => 0,
	"nameleft" => 0,
	"nameright" => 0,
	"nametop" => 0,
	"numleft" => 0,
	"numtop" => 0,
	"match" => 0,
	"interline" => 0,
	"skipempty" => 0,
	"bigalign" => 0,

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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/fmtseq.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

