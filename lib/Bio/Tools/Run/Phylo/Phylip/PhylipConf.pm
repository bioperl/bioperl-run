# BioPerl module for Bio::Tools::Run::Phylo::Phylip::PhylipConf
#
# Created by
#
# Shawn Hoon
#
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Phylo::Phylip::PhylipConf

=head1 SYNOPSIS

  use Bio::Tools::Run::Phylo::Phylip::PhylipConf;
  my %menu = %{$Bio::Tools::Run::Phylo::Phylip::PhylipConf::Menu->{$version}->{'PROTDIST'}};

=head1 DESCRIPTION

A configuration for managing menu configuration differences 
between version 3.5 and 3.6

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists.  Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support 

Please direct usage questions or support issues to the mailing list:

I<bioperl-l@bioperl.org>

rather than to the module maintainer directly. Many experienced and 
reponsive experts will be able look at the problem and quickly 
address it. Please include a thorough description of the problem 
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
the bugs and their resolution.  Bug reports can be submitted via the
web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Shawn Hoon

Email shawnh@fugu-sg.org

=head1 CONTRIBUTORS

Email:jason-at-bioperl.org

=head1 APPENDIX

The rest of the documentation details each of the object
methods. Internal methods are usually preceded with a _

=cut

#'

package Bio::Tools::Run::Phylo::Phylip::PhylipConf;

use strict;
use Exporter;
use vars qw(@ISA %Menu %FileName $RESOLUTIONX $RESOLUTIONY @EXPORT_OK);
use base 'Exporter';

$RESOLUTIONX = 300;
$RESOLUTIONY = 300;

@EXPORT_OK = qw(%FileName %Menu);

%FileName = (
              "3.5"=>{'OUTFILE'=>'outfile',
                      'TREEFILE'=>'treefile',
                      'PLOTFILE'=>'plotfile',
                     },
              "3.6"=>{'OUTFILE'=>'outfile',
                      'TREEFILE'=>'outtree',
                      'PLOTFILE'=>'plotfile',
                     },
);
                      
