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

  bioperl-l@bioperl.org                     - General discussion
  http://bio.perl.org/MailList.html         - About the mailing lists

=head2 Reporting Bugs

 Report bugs to the Bioperl bug tracking system to help us keep track
 the bugs and their resolution.  Bug reports can be submitted via
 email or the web:

  bioperl-bugs@bio.perl.org
  http://bugzilla.bioperl.org/

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

use vars qw(%Menu %FileName);

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
