# $Id$
# BioPerl module for Bio::Tools::Run::PiseApplication::clustalw
#
# Cared for by Catherine Letondal <letondal@pasteur.fr>
#
# For copyright and disclaimer see below.
#
# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::PiseApplication::clustalw

=head1 SYNOPSIS

  #

=head1 DESCRIPTION

Bio::Tools::Run::PiseApplication::clustalw

      Bioperl class for:

	Clustalw	Multiple Alignments (Des Higgins)

	References:

		Thompson, J.D., Higgins, D.G. and Gibson, T.J. (1994) CLUSTAL W: improving the sensitivity of progressive multiple sequence alignment through sequence weighting, positions-specific gap penalties and weight matrix choice. Nucleic Acids Research, 22:4673-4680.



      Parameters: 

        (see also:
          http://bioweb.pasteur.fr/seqanal/interfaces/clustalw.html 
         for available values):


		clustalw (String)

		infile (Sequence)
			Sequences File  (or Alignment File for Bootstrap and Tree actions) (-infile)
			pipe: seqsfile
			pipe: readseq_ok_alig

		actions (Excl)
			Actions

		phylip_alig (Switch)
			Phylip alignment output format (-output)

		quicktree (Excl)
			Toggle Slow/Fast pairwise alignments (-quicktree)

		typeseq (Excl)
			Protein or DNA (-type)

		matrix (Excl)
			Protein weight matrix (-matrix)

		dnamatrix (Excl)
			DNA weight matrix (-dnamatrix)

		gapopen (Integer)
			Gap opening penalty (-gapopen)

		gapext (Float)
			Gap extension penalty (-gapext)

		endgaps (Switch)
			End gap separation penalty (-endgaps)

		gapdist (Integer)
			Gap separation pen. range (-gapdist)

		pgap (Switch)
			Residue specific penalties (Pascarella gaps) (-nopgap)

		hgap (Switch)
			Hydrophilic gaps (-nohgap)

		hgapresidues (List)
			Hydrophilic residues list (-hgapresidues)

		maxdiv (Integer)
			Delay divergent sequences : % ident. for delay (-maxdiv)

		negative (Switch)
			Negative values in matrix ? (-negative)

		transweight (Float)
			Transitions weight (between 0 and 1) (-transweight)

		newtree (OutFile)
			File for new guide tree (-newtree)

		usetree (InFile)
			File for old guide tree (-usetree)

		ktuple (Integer)
			Word size (-ktuple)

		topdiags (Integer)
			Number of best diagonals (-topdiags)

		window (Integer)
			Window around best diags (-window)

		pairgap (Float)
			Gap penalty (-pairgap)

		score (Excl)
			Percent or absolute score ? (-score)

		pwmatrix (Excl)
			Protein weight matrix (-pwmatrix)

		pwdnamatrix (Excl)
			DNA weight matrix (-pwdnamatrix)

		pwgapopen (Float)
			Gap opening penalty (-pwgapopen)

		pwgapext (Float)
			Gap extension penalty (-pwgapext)

		kimura (Switch)
			Use Kimura's correction (multiple substitutions) ? (-kimura)

		tossgaps (Switch)
			Ignore positions with gaps ? (-tossgaps)

		bootstrap (Integer)
			Bootstrap a NJ tree (give the number of bootstraps, 0 for none) (-bootstrap)

		bootlabels (Excl)
			Phylip bootstrap positions (-bootlabels)

		seed (Integer)
			Seed number for bootstraps (-seed)

		outputtree (Excl)
			Output tree/distance format (-outputtree)

		outfile (OutFile)
			Alignment File (-outfile)
			pipe: readseq_ok_alig

		output (Excl)
			Output format (-output)

		gde_lower (Switch)
			Upper case GDE output (-case)

		outorder (Excl)
			Result order (-outorder)

		seqnos (Switch)
			Output sequence numbers in the output file (clustalw format) (-seqnos)

		profile1 (InFile)
			Profile 1 (-profile1)

		profile2 (InFile)
			Profile 2 (-profile2)

		usetree1 (InFile)
			File for old guide tree for profile1 (-usetree1)

		usetree2 (InFile)
			File for old guide tree for profile2 (-usetree2)

		newtree1 (OutFile)
			File for new guide tree for profile1 (-newtree1)

		newtree2 (OutFile)
			File for new guide tree for profile2 (-newtree2)

		nosecstr1 (Switch)
			Use profile 1 secondary structure / penalty mask (-nosecstr1)

		nosecstr2 (Switch)
			Use profile 2 secondary structure / penalty mask (-nosecstr2)

		helixgap (Integer)
			Helix gap penalty (-helixgap)

		strandgap (Integer)
			Strand gap penalty (-strandgap)

		loopgap (Integer)
			Loop gap penalty (-loopgap)

		terminalgap (Integer)
			Secondary structure terminal penalty (-terminalgap)

		helixendin (Integer)
			Helix terminal positions:  number of residues inside helix to be treated as terminal (-helixendin)

		helixendout (Integer)
			Helix terminal positions: number of residues outside helix to be treated as terminal (-helixendout)

		strandendin (Integer)
			Strand terminal positions: number of residues inside strand to be treated as terminal (-strandendin)

		strandendout (Integer)
			Strand terminal positions: number of residues outside strand to be treated as terminal (-strandendout)

		secstrout (Excl)
			Output in alignment (-secstrout)

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

http://bioweb.pasteur.fr/seqanal/interfaces/clustalw.html

=item *

Bio::Tools::Run::PiseApplication

=item *

Bio::Tools::Run::AnalysisFactory::Pise

=item *

Bio::Tools::Run::PiseJob

=back

=cut

#'
package Bio::Tools::Run::PiseApplication::clustalw;

use vars qw(@ISA);
use strict;
use Bio::Tools::Run::PiseApplication;

@ISA = qw(Bio::Tools::Run::PiseApplication);

=head2 new

 Title   : new()
 Usage   : my $clustalw = Bio::Tools::Run::PiseApplication::clustalw->new($location, $email, @params);
 Function: Creates a Bio::Tools::Run::PiseApplication::clustalw object.
           This method should not be used directly, but rather by 
           a Bio::Tools::Run::AnalysisFactory::Pise instance.
           my $factory = Bio::Tools::Run::AnalysisFactory::Pise->new();
           my $clustalw = $factory->program('clustalw');
 Example : -
 Returns : An instance of Bio::Tools::Run::PiseApplication::clustalw.

=cut