%Menu = 
    (
     "3.5" => {
	 'PROTDIST' => {
	     'MODEL'  => {
		 'CAT'   =>"P\nP\n",
		 'KIMURA'=>"P\n",
	     },
	     'GENCODE'=>  {
		 'ALLOWED'=>"UMVFY",
		 'OPTION' =>"C\n",
	     },
	     'CATEGORY'=>{
		 'ALLOWED'=>"CHG",
		 'OPTION' =>"A\n",
	     },
	     'PROBCHANGE'=>"E\n",
	     'TRANS'     =>"T\n",
	     'FREQ'      =>"F\n",
	     'SUBMIT'    =>"Y\n",
	     'MULTIPLE'  =>"M\n",
	 },
	 'NEIGHBOR'=>{  
	     'TYPE'    => {
		 'UPGMA'=>"N\n",
	     },
	     'OUTGROUP'=>"O\n",
	     'LOWTRI'  =>"L\n",
	     'UPPTRI'  =>"R\n",
	     'SUBREP'  =>"S\n",
	     'JUMBLE'  =>"J\n",
	     'SUBMIT'    =>"Y\n",
	     'MULTIPLE'  =>"M\n",
	 },	 
	 'PROTPARS'=>{  
	     'THRESHOLD'=>"T\n",
	     'JUMBLE'   =>"J\n",
	     'OUTGROUP' =>"O\n",
	     'SUBMIT'   =>"Y\n",
	 },
	 
	 'SEQBOOT'=>{   
	     'DATATYPE' =>{
		 'SEQUENCE'=>"",
		 'MORPH'   =>"D\n",
		 'REST'    =>"D\nD\n",
		 'GENEFREQ'=>"D\nD\nD\n",
	     },
	     'ALLELES'  => "A\n",
	     'PERMUTE'  => {
		 'BOOTSTRAP'=>"",
		 'JACKKNIFE'=>"J\n",
		 'PERMUTE'  =>"J\nJ\n",
	     },
	     'REPLICATES'=>"R\n",
	     'SUBMIT'    =>"Y\n",
	 },
	 'CONSENSE'=>{  
	     'ROOTED'   => "R\n",
	     'OUTGROUP' => "O\n",
	     'SUBMIT'    =>"Y\n",
	 },
     },	 
     "3.6"=>{
	 'PROTDIST'=>{
	     'MODEL'  => {
		 'PMB'        =>"P\n",
		 'PAM'        =>"P\nP\n",
		 'KIMURA'     =>"P\nP\nP\n",
		 'CAT'        =>"P\nP\nP\nP\n",
		 'JTT'        =>"Y\n",
	     },
	     'GENCODE'=>  {
		 'ALLOWED'=>"UMVFY",
		 'OPTION' =>"U\n",
	     },
	     'CATEGORY'=> {
		 'ALLOWED'=>"CHG",
		 'OPTION' =>"A\n",
	     },
	     'PROBCHANGE'=>"E\n",
	     'TRANS'     =>"T\n",
	     'FREQ'      =>"F\n",
	     'WEIGHTS'   =>"W\n",
	     'SUBMIT'    => "Y\n",
	     'MULTIPLE'  =>"M\nD\n",
	 },
	 'NEIGHBOR' => { 
	     'TYPE'    => {
		 'UPGMA'=>"N\n",
	     },
	     'OUTGROUP'=>"O\n",
	     'LOWTRI'  =>"L\n",
	     'UPPTRI'  =>"R\n",
	     'SUBREP'  =>"S\n",
	     'JUMBLE'  =>"J\n",
	     'SUBMIT'    =>"Y\n",
	     'MULTIPLE'  =>"M\n",
	 },
	 'PROTPARS' => {  
	     'THRESHOLD'=>"T\n",
	     'JUMBLE'   =>"J\n",
	     'OUTGROUP' =>"O\n",
	     'SUBMIT'   =>"Y\n",
	 },
	 'DRAWGRAM' => {
	     'SCALE'             => "R\n",
	     'HORIZMARGINS'      => "M\n%.2f\n%.2f\n",
	     'VERTICALMARGINS'   => "M\n%.2f\n%.2f",	     
	     'SCREEN' => { 
		 'Y|YES|1' => "V\nX\n",
		 'N|NO|0'  => "V\nN\n",
	     },
	     'FONT'         => "F\n%s\n",
	     'PAGES'        => {
		 'L|PAGES|SIZE'       => "#\nL\n%d\n%d\nM\n",
		 'P|PHYSICAL'         => "#\nP\n%.4f\n%.4f\nM\n",
		 'O|OVERLAP'          => "#\nO\n%.4f\n%.4f\nM\n",
	     },
	     'PLOTTER' => {
		 'P|POSTSCRIPT'     => "P\nL\n",
		 'PICT'             => "P\nM\n",
		 "HP|PCL|LaserJect" => "P\nJ\n", 
		 "BMP"              => "P\nW\n$RESOLUTIONX\n$RESOLUTIONY",
		 "FIG"              => "P\nF\n",
		 "IDRAW"            => "P\nA\n",
		 "VRML"             => "P\nZ\n",
		 "PCX"              => "P\nP\n3\n",		 
	     },
	     'ANCESTRALNODES'  => {
		 'I|INTER|INTERMEDIETE' => "A\nI\n",
		 'W|WEIGHTED'           => "A\nW\n",
		 'C|CENT|CENTERED'      => "A\nC\n",
		 'N|INNER|INNERMOST'    => "A\nN\n",
		 'V'                    => "A\nV\n",
	     },
	     'TREESTYLE' => {
		 'C|CLAD|CLADOGRAM'      => "S\nC\n",
		 'P|PHEN|PHENOGRAM'      => "S\nP\n",
		 'V|CURV|CURVOGRAM'    => "S\nV\n",
		 'E|EURO|EUROGRAM'     => "S\nE\n",
		 'S|SWOOP|SWOOPOGRAM'  => "S\nS\n",
		 'O|CIRC|CIRCULAR'   => "S\nO\n",		 
	     },
	     'TIPSPACE'      => "C\n%.4f\n",
	     'STEMLEN'       => "T\n%.4f\n",
	     'TREEDEPTH'     => "D\n%.4f\n",
	     'LABEL_ANGLE'   => "L\n%.4f\n",
	     'USEBRANCHLENS' => {
		 '1|Y|YES'   => "",
		 '0|N|NO'    => "B\n",
	     },	 
	 },
	 'DRAWTREE' => {
	     'SCREEN' => { 
		 'Y|YES|1' => "V\nX\n",
		 'N|NO|0'  => "V\nN\n",
	     },	     
	     'PLOTTER'           => {
		 'L|P|POSTSCRIPT'     => "P\nL\n",
		 'PICT'             => "P\nM\n",
		 "HP|PCL|LaserJect" => "P\nJ\n", 
		 "BMP"              => "P\nW\n$RESOLUTIONX\n$RESOLUTIONY",
		 "FIG"              => "P\nF\n",
		 "IDRAW"            => "P\nA\n",
		 "VRML"             => "P\nZ\n",
		 "PCX"              => "P\nP\n3\n",		 
	     },
	     'LABEL_ANGLE'       => {
		 'F|FIXED'         => "L\nF\n%d\n",
		 'R|RADIAL'        => "L\nR\n",
		 'A|ALONG'         => "L\nA\n",
		 'M|MIDDLE'        => "L\nM\n",
	     },
	     'ROTATION'            => "R\n%d\n",
	     'ITERATE'             => {
		 'E|EQUAL|DAYLIGHT' => "",
		 'N|NBODY|N-BODY'   => "I\n",
		 'NO|FALSE'         => "I\nI\n",		 
	     },
	     'TREEARC'             => "I\nI\nA\n%d\n",
	     'SCALE'               => "S\n%.2f\n",	     
	     'PAGES'        => {
		 'L|PAGES|SIZE'       => "#\nL\n%d\n%d\nM\n",
		 'P|PHYSICAL'         => "#\nP\n%.4f\n%.4f\nM\n",
		 'O|OVERLAP'          => "#\nO\n%.4f\n%.4f\nM\n",
	     },	     
	     'HORIZMARGINS'      => "M\n%.2f\n%.2f\n",
	     'VERTICALMARGINS'   => "M\n%.2f\n%.2f",
	 },
	 'SEQBOOT'=>{   
	     'DATATYPE' => {
		 'SEQUENCE'=> "",
		 'MORPH'   =>"D\n",
		 'REST'    =>"D\nD\n",
		 'GENEFREQ'=>"D\nD\nD\n",
	     },
	     'ALLELES'  => "A\n",
	     'PERMUTE'  => {
		 'BOOTSTRAP'=>"",
		 'JACKKNIFE'=>"J\n",
		 'PERMUTE'  =>"J\nJ\n",
	     },
	     'REPLICATES'=>"R\n",
	     'SUBMIT'   =>"Y\n",
	 },      
	 'CONSENSE'=>{  
	     'TYPE'     => {
		 'MRE'     =>"",
		 'STRICT'  =>"C\n",
		 'MR'      =>"C\nC\n",
		 'ML'      =>"C\nC\nC\n",
	     },
	     'ROOTED'   => "R\n",
	     'OUTGROUP' => "O\n",
	     'SUBMIT'    =>"Y\n",
	 },
     },
     );

1;