sub new {
    my ($class, $location, $email, @params) = @_;
    my $self = $class->SUPER::new($location, $email);

# -- begin of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/clustalw.pm

    $self->{COMMAND}   = "clustalw";
    $self->{VERSION}   = "5.a";
    $self->{TITLE}   = "Clustalw";

    $self->{DESCRIPTION}   = "Multiple Alignments";

    $self->{OPT_EMAIL}   = 0;

    $self->{AUTHORS}   = "Des Higgins";

    $self->{REFERENCE}   = [

         "Thompson, J.D., Higgins, D.G. and Gibson, T.J. (1994) CLUSTAL W: improving the sensitivity of progressive multiple sequence alignment through sequence weighting, positions-specific gap penalties and weight matrix choice. Nucleic Acids Research, 22:4673-4680.",
 ];

    $self->{_INTERFACE_STANDOUT} = undef;
    $self->{_STANDOUT_FILE} = undef;

    $self->{TOP_PARAMETERS}  = [ 
	"clustalw",
	"infile",
	"actions",
	"phylip_alig",
	"multalign",
	"fastpw",
	"slowpw",
	"trees",
	"outputparam",
	"aligfile",
	"readseq_ok_aligfile",
	"newtreefile",
	"phylipnewtreefile",
	"profile",
	"structure",

    ];

    $self->{PARAMETERS_ORDER}  = [
	"clustalw",
	"infile", 	# Sequences File  (or Alignment File for Bootstrap and Tree actions) (-infile)
	"actions", 	# Actions
	"phylip_alig", 	# Phylip alignment output format (-output)
	"multalign", 	# Multiple Alignments parameters
	"quicktree", 	# Toggle Slow/Fast pairwise alignments (-quicktree)
	"typeseq", 	# Protein or DNA (-type)
	"matrix", 	# Protein weight matrix (-matrix)
	"dnamatrix", 	# DNA weight matrix (-dnamatrix)
	"gapopen", 	# Gap opening penalty (-gapopen)
	"gapext", 	# Gap extension penalty (-gapext)
	"endgaps", 	# End gap separation penalty (-endgaps)
	"gapdist", 	# Gap separation pen. range (-gapdist)
	"pgap", 	# Residue specific penalties (Pascarella gaps) (-nopgap)
	"hgap", 	# Hydrophilic gaps (-nohgap)
	"hgapresidues", 	# Hydrophilic residues list (-hgapresidues)
	"maxdiv", 	# Delay divergent sequences : % ident. for delay (-maxdiv)
	"negative", 	# Negative values in matrix ? (-negative)
	"transweight", 	# Transitions weight (between 0 and 1) (-transweight)
	"newtree", 	# File for new guide tree (-newtree)
	"usetree", 	# File for old guide tree (-usetree)
	"fastpw", 	# Fast Pairwise Alignments parameters
	"ktuple", 	# Word size (-ktuple)
	"topdiags", 	# Number of best diagonals (-topdiags)
	"window", 	# Window around best diags (-window)
	"pairgap", 	# Gap penalty (-pairgap)
	"score", 	# Percent or absolute score ? (-score)
	"slowpw", 	# Slow Pairwise Alignments parameters
	"pwmatrix", 	# Protein weight matrix (-pwmatrix)
	"pwdnamatrix", 	# DNA weight matrix (-pwdnamatrix)
	"pwgapopen", 	# Gap opening penalty (-pwgapopen)
	"pwgapext", 	# Gap extension penalty (-pwgapext)
	"trees", 	# Tree parameters
	"kimura", 	# Use Kimura's correction (multiple substitutions) ? (-kimura)
	"tossgaps", 	# Ignore positions with gaps ? (-tossgaps)
	"bootstrap", 	# Bootstrap a NJ tree (give the number of bootstraps, 0 for none) (-bootstrap)
	"bootlabels", 	# Phylip bootstrap positions (-bootlabels)
	"seed", 	# Seed number for bootstraps (-seed)
	"outputtree", 	# Output tree/distance format (-outputtree)
	"outputparam", 	# Output parameters
	"outfile", 	# Alignment File (-outfile)
	"output", 	# Output format (-output)
	"gde_lower", 	# Upper case GDE output (-case)
	"outorder", 	# Result order (-outorder)
	"seqnos", 	# Output sequence numbers in the output file (clustalw format) (-seqnos)
	"aligfile",
	"readseq_ok_aligfile",
	"newtreefile",
	"phylipnewtreefile",
	"profile", 	# Profile Alignments parameters
	"profile1", 	# Profile 1 (-profile1)
	"profile2", 	# Profile 2 (-profile2)
	"usetree1", 	# File for old guide tree for profile1 (-usetree1)
	"usetree2", 	# File for old guide tree for profile2 (-usetree2)
	"newtree1", 	# File for new guide tree for profile1 (-newtree1)
	"newtree2", 	# File for new guide tree for profile2 (-newtree2)
	"structure", 	# Structure Alignments parameters
	"nosecstr1", 	# Use profile 1 secondary structure / penalty mask (-nosecstr1)
	"nosecstr2", 	# Use profile 2 secondary structure / penalty mask (-nosecstr2)
	"helixgap", 	# Helix gap penalty (-helixgap)
	"strandgap", 	# Strand gap penalty (-strandgap)
	"loopgap", 	# Loop gap penalty (-loopgap)
	"terminalgap", 	# Secondary structure terminal penalty (-terminalgap)
	"helixendin", 	# Helix terminal positions:  number of residues inside helix to be treated as terminal (-helixendin)
	"helixendout", 	# Helix terminal positions: number of residues outside helix to be treated as terminal (-helixendout)
	"strandendin", 	# Strand terminal positions: number of residues inside strand to be treated as terminal (-strandendin)
	"strandendout", 	# Strand terminal positions: number of residues outside strand to be treated as terminal (-strandendout)
	"secstrout", 	# Output in alignment (-secstrout)

    ];

    $self->{TYPE}  = {
	"clustalw" => 'String',
	"infile" => 'Sequence',
	"actions" => 'Excl',
	"phylip_alig" => 'Switch',
	"multalign" => 'Paragraph',
	"quicktree" => 'Excl',
	"typeseq" => 'Excl',
	"matrix" => 'Excl',
	"dnamatrix" => 'Excl',
	"gapopen" => 'Integer',
	"gapext" => 'Float',
	"endgaps" => 'Switch',
	"gapdist" => 'Integer',
	"pgap" => 'Switch',
	"hgap" => 'Switch',
	"hgapresidues" => 'List',
	"maxdiv" => 'Integer',
	"negative" => 'Switch',
	"transweight" => 'Float',
	"newtree" => 'OutFile',
	"usetree" => 'InFile',
	"fastpw" => 'Paragraph',
	"ktuple" => 'Integer',
	"topdiags" => 'Integer',
	"window" => 'Integer',
	"pairgap" => 'Float',
	"score" => 'Excl',
	"slowpw" => 'Paragraph',
	"pwmatrix" => 'Excl',
	"pwdnamatrix" => 'Excl',
	"pwgapopen" => 'Float',
	"pwgapext" => 'Float',
	"trees" => 'Paragraph',
	"kimura" => 'Switch',
	"tossgaps" => 'Switch',
	"bootstrap" => 'Integer',
	"bootlabels" => 'Excl',
	"seed" => 'Integer',
	"outputtree" => 'Excl',
	"outputparam" => 'Paragraph',
	"outfile" => 'OutFile',
	"output" => 'Excl',
	"gde_lower" => 'Switch',
	"outorder" => 'Excl',
	"seqnos" => 'Switch',
	"aligfile" => 'Results',
	"readseq_ok_aligfile" => 'Results',
	"newtreefile" => 'Results',
	"phylipnewtreefile" => 'Results',
	"profile" => 'Paragraph',
	"profile1" => 'InFile',
	"profile2" => 'InFile',
	"usetree1" => 'InFile',
	"usetree2" => 'InFile',
	"newtree1" => 'OutFile',
	"newtree2" => 'OutFile',
	"structure" => 'Paragraph',
	"nosecstr1" => 'Switch',
	"nosecstr2" => 'Switch',
	"helixgap" => 'Integer',
	"strandgap" => 'Integer',
	"loopgap" => 'Integer',
	"terminalgap" => 'Integer',
	"helixendin" => 'Integer',
	"helixendout" => 'Integer',
	"strandendin" => 'Integer',
	"strandendout" => 'Integer',
	"secstrout" => 'Excl',

    };

    $self->{FORMAT}  = {
	"clustalw" => {
		"perl" => '"clustalw"',
	},
	"infile" => {
		"seqlab" => '  " -infile=value"',
		"perl" => '  " -infile=$value"',
	},
	"actions" => {
		"perl" => ' " $value" ',
	},
	"phylip_alig" => {
		"perl" => ' ($value)?" -output=PHYLIP":""',
	},
	"multalign" => {
	},
	"quicktree" => {
		"perl" => '($value eq "fast")? " -quicktree" : "" ',
	},
	"typeseq" => {
		"perl" => ' ($value)?" -type=$value":""',
	},
	"matrix" => {
		"perl" => ' ($value && $value ne $vdef)?" -matrix=$value":""',
	},
	"dnamatrix" => {
		"perl" => ' ($value && $value ne $vdef)?" -dnamatrix=$value":""',
	},
	"gapopen" => {
		"perl" => ' (defined $value && $value ne $vdef)? " -gapopen=$value" : ""',
	},
	"gapext" => {
		"perl" => ' (defined $value && $value ne $vdef)? " -gapext=$value" : ""',
	},
	"endgaps" => {
		"perl" => ' (! $value )?" -endgaps":""',
	},
	"gapdist" => {
		"perl" => ' (defined $value && $value != $vdef)? " -gapdist=$value" : ""',
	},
	"pgap" => {
		"perl" => ' (! $value)?" -nopgap":""',
	},
	"hgap" => {
		"perl" => ' (! $value)?" -nohgap":""',
	},
	"hgapresidues" => {
		"perl" => ' ($value && ($value ne $vdef))?" -hgapresidues=\\"$value\\"":""',
	},
	"maxdiv" => {
		"perl" => ' (defined $value && $value != $vdef)? " -maxdiv=$value" : ""',
	},
	"negative" => {
		"perl" => ' ($value)?" -negative":""',
	},
	"transweight" => {
		"perl" => ' (defined $value && $value != $vdef)?" -transweight=$value":""',
	},
	"newtree" => {
		"perl" => ' ($value)? " -newtree=$value" : "" ',
	},
	"usetree" => {
		"perl" => ' ($value)?" -usetree=$value":""',
	},
	"fastpw" => {
	},
	"ktuple" => {
		"perl" => ' (defined $value && $value ne $vdef)?" -ktuple=$value":""',
	},
	"topdiags" => {
		"perl" => ' (defined $value && $value ne $vdef)?" -topdiags=$value":""',
	},
	"window" => {
		"perl" => ' (defined $value && $value ne $vdef)?" -window=$value":""',
	},
	"pairgap" => {
		"perl" => ' (defined $value && $value ne $vdef)?" -pairgap=$value":""',
	},
	"score" => {
		"perl" => ' ($value)?" -score=$value":""',
	},
	"slowpw" => {
	},
	"pwmatrix" => {
		"perl" => ' ($value && $value ne $vdef)?" -pwmatrix=$value":""',
	},
	"pwdnamatrix" => {
		"perl" => ' ($value && $value ne $vdef)?" -pwdnamatrix=$value":""',
	},
	"pwgapopen" => {
		"perl" => ' (defined $value && $value ne $vdef)? " -pwgapopen=$value" : "" ',
	},
	"pwgapext" => {
		"perl" => ' (defined $value && $value ne $vdef)? " -pwgapext=$value" : "" ',
	},
	"trees" => {
	},
	"kimura" => {
		"perl" => ' ($value)?" -kimura":""',
	},
	"tossgaps" => {
		"perl" => ' ($value)?" -tossgaps":""',
	},
	"bootstrap" => {
		"perl" => '  ($value > 0 && $value != $vdef)? " -bootstrap=$value":"" ',
	},
	"bootlabels" => {
		"perl" => '(defined $value && $value ne $vdef )? " -bootlabels=$value":""',
	},
	"seed" => {
		"perl" => ' (defined $value)?" -seed=$value":""',
	},
	"outputtree" => {
		"perl" => ' ($value && $value ne $vdef)?" -outputtree=$value":""',
	},
	"outputparam" => {
	},
	"outfile" => {
		"perl" => ' ($value && $value ne "$infile.aln")?" -outfile=$value":""',
	},
	"output" => {
		"perl" => ' ($value) ?" -output=$value":""',
	},
	"gde_lower" => {
		"perl" => '($value) ?" -case=upper":""',
	},
	"outorder" => {
		"perl" => ' ($value && $value ne $vdef)?" -outorder=$value":""',
	},
	"seqnos" => {
		"perl" => ' ($value) ?" -seqnos=on":""',
	},
	"aligfile" => {
	},
	"readseq_ok_aligfile" => {
	},
	"newtreefile" => {
	},
	"phylipnewtreefile" => {
	},
	"profile" => {
	},
	"profile1" => {
		"perl" => ' ($value)?" -profile1=$value":""',
	},
	"profile2" => {
		"perl" => ' ($value)?" -profile2=$value":""',
	},
	"usetree1" => {
		"perl" => ' ($value)?" -usetree1=$value":""',
	},
	"usetree2" => {
		"perl" => ' ($value)?" -usetree2=$value":""',
	},
	"newtree1" => {
		"perl" => ' ($value)? " -newtree1=$value" : "" ',
	},
	"newtree2" => {
		"perl" => ' ($value)? " -newtree2=$value" : "" ',
	},
	"structure" => {
	},
	"nosecstr1" => {
		"perl" => '(! $value)? " -nosecstr1" : ""',
	},
	"nosecstr2" => {
		"perl" => '(! $value)? " -nosecstr2" : ""',
	},
	"helixgap" => {
		"perl" => '  (defined $value && $value != $vdef)? " -helixgap=$value":"" ',
	},
	"strandgap" => {
		"perl" => '  (defined $value && $value != $vdef)? " -strandgap=$value":"" ',
	},
	"loopgap" => {
		"perl" => '  (defined $value  && $value != $vdef)? " -loopgap=$value":"" ',
	},
	"terminalgap" => {
		"perl" => '  (defined $value && $value != $vdef)? " -terminalgap=$value":"" ',
	},
	"helixendin" => {
		"perl" => '  (defined $value && $value != $vdef)? " -helixendin=$value":"" ',
	},
	"helixendout" => {
		"perl" => '  (defined $value && $value != $vdef)? " -helixendout=$value":"" ',
	},
	"strandendin" => {
		"perl" => '  (defined $value && $value != $vdef)? " -strandendin=$value":"" ',
	},
	"strandendout" => {
		"perl" => '  (defined $value && $value != $vdef)? " -strandendout=$value":"" ',
	},
	"secstrout" => {
		"perl" => '($value && $value ne $vdef)?" -secstrout=$value":""',
	},

    };

    $self->{FILENAMES}  = {
	"aligfile" => '*.aln *.gde *.phy',
	"readseq_ok_aligfile" => '*.phy *.msf *.pir',
	"newtreefile" => '*.nj *.dst',
	"phylipnewtreefile" => '*.dnd *.ph *.phb',

    };

    $self->{SEQFMT}  = {
	"infile" => [8,3,4,15,100],

    };

    $self->{GROUP}  = {
	"clustalw" => 0,
	"infile" => 1,
	"actions" => 2,
	"phylip_alig" => 2,
	"multalign" => 2,
	"quicktree" => 2,
	"typeseq" => 2,
	"matrix" => 2,
	"dnamatrix" => 2,
	"gapopen" => 2,
	"gapext" => 2,
	"endgaps" => 2,
	"gapdist" => 2,
	"pgap" => 2,
	"hgap" => 2,
	"hgapresidues" => 2,
	"maxdiv" => 2,
	"negative" => 2,
	"transweight" => 2,
	"newtree" => 2,
	"usetree" => 2,
	"fastpw" => 2,
	"ktuple" => 2,
	"topdiags" => 2,
	"window" => 2,
	"pairgap" => 2,
	"score" => 2,
	"slowpw" => 2,
	"pwmatrix" => 2,
	"pwdnamatrix" => 2,
	"pwgapopen" => 2,
	"pwgapext" => 2,
	"trees" => 2,
	"kimura" => 2,
	"tossgaps" => 2,
	"bootstrap" => 2,
	"bootlabels" => 2,
	"seed" => 2,
	"outputtree" => 2,
	"outputparam" => 2,
	"outfile" => 2,
	"output" => 2,
	"gde_lower" => 2,
	"outorder" => 2,
	"seqnos" => 2,
	"profile" => 2,
	"profile1" => 2,
	"profile2" => 2,
	"usetree1" => 2,
	"usetree2" => 2,
	"newtree1" => 2,
	"newtree2" => 2,
	"structure" => 2,
	"nosecstr1" => 2,
	"nosecstr2" => 2,
	"helixgap" => 2,
	"strandgap" => 2,
	"loopgap" => 2,
	"terminalgap" => 2,
	"helixendin" => 2,
	"helixendout" => 2,
	"strandendin" => 2,
	"strandendout" => 2,
	"secstrout" => 2,

    };

    $self->{BY_GROUP_PARAMETERS}  = [
	"clustalw",
	"aligfile",
	"readseq_ok_aligfile",
	"newtreefile",
	"phylipnewtreefile",
	"infile",
	"typeseq",
	"matrix",
	"dnamatrix",
	"gapopen",
	"gapext",
	"endgaps",
	"gapdist",
	"pgap",
	"hgap",
	"hgapresidues",
	"maxdiv",
	"negative",
	"transweight",
	"newtree",
	"usetree",
	"fastpw",
	"ktuple",
	"topdiags",
	"window",
	"pairgap",
	"score",
	"slowpw",
	"pwmatrix",
	"pwdnamatrix",
	"pwgapopen",
	"pwgapext",
	"trees",
	"kimura",
	"tossgaps",
	"bootstrap",
	"bootlabels",
	"seed",
	"outputtree",
	"outputparam",
	"outfile",
	"output",
	"gde_lower",
	"outorder",
	"seqnos",
	"actions",
	"phylip_alig",
	"multalign",
	"quicktree",
	"profile",
	"profile1",
	"profile2",
	"usetree1",
	"usetree2",
	"newtree1",
	"newtree2",
	"structure",
	"nosecstr1",
	"nosecstr2",
	"helixgap",
	"strandgap",
	"loopgap",
	"terminalgap",
	"helixendin",
	"helixendout",
	"strandendin",
	"strandendout",
	"secstrout",

    ];

    $self->{SIZE}  = {

    };

    $self->{ISHIDDEN}  = {
	"clustalw" => 1,
	"infile" => 0,
	"actions" => 0,
	"phylip_alig" => 0,
	"multalign" => 0,
	"quicktree" => 0,
	"typeseq" => 0,
	"matrix" => 0,
	"dnamatrix" => 0,
	"gapopen" => 0,
	"gapext" => 0,
	"endgaps" => 0,
	"gapdist" => 0,
	"pgap" => 0,
	"hgap" => 0,
	"hgapresidues" => 0,
	"maxdiv" => 0,
	"negative" => 0,
	"transweight" => 0,
	"newtree" => 0,
	"usetree" => 0,
	"fastpw" => 0,
	"ktuple" => 0,
	"topdiags" => 0,
	"window" => 0,
	"pairgap" => 0,
	"score" => 0,
	"slowpw" => 0,
	"pwmatrix" => 0,
	"pwdnamatrix" => 0,
	"pwgapopen" => 0,
	"pwgapext" => 0,
	"trees" => 0,
	"kimura" => 0,
	"tossgaps" => 0,
	"bootstrap" => 0,
	"bootlabels" => 0,
	"seed" => 0,
	"outputtree" => 0,
	"outputparam" => 0,
	"outfile" => 0,
	"output" => 0,
	"gde_lower" => 0,
	"outorder" => 0,
	"seqnos" => 0,
	"aligfile" => 0,
	"readseq_ok_aligfile" => 0,
	"newtreefile" => 0,
	"phylipnewtreefile" => 0,
	"profile" => 0,
	"profile1" => 0,
	"profile2" => 0,
	"usetree1" => 0,
	"usetree2" => 0,
	"newtree1" => 0,
	"newtree2" => 0,
	"structure" => 0,
	"nosecstr1" => 0,
	"nosecstr2" => 0,
	"helixgap" => 0,
	"strandgap" => 0,
	"loopgap" => 0,
	"terminalgap" => 0,
	"helixendin" => 0,
	"helixendout" => 0,
	"strandendin" => 0,
	"strandendout" => 0,
	"secstrout" => 0,

    };

    $self->{ISCOMMAND}  = {
	"clustalw" => 1,
	"infile" => 0,
	"actions" => 0,
	"phylip_alig" => 0,
	"multalign" => 0,
	"quicktree" => 0,
	"typeseq" => 0,
	"matrix" => 0,
	"dnamatrix" => 0,
	"gapopen" => 0,
	"gapext" => 0,
	"endgaps" => 0,
	"gapdist" => 0,
	"pgap" => 0,
	"hgap" => 0,
	"hgapresidues" => 0,
	"maxdiv" => 0,
	"negative" => 0,
	"transweight" => 0,
	"newtree" => 0,
	"usetree" => 0,
	"fastpw" => 0,
	"ktuple" => 0,
	"topdiags" => 0,
	"window" => 0,
	"pairgap" => 0,
	"score" => 0,
	"slowpw" => 0,
	"pwmatrix" => 0,
	"pwdnamatrix" => 0,
	"pwgapopen" => 0,
	"pwgapext" => 0,
	"trees" => 0,
	"kimura" => 0,
	"tossgaps" => 0,
	"bootstrap" => 0,
	"bootlabels" => 0,
	"seed" => 0,
	"outputtree" => 0,
	"outputparam" => 0,
	"outfile" => 0,
	"output" => 0,
	"gde_lower" => 0,
	"outorder" => 0,
	"seqnos" => 0,
	"aligfile" => 0,
	"readseq_ok_aligfile" => 0,
	"newtreefile" => 0,
	"phylipnewtreefile" => 0,
	"profile" => 0,
	"profile1" => 0,
	"profile2" => 0,
	"usetree1" => 0,
	"usetree2" => 0,
	"newtree1" => 0,
	"newtree2" => 0,
	"structure" => 0,
	"nosecstr1" => 0,
	"nosecstr2" => 0,
	"helixgap" => 0,
	"strandgap" => 0,
	"loopgap" => 0,
	"terminalgap" => 0,
	"helixendin" => 0,
	"helixendout" => 0,
	"strandendin" => 0,
	"strandendout" => 0,
	"secstrout" => 0,

    };

    $self->{ISMANDATORY}  = {
	"clustalw" => 0,
	"infile" => 1,
	"actions" => 1,
	"phylip_alig" => 0,
	"multalign" => 0,
	"quicktree" => 1,
	"typeseq" => 0,
	"matrix" => 0,
	"dnamatrix" => 0,
	"gapopen" => 0,
	"gapext" => 0,
	"endgaps" => 0,
	"gapdist" => 0,
	"pgap" => 0,
	"hgap" => 0,
	"hgapresidues" => 0,
	"maxdiv" => 0,
	"negative" => 0,
	"transweight" => 0,
	"newtree" => 0,
	"usetree" => 0,
	"fastpw" => 0,
	"ktuple" => 0,
	"topdiags" => 0,
	"window" => 0,
	"pairgap" => 0,
	"score" => 0,
	"slowpw" => 0,
	"pwmatrix" => 0,
	"pwdnamatrix" => 0,
	"pwgapopen" => 0,
	"pwgapext" => 0,
	"trees" => 0,
	"kimura" => 0,
	"tossgaps" => 0,
	"bootstrap" => 0,
	"bootlabels" => 0,
	"seed" => 0,
	"outputtree" => 0,
	"outputparam" => 0,
	"outfile" => 0,
	"output" => 0,
	"gde_lower" => 0,
	"outorder" => 0,
	"seqnos" => 0,
	"aligfile" => 0,
	"readseq_ok_aligfile" => 0,
	"newtreefile" => 0,
	"phylipnewtreefile" => 0,
	"profile" => 0,
	"profile1" => 1,
	"profile2" => 1,
	"usetree1" => 0,
	"usetree2" => 0,
	"newtree1" => 0,
	"newtree2" => 0,
	"structure" => 0,
	"nosecstr1" => 0,
	"nosecstr2" => 0,
	"helixgap" => 0,
	"strandgap" => 0,
	"loopgap" => 0,
	"terminalgap" => 0,
	"helixendin" => 0,
	"helixendout" => 0,
	"strandendin" => 0,
	"strandendout" => 0,
	"secstrout" => 0,

    };

    $self->{PROMPT}  = {
	"clustalw" => "",
	"infile" => "Sequences File  (or Alignment File for Bootstrap and Tree actions) (-infile)",
	"actions" => "Actions",
	"phylip_alig" => "Phylip alignment output format (-output)",
	"multalign" => "Multiple Alignments parameters",
	"quicktree" => "Toggle Slow/Fast pairwise alignments (-quicktree)",
	"typeseq" => "Protein or DNA (-type)",
	"matrix" => "Protein weight matrix (-matrix)",
	"dnamatrix" => "DNA weight matrix (-dnamatrix)",
	"gapopen" => "Gap opening penalty (-gapopen)",
	"gapext" => "Gap extension penalty (-gapext)",
	"endgaps" => "End gap separation penalty (-endgaps)",
	"gapdist" => "Gap separation pen. range (-gapdist)",
	"pgap" => "Residue specific penalties (Pascarella gaps) (-nopgap)",
	"hgap" => "Hydrophilic gaps (-nohgap)",
	"hgapresidues" => "Hydrophilic residues list (-hgapresidues)",
	"maxdiv" => "Delay divergent sequences : % ident. for delay (-maxdiv)",
	"negative" => "Negative values in matrix ? (-negative)",
	"transweight" => "Transitions weight (between 0 and 1) (-transweight)",
	"newtree" => "File for new guide tree (-newtree)",
	"usetree" => "File for old guide tree (-usetree)",
	"fastpw" => "Fast Pairwise Alignments parameters",
	"ktuple" => "Word size (-ktuple)",
	"topdiags" => "Number of best diagonals (-topdiags)",
	"window" => "Window around best diags (-window)",
	"pairgap" => "Gap penalty (-pairgap)",
	"score" => "Percent or absolute score ? (-score)",
	"slowpw" => "Slow Pairwise Alignments parameters",
	"pwmatrix" => "Protein weight matrix (-pwmatrix)",
	"pwdnamatrix" => "DNA weight matrix (-pwdnamatrix)",
	"pwgapopen" => "Gap opening penalty (-pwgapopen)",
	"pwgapext" => "Gap extension penalty (-pwgapext)",
	"trees" => "Tree parameters",
	"kimura" => "Use Kimura's correction (multiple substitutions) ? (-kimura)",
	"tossgaps" => "Ignore positions with gaps ? (-tossgaps)",
	"bootstrap" => "Bootstrap a NJ tree (give the number of bootstraps, 0 for none) (-bootstrap)",
	"bootlabels" => "Phylip bootstrap positions (-bootlabels)",
	"seed" => "Seed number for bootstraps (-seed)",
	"outputtree" => "Output tree/distance format (-outputtree)",
	"outputparam" => "Output parameters",
	"outfile" => "Alignment File (-outfile)",
	"output" => "Output format (-output)",
	"gde_lower" => "Upper case GDE output (-case)",
	"outorder" => "Result order (-outorder)",
	"seqnos" => "Output sequence numbers in the output file (clustalw format) (-seqnos)",
	"aligfile" => "",
	"readseq_ok_aligfile" => "",
	"newtreefile" => "",
	"phylipnewtreefile" => "",
	"profile" => "Profile Alignments parameters",
	"profile1" => "Profile 1 (-profile1)",
	"profile2" => "Profile 2 (-profile2)",
	"usetree1" => "File for old guide tree for profile1 (-usetree1)",
	"usetree2" => "File for old guide tree for profile2 (-usetree2)",
	"newtree1" => "File for new guide tree for profile1 (-newtree1)",
	"newtree2" => "File for new guide tree for profile2 (-newtree2)",
	"structure" => "Structure Alignments parameters",
	"nosecstr1" => "Use profile 1 secondary structure / penalty mask (-nosecstr1)",
	"nosecstr2" => "Use profile 2 secondary structure / penalty mask (-nosecstr2)",
	"helixgap" => "Helix gap penalty (-helixgap)",
	"strandgap" => "Strand gap penalty (-strandgap)",
	"loopgap" => "Loop gap penalty (-loopgap)",
	"terminalgap" => "Secondary structure terminal penalty (-terminalgap)",
	"helixendin" => "Helix terminal positions:  number of residues inside helix to be treated as terminal (-helixendin)",
	"helixendout" => "Helix terminal positions: number of residues outside helix to be treated as terminal (-helixendout)",
	"strandendin" => "Strand terminal positions: number of residues inside strand to be treated as terminal (-strandendin)",
	"strandendout" => "Strand terminal positions: number of residues outside strand to be treated as terminal (-strandendout)",
	"secstrout" => "Output in alignment (-secstrout)",

    };

    $self->{ISSTANDOUT}  = {
	"clustalw" => 0,
	"infile" => 0,
	"actions" => 0,
	"phylip_alig" => 0,
	"multalign" => 0,
	"quicktree" => 0,
	"typeseq" => 0,
	"matrix" => 0,
	"dnamatrix" => 0,
	"gapopen" => 0,
	"gapext" => 0,
	"endgaps" => 0,
	"gapdist" => 0,
	"pgap" => 0,
	"hgap" => 0,
	"hgapresidues" => 0,
	"maxdiv" => 0,
	"negative" => 0,
	"transweight" => 0,
	"newtree" => 0,
	"usetree" => 0,
	"fastpw" => 0,
	"ktuple" => 0,
	"topdiags" => 0,
	"window" => 0,
	"pairgap" => 0,
	"score" => 0,
	"slowpw" => 0,
	"pwmatrix" => 0,
	"pwdnamatrix" => 0,
	"pwgapopen" => 0,
	"pwgapext" => 0,
	"trees" => 0,
	"kimura" => 0,
	"tossgaps" => 0,
	"bootstrap" => 0,
	"bootlabels" => 0,
	"seed" => 0,
	"outputtree" => 0,
	"outputparam" => 0,
	"outfile" => 0,
	"output" => 0,
	"gde_lower" => 0,
	"outorder" => 0,
	"seqnos" => 0,
	"aligfile" => 0,
	"readseq_ok_aligfile" => 0,
	"newtreefile" => 0,
	"phylipnewtreefile" => 0,
	"profile" => 0,
	"profile1" => 0,
	"profile2" => 0,
	"usetree1" => 0,
	"usetree2" => 0,
	"newtree1" => 0,
	"newtree2" => 0,
	"structure" => 0,
	"nosecstr1" => 0,
	"nosecstr2" => 0,
	"helixgap" => 0,
	"strandgap" => 0,
	"loopgap" => 0,
	"terminalgap" => 0,
	"helixendin" => 0,
	"helixendout" => 0,
	"strandendin" => 0,
	"strandendout" => 0,
	"secstrout" => 0,

    };

    $self->{VLIST}  = {

	"actions" => ['-align','-align: do full multiple alignment','-profile','-profile: merge two alignments (PROFILE1 and 2) by profile or structure alignment','-sequences','-sequences: sequentially add PROFILE2 sequences to PROFILE1 alignment','-tree','-tree: calculate NJ tree','-bootstrap','-bootstrap: bootstrap a NJ tree',],
	"multalign" => ['quicktree','typeseq','matrix','dnamatrix','gapopen','gapext','endgaps','gapdist','pgap','hgap','hgapresidues','maxdiv','negative','transweight','newtree','usetree',],
	"quicktree" => ['slow','Slow','fast','Fast',],
	"typeseq" => ['protein','protein','dna','DNA',],
	"matrix" => ['gonnet','Gonnet series','blosum','BLOSUM series','pam','PAM series','id','Identity matrix',],
	"dnamatrix" => ['iub','IUB','clustalw','CLUSTALW',],
	"hgapresidues" => ['A','A','R','R','N','N','D','D','C','C','Q','Q','E','E','G','G','H','H','I','I','L','L','K','K','M','M','F','F','P','P','S','S','T','T','W','W','Y','Y','V','V',],
	"fastpw" => ['ktuple','topdiags','window','pairgap','score',],
	"score" => ['percent','percent','absolute','absolute',],
	"slowpw" => ['pwmatrix','pwdnamatrix','pwgapopen','pwgapext',],
	"pwmatrix" => ['blosum','BLOSUM30 (Henikoff)','gonnet','Gonnet 250','pam','PAM350 (Dayhoff)','id','Identity matrix',],
	"pwdnamatrix" => ['iub','IUB','clustalw','CLUSTALW',],
	"trees" => ['kimura','tossgaps','bootstrap','bootlabels','seed','outputtree',],
	"bootlabels" => ['node','NODE labels','branch','BRANCH labels',],
	"outputtree" => ['NJ','Clustal format','PHYLIP','Phylip format tree','DIST','Phylip format distance matrix','NEXUS','NEXUS format tree',],
	"outputparam" => ['outfile','output','gde_lower','outorder','seqnos',],
	"output" => ['','CLUSTALW','GCG','GCG','GDE','GDE','PHYLIP','PHYLIP','PIR','PIR','NEXUS','NEXUS',],
	"outorder" => ['input','input','aligned','aligned',],
	"profile" => ['profile1','profile2','usetree1','usetree2','newtree1','newtree2',],
	"structure" => ['nosecstr1','nosecstr2','helixgap','strandgap','loopgap','terminalgap','helixendin','helixendout','strandendin','strandendout','secstrout',],
	"secstrout" => ['STRUCTURE','Secondary Structure','MASK','Gap Penalty Mask','BOTH','Structure and Penalty Mask','NONE','None',],
    };

    $self->{FLIST}  = {

    };

    $self->{SEPARATOR}  = {
	"hgapresidues" => "''",

    };

    $self->{VDEF}  = {
	"actions" => '-align',
	"phylip_alig" => '0',
	"quicktree" => 'slow',
	"matrix" => 'gonnet',
	"dnamatrix" => 'iub',
	"gapopen" => '10.00',
	"gapext" => '0.20',
	"endgaps" => '1',
	"gapdist" => '8',
	"pgap" => '1',
	"hgap" => '1',
	"hgapresidues" => ['G','P','S','N','D','Q','E','K','R',],
	"maxdiv" => '30',
	"negative" => '0',
	"transweight" => '0.5',
	"ktuple" => '1',
	"topdiags" => '5',
	"window" => '5',
	"pairgap" => '3',
	"pwmatrix" => 'gonnet',
	"pwdnamatrix" => 'iub',
	"pwgapopen" => '10.00',
	"pwgapext" => '0.10',
	"kimura" => '0',
	"tossgaps" => '0',
	"bootstrap" => '1000',
	"bootlabels" => 'node',
	"outputtree" => 'PHYLIP',
	"output" => '""',
	"outorder" => 'aligned',
	"seqnos" => '0',
	"nosecstr1" => '1',
	"nosecstr2" => '1',
	"helixgap" => '4',
	"strandgap" => '4',
	"loopgap" => '1',
	"terminalgap" => '2',
	"helixendin" => '3',
	"helixendout" => '0',
	"strandendin" => '1',
	"strandendout" => '1',
	"secstrout" => 'STRUCTURE',

    };

    $self->{PRECOND}  = {
	"clustalw" => { "perl" => '1' },
	"infile" => {
		"perl" => '$actions ne "-profile" && $actions ne "-sequences"',
	},
	"actions" => { "perl" => '1' },
	"phylip_alig" => { "perl" => '1' },
	"multalign" => {
		"perl" => '($actions =~ /align/ )',
	},
	"quicktree" => {
		"perl" => '($actions =~ /align/ )',
	},
	"typeseq" => {
		"perl" => '($actions =~ /align/ )',
	},
	"matrix" => {
		"perl" => '($actions =~ /align/ )',
	},
	"dnamatrix" => {
		"perl" => '($actions =~ /align/ )',
	},
	"gapopen" => {
		"perl" => '($actions =~ /align/ )',
	},
	"gapext" => {
		"perl" => '($actions =~ /align/ )',
	},
	"endgaps" => {
		"perl" => '($actions =~ /align/ )',
	},
	"gapdist" => {
		"perl" => '($actions =~ /align/ )',
	},
	"pgap" => {
		"perl" => '($actions =~ /align/ )',
	},
	"hgap" => {
		"perl" => '($actions =~ /align/ )',
	},
	"hgapresidues" => {
		"perl" => '($actions =~ /align/ ) && $hgap',
	},
	"maxdiv" => {
		"perl" => '($actions =~ /align/ )',
	},
	"negative" => {
		"perl" => '($actions =~ /align/ )',
	},
	"transweight" => {
		"perl" => '($actions =~ /align/ )',
	},
	"newtree" => {
		"perl" => '($actions =~ /align/ )',
	},
	"usetree" => {
		"perl" => '($actions =~ /align/ )',
	},
	"fastpw" => {
		"perl" => '($quicktree eq "fast")',
	},
	"ktuple" => {
		"perl" => '($quicktree eq "fast") && ($quicktree eq "fast")',
	},
	"topdiags" => {
		"perl" => '($quicktree eq "fast") && ($quicktree eq "fast")',
	},
	"window" => {
		"perl" => '($quicktree eq "fast") && ($quicktree eq "fast")',
	},
	"pairgap" => {
		"perl" => '($quicktree eq "fast") && ($quicktree eq "fast")',
	},
	"score" => {
		"perl" => '($quicktree eq "fast") && ($quicktree eq "fast")',
	},
	"slowpw" => {
		"perl" => '($quicktree eq "slow")',
	},
	"pwmatrix" => {
		"perl" => '($quicktree eq "slow") && ($quicktree eq "slow")',
	},
	"pwdnamatrix" => {
		"perl" => '($quicktree eq "slow") && ($quicktree eq "slow")',
	},
	"pwgapopen" => {
		"perl" => '($quicktree eq "slow") && ($quicktree eq "slow")',
	},
	"pwgapext" => {
		"perl" => '($quicktree eq "slow") && ($quicktree eq "slow")',
	},
	"trees" => {
		"perl" => ' ($actions =~ /tree/) ',
	},
	"kimura" => {
		"perl" => ' ($actions =~ /tree/) ',
	},
	"tossgaps" => {
		"perl" => ' ($actions =~ /tree/) ',
	},
	"bootstrap" => {
		"perl" => ' ($actions =~ /tree/) ',
	},
	"bootlabels" => {
		"perl" => ' ($actions =~ /tree/) ',
	},
	"seed" => {
		"perl" => ' ($actions =~ /tree/) ',
	},
	"outputtree" => {
		"perl" => ' ($actions =~ /tree/) ',
	},
	"outputparam" => { "perl" => '1' },
	"outfile" => { "perl" => '1' },
	"output" => { "perl" => '1' },
	"gde_lower" => {
		"perl" => '$output eq "GDE"',
	},
	"outorder" => { "perl" => '1' },
	"seqnos" => {
		"perl" => '$output eq ""',
	},
	"aligfile" => { "perl" => '1' },
	"readseq_ok_aligfile" => {
		"perl" => '$output eq "GCG" || $output eq "PIR" || $output eq "PHYLIP" || $phylip_alig',
	},
	"newtreefile" => { "perl" => '1' },
	"phylipnewtreefile" => { "perl" => '1' },
	"profile" => {
		"perl" => '($actions =~ /profile|sequence/ )',
	},
	"profile1" => {
		"perl" => '($actions =~ /profile|sequence/ )',
	},
	"profile2" => {
		"perl" => '($actions =~ /profile|sequence/ )',
	},
	"usetree1" => {
		"perl" => '($actions =~ /profile|sequence/ )',
	},
	"usetree2" => {
		"perl" => '($actions =~ /profile|sequence/ ) && (! $actions =~ /sequence/ )',
	},
	"newtree1" => {
		"perl" => '($actions =~ /profile|sequence/ )',
	},
	"newtree2" => {
		"perl" => '($actions =~ /profile|sequence/ ) && (! $actions =~ /sequence/ )',
	},
	"structure" => {
		"perl" => '($actions =~ /profile|sequence/ )',
	},
	"nosecstr1" => {
		"perl" => '($actions =~ /profile|sequence/ )',
	},
	"nosecstr2" => {
		"perl" => '($actions =~ /profile|sequence/ )',
	},
	"helixgap" => {
		"perl" => '($actions =~ /profile|sequence/ )',
	},
	"strandgap" => {
		"perl" => '($actions =~ /profile|sequence/ )',
	},
	"loopgap" => {
		"perl" => '($actions =~ /profile|sequence/ )',
	},
	"terminalgap" => {
		"perl" => '($actions =~ /profile|sequence/ )',
	},
	"helixendin" => {
		"perl" => '($actions =~ /profile|sequence/ )',
	},
	"helixendout" => {
		"perl" => '($actions =~ /profile|sequence/ )',
	},
	"strandendin" => {
		"perl" => '($actions =~ /profile|sequence/ )',
	},
	"strandendout" => {
		"perl" => '($actions =~ /profile|sequence/ )',
	},
	"secstrout" => {
		"perl" => '($actions =~ /profile|sequence/ )',
	},

    };

    $self->{CTRL}  = {

    };

    $self->{PIPEOUT}  = {
	"outfile" => {
		 '1' => "readseq_ok_alig",
	},
	"aligfile" => {
		 '1' => "readseq_ok_alig",
	},
	"readseq_ok_aligfile" => {
		 '1' => "readseq_ok_alig",
	},
	"phylipnewtreefile" => {
		 '1' => "phylip_tree",
	},

    };

    $self->{WITHPIPEOUT}  = {

    };

    $self->{PIPEIN}  = {
	"infile" => {
		 "seqsfile" => '1',
		 "readseq_ok_alig" => '1',
	},

    };

    $self->{WITHPIPEIN}  = {

    };

    $self->{ISCLEAN}  = {
	"clustalw" => 0,
	"infile" => 0,
	"actions" => 0,
	"phylip_alig" => 0,
	"multalign" => 0,
	"quicktree" => 0,
	"typeseq" => 0,
	"matrix" => 0,
	"dnamatrix" => 0,
	"gapopen" => 0,
	"gapext" => 0,
	"endgaps" => 0,
	"gapdist" => 0,
	"pgap" => 0,
	"hgap" => 0,
	"hgapresidues" => 0,
	"maxdiv" => 0,
	"negative" => 0,
	"transweight" => 0,
	"newtree" => 0,
	"usetree" => 0,
	"fastpw" => 0,
	"ktuple" => 0,
	"topdiags" => 0,
	"window" => 0,
	"pairgap" => 0,
	"score" => 0,
	"slowpw" => 0,
	"pwmatrix" => 0,
	"pwdnamatrix" => 0,
	"pwgapopen" => 0,
	"pwgapext" => 0,
	"trees" => 0,
	"kimura" => 0,
	"tossgaps" => 0,
	"bootstrap" => 0,
	"bootlabels" => 0,
	"seed" => 0,
	"outputtree" => 0,
	"outputparam" => 0,
	"outfile" => 0,
	"output" => 0,
	"gde_lower" => 0,
	"outorder" => 0,
	"seqnos" => 0,
	"aligfile" => 0,
	"readseq_ok_aligfile" => 0,
	"newtreefile" => 0,
	"phylipnewtreefile" => 0,
	"profile" => 0,
	"profile1" => 0,
	"profile2" => 0,
	"usetree1" => 0,
	"usetree2" => 0,
	"newtree1" => 0,
	"newtree2" => 0,
	"structure" => 0,
	"nosecstr1" => 0,
	"nosecstr2" => 0,
	"helixgap" => 0,
	"strandgap" => 0,
	"loopgap" => 0,
	"terminalgap" => 0,
	"helixendin" => 0,
	"helixendout" => 0,
	"strandendin" => 0,
	"strandendout" => 0,
	"secstrout" => 0,

    };

    $self->{ISSIMPLE}  = {
	"clustalw" => 0,
	"infile" => 1,
	"actions" => 0,
	"phylip_alig" => 1,
	"multalign" => 0,
	"quicktree" => 1,
	"typeseq" => 0,
	"matrix" => 0,
	"dnamatrix" => 0,
	"gapopen" => 0,
	"gapext" => 0,
	"endgaps" => 0,
	"gapdist" => 0,
	"pgap" => 0,
	"hgap" => 0,
	"hgapresidues" => 0,
	"maxdiv" => 0,
	"negative" => 0,
	"transweight" => 0,
	"newtree" => 0,
	"usetree" => 0,
	"fastpw" => 0,
	"ktuple" => 0,
	"topdiags" => 0,
	"window" => 0,
	"pairgap" => 0,
	"score" => 0,
	"slowpw" => 0,
	"pwmatrix" => 0,
	"pwdnamatrix" => 0,
	"pwgapopen" => 0,
	"pwgapext" => 0,
	"trees" => 0,
	"kimura" => 0,
	"tossgaps" => 0,
	"bootstrap" => 0,
	"bootlabels" => 0,
	"seed" => 0,
	"outputtree" => 0,
	"outputparam" => 0,
	"outfile" => 0,
	"output" => 0,
	"gde_lower" => 0,
	"outorder" => 0,
	"seqnos" => 0,
	"aligfile" => 0,
	"readseq_ok_aligfile" => 0,
	"newtreefile" => 0,
	"phylipnewtreefile" => 0,
	"profile" => 0,
	"profile1" => 0,
	"profile2" => 0,
	"usetree1" => 0,
	"usetree2" => 0,
	"newtree1" => 0,
	"newtree2" => 0,
	"structure" => 0,
	"nosecstr1" => 0,
	"nosecstr2" => 0,
	"helixgap" => 0,
	"strandgap" => 0,
	"loopgap" => 0,
	"terminalgap" => 0,
	"helixendin" => 0,
	"helixendout" => 0,
	"strandendin" => 0,
	"strandendout" => 0,
	"secstrout" => 0,

    };

    $self->{PARAMFILE}  = {

    };

    $self->{COMMENT}  = {
	"multalign" => [
		"Multiple alignments are carried out in 3 stages :",
		"1) all sequences are compared to each other (pairwise alignments);",
		"2) a dendrogram (like a phylogenetic tree) is constructed, describing the approximate groupings of the sequences by similarity (stored in a file).",
		"3) the final multiple alignment is carried out, using the dendrogram as a guide.",
		"Pairwise alignment parameters control the speed/sensitivity of the initial alignments.",
		"Multiple alignment parameters control the gaps in the final multiple alignments.",
	],
	"quicktree" => [
		"slow: by dynamic programming (slow but accurate)",
		"fast: method of Wilbur and Lipman (extremely fast but approximate)",
	],
	"matrix" => [
		"There are three \'in-built\' series of weight matrices offered. Each consists of several matrices which work differently at different evolutionary distances. To see the exact details, read the documentation. Crudely, we store several matrices in memory, spanning the full range of amino acid distance (from almost identical sequences to highly divergent ones). For very similar sequences, it is best to use a strict weight matrix which only gives a high score to identities and the most favoured conservative substitutions. For more divergent sequences, it is appropriate to use \'softer\' matrices which give a high score to many other frequent substitutions.",
		"BLOSUM (Henikoff). These matrices appear to be the best available for carrying out data base similarity (homology searches). The matrices used are: Blosum80, 62, 40 and 30.",
		"The Gonnet Pam 250 matrix has been reported as the best single matrix for alignment, if you only choose one matrix. Our experience with profile database searches is that the Gonnet series is unambiguously superior to the Blosum series at high divergence. However, we did not get the series to perform systematically better than the Blosum series in Clustal W (communication of the authors).",
		"PAM (Dayhoff). These have been extremely widely used since the late \'70s. We use the PAM 120, 160, 250 and 350 matrices.",
	],
	"dnamatrix" => [
		"1) IUB. This is the default scoring matrix used by BESTFIT for the comparison of nucleic acid sequences. X\'s and N\'s are treated as matches to any IUB ambiguity symbol. All matches score 1.9; all mismatches for IUB symbols score 0.",
		"2) CLUSTALW(1.6). The previous system used by ClustalW, in which matches score 1.0 and mismatches score 0. All matches for IUB symbols also score 0.",
	],
	"gapopen" => [
		"",
	],
	"endgaps" => [
		"End gap separation treats end gaps just like internal gaps for the purposes of avoiding gaps that are too close (set by GAP SEPARATION DISTANCE above). If you turn this off, end gaps will be ignored for this purpose. This is useful when you wish to align fragments where the end gaps are not biologically meaningful.",
	],
	"gapdist" => [
		"Gap separation distance tries to decrease the chances of gaps being too close to each other. Gaps that are less than this distance apart are penalised more than other gaps. This does not prevent close gaps; it makes them less frequent, promoting a block-like appearance of the alignment.",
	],
	"pgap" => [
		"Residue specific penalties are amino acid specific gap penalties that reduce or increase the gap opening penalties at each position in the alignment or sequence. As an example, positions that are rich in glycine are more likely to have an adjacent gap than positions that are rich in valine.",
		"Table of residue specific gap modification factors:",
		"A 1.13 M 1.29",
		"C 1.13 N 0.63",
		"D 0.96 P 0.74",
		"E 1.31 Q 1.07",
		"F 1.20 R 0.72",
		"G 0.61 S 0.76",
		"H 1.00 T 0.89",
		"I 1.32 V 1.25",
		"K 0.96 Y 1.00",
		"L 1.21 W 1.23",
		"The values are normalised around a mean value of 1.0 for H. The lower the value, the greater the chance of having an adjacent gap. These are derived from the original table of relative frequencies of gaps adjacent to each residue (12) by subtraction from 2.0.",
	],
	"hgap" => [
		"Hydrophilic gap penalties are used to increase the chances of a gap within a run (5 or more residues) of hydrophilic amino acids; these are likely to be loop or random coil regions where gaps are more common. The residues that are \'considered\' to be hydrophilic are set by menu item 3.",
	],
	"maxdiv" => [
		"Delays the alignment of the most distantly related sequences until after the most closely related sequences have been aligned. The setting shows the percent identity level required to delay the addition of a sequence; sequences that are less identical than this level to any other sequences will be aligned later.",
	],
	"transweight" => [
		"The transition weight option for aligning nucleotide sequences has been changed in version 1.7 from an on/off toggle to a weight between 0 and 1. A weight of zero means that the transitions are scored as mismatches; a weight of 1 gives transitions the full match score. For distantly related DNA sequences, the weight should be near to zero; for closely related sequences it can be useful to assign a higher score.",
	],
	"usetree" => [
		"You can give a previously computed tree (.dnd file) - on the same data",
	],
	"fastpw" => [
		"These similarity scores are calculated from fast, approximate, global alignments, which are controlled by 4 parameters. 2 techniques are used to make these alignments very fast: 1) only exactly matching fragments (k-tuples) are considered; 2) only the \'best\' diagonals (the ones with most k-tuple matches) are used.",
	],
	"ktuple" => [
		"K-TUPLE SIZE: This is the size of exactly matching fragment that is used. INCREASE for speed (max= 2 for proteins; 4 for DNA), DECREASE for sensitivity. For longer sequences (e.g. >1000 residues) you may need to increase the default.",
	],
	"topdiags" => [
		"The number of k-tuple matches on each diagonal (in an imaginary dot-matrix plot) is calculated. Only the best ones (with most matches) are used in the alignment. This parameter specifies how many. Decrease for speed; increase for sensitivity.",
	],
	"window" => [
		"WINDOW SIZE: This is the number of diagonals around each of the \'best\' diagonals that will be used. Decrease for speed; increase for sensitivity",
	],
	"pairgap" => [
		"This is a penalty for each gap in the fast alignments. It has little affect on the speed or sensitivity except for extreme values.",
	],
	"slowpw" => [
		"These parameters do not have any affect on the speed of the alignments. They are used to give initial alignments which are then rescored to give percent identity scores. These % scores are the ones which are displayed on the screen. The scores are converted to distances for the trees.",
	],
	"pwmatrix" => [
		"The scoring table which describes the similarity of each amino acid to each other. For DNA, an identity matrix is used.",
		"BLOSUM (Henikoff). These matrices appear to be the best available for carrying out data base similarity (homology searches). The matrices used are: Blosum80, 62, 40 and 30.",
		"The Gonnet Pam 250 matrix has been reported as the best single matrix for alignment, if you only choose one matrix. Our experience with profile database searches is that the Gonnet series is unambiguously superior to the Blosum series at high divergence. However, we did not get the series to perform systematically better than the Blosum series in Clustal W (communication of the authors).",
		"PAM (Dayhoff). These have been extremely widely used since the late \'70s. We use the PAM 120, 160, 250 and 350 matrices.",
	],
	"pwdnamatrix" => [
		"For DNA, a single matrix (not a series) is used. Two hard-coded matrices are available:",
		"1) IUB. This is the default scoring matrix used by BESTFIT for the comparison of nucleic acid sequences. X\'s and N\'s are treated as matches to any IUB ambiguity symbol. All matches score 1.9; all mismatches for IUB symbols score 0.",
		"2) CLUSTALW(1.6). The previous system used by ClustalW, in which matches score 1.0 and mismatches score 0. All matches for IUB symbols also score 0.",
	],
	"trees" => [
		"If you ask for an alignment, the program automatic computes the tree as well; but you can also ask for a tree, given an alignment (file .aln), with specific options.",
		"The method used is the NJ (Neighbour Joining) method of Saitou and Nei. First you calculate distances (percent divergence) between all pairs of sequence from a multiple alignment; second you apply the NJ method to the distance matrix.",
	],
	"kimura" => [
		"For small divergence (say <10%) this option makes no difference. For greater divergence, this option corrects for the fact that observed distances underestimate actual evolutionary distances. This is because, as sequences diverge, more than one substitution will happen at many sites. However, you only see one difference when you look at the present day sequences. Therefore, this option has the effect of stretching (for DNA or proteins) are both due to Motoo Kimura. See the documentation for details. ",
		"For VERY divergent sequences, the distances cannot be reliably corrected. You will be warned if this happens. Even if none of the distances in a data set exceed the reliable threshold, if you bootstrap the data, some of the bootstrap distances may randomly exceed the safe limit.",
	],
	"tossgaps" => [
		"With this option, any alignment positions where ANY of the sequences have a gap will be ignored. This means that \'like\' will be compared to \'like\' in all distances. It also, automatically throws away the most ambiguous parts of the alignment, which are concentrated around gaps (usually). The disadvantage is that you may throw away much of the data if there are many gaps. ",
	],
	"bootstrap" => [
		"BOOTSTRAPPING is a method for deriving confidence values for the groupings in a tree (first adapted for trees by Joe Felsenstein). It involves making N random samples of sites from the alignment (N should be LARGE, e.g. 500 - 1000); drawing N trees (1 from each sample) and counting how many times each grouping from the original tree occurs in the sample trees. You must supply a seed number for the random number generator. Different runs with the same seed will give the same answer. See the documentation for details.",
	],
	"bootlabels" => [
		"The bootstrap values written in the phylip tree file format can be assigned either to branches or nodes. The default is to write the values on the nodes, as this can be read by several commonly-used tree display programs. But note that this can lead to confusion if the tree is rooted and the bootstraps may be better attached to the internal branches: Software developers should ensure they can read the branch label format.",
	],
	"outputtree" => [
		"Clustal format output: This format is verbose and lists all of the distances between the sequences and the number of alignment positions used for each. The tree is described at the end of the file. It lists the sequences that are joined at each alignment step and the branch lengths. After two sequences are joined, it is referred to later as a NODE. The number of a NODE is the number of the lowest sequence in that NODE. ",
		"Phylip format tree output: This format is the New Hampshire format, used by many phylogenetic analysis packages. It consists of a series of nested parentheses, describing the branching order, with the sequence names and branch lengths. It can be used by the RETREE, DRAWGRAM and DRAWTREE programs of the PHYLIP package to see the trees graphically. This is the same format used during multiple alignment for the guide trees. ",
		"The distance matrix only: This format just outputs a matrix of all the pairwise distances in a format that can be used by the Phylip package. It used to be useful when one could not produce distances from protein sequences in the Phylip package but is now redundant (Protdist of Phylip 3.5 now does this). ",
		"NEXUS format tree:  This format is used by several popular phylogeny programs, including PAUP and MacClade. ",
	],
	"profile" => [
		"By PROFILE ALIGNMENT, we mean alignment using existing alignments. Profile alignments allow you to store alignments of your favourite sequences and add new sequences to them in small bunches at a time. A profile is simply an alignment of one or more sequences (e.g. an alignment output file from CLUSTAL W). Each input can be a single sequence. One or both sets of input sequences may include secondary structure assignments or gap penalty masks to guide the alignment.",
		"Give 2 profiles to align the 2 profiles to each other",
	],
	"structure" => [
		"These options, when doing a profile alignment, allow you to set 2D structure parameters. If a solved structure is available, it can be used to guide the alignment by raising gap penalties within secondary structure elements, so that gaps will preferentially be inserted into unstructured surface loops. Alternatively, a user-specified gap penalty mask can be supplied directly.",
		"A gap penalty mask is a series of numbers between 1 and 9, one per position in the alignment. Each number specifies how much the gap opening penalty is to be raised at that position (raised by multiplying the basic gap opening penalty by the number) i.e. a mask figure of 1 at a position means no change in gap opening penalty; a figure of 4 means that the gap opening penalty is four times greater at that position, making gaps 4 times harder to open.",
		"Gap penalty masks is to be supplied with the input sequences. The masks work by raising gap penalties in specified regions (typically secondary structure elements) so that gaps are preferentially opened in the less well conserved regions (typically surface loops).",
		"CLUSTAL W can read the masks from SWISS-PROT, CLUSTAL or GDE format input files. For many 3-D protein structures, secondary structure information is recorded in the feature tables of SWISS-PROT database entries. You should always check that the assignments are correct - some are quite inaccurate. CLUSTAL W looks for SWISS-PROT HELIX and STRAND assignments e.g.",
		"FT   HELIX       100    115",
		"FT   HELIX       100    115",
		"The structure and penalty masks can also be read from CLUSTAL alignment format as comment lines beginning !SS_ or GM_ e.g.",
		"!SS_HBA_HUMA    ..aaaAAAAAAAAAAaaa.aaaAAAAAAAAAAaaaaaaAaaa.........aaaAAAAAA",
		"!GM_HBA_HUMA    112224444444444222122244444444442222224222111111111222444444",
		"HBA_HUMA        VLSPADKTNVKAAWGKVGAHAGEYGAEALERMFLSFPTTKTYFPHFDLSHGSAQVKGHGK",
		"Note that the mask itself is a set of numbers between 1 and 9 each of which is assigned to the residue(s) in the same column below. In GDE flat file format, the masks are specified as text and the names must begin with SS_ or GM_. Either a structure or penalty mask or both may be used. If both are included in an alignment, the user will be asked which is to be used.",
	],
	"nosecstr1" => [
		"This option controls whether the input secondary structure information or gap penalty masks will be used.",
	],
	"nosecstr2" => [
		"This option controls whether the input secondary structure information or gap penalty masks will be used.",
	],
	"helixgap" => [
		"This option provides the value for raising the gap penalty at core Alpha Helical (A) residues. In CLUSTAL format, capital residues denote the A and B core structure notation. The basic gap penalties are multiplied by the amount specified.",
	],
	"strandgap" => [
		"This option provides the value for raising the gap penalty at Beta Strand (B) residues. In CLUSTAL format, capital residues denote the A and B core structure notation. The basic gap penalties are multiplied by the amount specified.",
	],
	"loopgap" => [
		"This option provides the value for the gap penalty in Loops. By default this penalty is not raised. In CLUSTAL format, loops are specified by . in the secondary structure notation.",
	],
	"terminalgap" => [
		"This option provides the value for setting the gap penalty at the ends of secondary structures. Ends of secondary structures are observed to grow and-or shrink in related structures. Therefore by default these are given intermediate values, lower than the core penalties. All secondary structure read in as lower case in CLUSTAL format gets the reduced terminal penalty.",
	],
	"helixendin" => [
		"This option (together with the -helixendin) specify the range of structure termini for the intermediate penalties. In the alignment output, these are indicated as lower case. For Alpha Helices, by default, the range spans the end helical turn.",
	],
	"helixendout" => [
		"This option (together with the -helixendin) specify the range of structure termini for the intermediate penalties. In the alignment output, these are indicated as lower case. For Alpha Helices, by default, the range spans the end helical turn.",
	],
	"strandendin" => [
		"This option (together with the -strandendout option) specify the range of structure termini for the intermediate penalties. In the alignment output, these are indicated as lower case. For Beta Strands, the default range spans the end residue and the adjacent loop residue, since sequence conservation often extends beyond the actual H-bonded Beta Strand.",
	],
	"strandendout" => [
		"This option (together with the -strandendin option) specify the range of structure termini for the intermediate penalties. In the alignment output, these are indicated as lower case. For Beta Strands, the default range spans the end residue and the adjacent loop residue, since sequence conservation often extends beyond the actual H-bonded Beta Strand.",
	],
	"secstrout" => [
		"This option lets you choose whether or not to include the masks in the CLUSTAL W output alignments. Showing both is useful for understanding how the masks work. The secondary structure information is itself very useful in judging the alignment quality and in seeing how residue conservation patterns vary with secondary structure.",
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

# -- end of definitions extracted from /local/gensoft/lib/Pise/5.a/PerlDef/clustalw.pm



    $self->_init_params(@params);

    return $self;
}



1; # Needed to keep compiler happy

