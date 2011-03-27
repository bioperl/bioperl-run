# $Id: Ensembl.pm,v 1.6 2006/07/17 14:16:53 sendu Exp $
#
# BioPerl module for Bio::Tools::Run::Ensembl
#
# Please direct questions and support issues to <bioperl-l@bioperl.org> 
#
# Cared for by Sendu Bala <bix@sendu.me.uk>
#
# Copyright Sendu Bala
# 
# You may distribute this module under the same terms as perl itself

# POD documentation - main docs before the code

=head1 NAME

Bio::Tools::Run::Ensembl - A simplified front-end for setting up the registry
                           for, and then using an Ensembl database with the
                           Ensembl Perl API.

=head1 SYNOPSIS

  use Bio::Tools::Run::Ensembl;
  
  # get a Bio::EnsEMBL::Gene for agene of interest
  my $gene = Bio::Tools::Run::Ensembl->get_gene_by_name(-species => 'human',
                                                        -name => 'BRCA2');

=head1 DESCRIPTION

This is a simple way of accessing the Ensembl database to retrieve gene
information. Rather than learn the whole Ensembl Perl API, you only need to
install it (that is, check it out from CVS:
http://www.ensembl.org/info/docs/api/api_installation.html
- ignore the information about BioPerl version) and then you can get information
about a gene using get_gene_by_name().

For gene retrieval it is especially useful compared to direct Ensembl Perl API
usage since it can use information from alternate data sources (orthologues,
Swissprot, Entrez) to get your gene.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to the
Bioperl mailing list.  Your participation is much appreciated.

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
of the bugs and their resolution. Bug reports can be submitted via the
web:

  http://redmine.open-bio.org/projects/bioperl/

=head1 AUTHOR - Sendu Bala

Email bix@sendu.me.uk

=head1 APPENDIX

The rest of the documentation details each of the object methods.
Internal methods are usually preceded with a _

=cut

# Let the code begin...

package Bio::Tools::Run::Ensembl;
use strict;

use Bio::WebAgent;
use Bio::DB::EUtilities;

use base qw(Bio::Root::Root);

our $ENSEMBL_INSTALLED;
our $NODB;
our $LOADED_STR;
our $TOTAL = 0;
our $ORTHS = 0;
our $SWISS = 0;
our $NCBI = 0;
our $BAD = 0;
our $GOOD = 0;

BEGIN {
    eval {
        require Bio::EnsEMBL::Registry;
    };
    $ENSEMBL_INSTALLED = ! $@;
    $NODB = 0;
    $LOADED_STR = '';
}

=head2 registry_setup

 Title   : registry_setup
 Usage   : Bio::Tools::Run::Ensembl->registry_setup(-host => $host,
                                                    -user => $user);
           if (Bio::Tools::Run::Ensembl->registry_setup) {...}
 Function: Configure the ensembl registy to use a certain database.
           The database must be an Ensembl database compatible with the
           Ensembl Perl API, and you must have that API installed for this
           method to return true. Defaults to anonymous access to
           ensembldb.ensembl.org
           Or just ask if the registry is setup and the database ready to use.
 Returns : boolean (true if Registry loaded and ready to use)
 Args    : -host    => host name (defaults to 'ensembldb.ensembl.org')
           -user    => username (defaults to 'anonymous')
           -pass    => password (no default)
           -port    => port (defaults to 3306)
           -db_version => version of ensembl database to use, if different from
                          your installed Ensembl modules
           -verbose => boolean (1 to print messages during database connection)
           -no_database => boolean (1 to disable database access, causing this
                           method to always return false)

=cut

sub registry_setup {
    return 0 unless $ENSEMBL_INSTALLED;
    my $class = shift;
    my ($host, $user, $pass, $port, $verbose, $no_db, $db_version) =
        $class->_rearrange([qw(HOST USER PASS PORT VERBOSE NO_DATABASE DB_VERSION)], @_);
    $host ||= 'ensembldb.ensembl.org';
    $user ||= 'anonymous';
    
    $NODB = $no_db if defined($no_db);
    return 0 if $NODB;
    
    my $load_str = $host.$user. (defined $pass ? $pass : '') . (defined $port ? $port : '');
    unless ($LOADED_STR eq $load_str) {
        Bio::EnsEMBL::Registry->load_registry_from_db(-host => $host,
                                                      -user => $user,
                                                      defined $pass ? (-pass => $pass) : (),
                                                      defined $port ? (-port => $port) : (),
                                                      defined $db_version ? (-db_version => $db_version) : (),
                                                      -verbose => $verbose);
        $LOADED_STR = $load_str;
    }
    
    return 1;
}

=head2 get_adaptor

 Title   : get_adaptor
 Usage   : my $adaptor = Bio::Tools::Run::Ensembl->get_adaptor($species, $type);
 Function: Get a species-specific 'core' database adaptor, optionally of a
           certain type.
 Returns : Bio::EnsEMBL::DBSQL::DBAdaptor, OR if a certain type requested, a
           Bio::EnsEMBL::DBSQL::${type}Adaptor
 Args    : Bio::Species or string (species name) (REQUIRED), AND optionally
           string (the type of adaptor, eg. 'Gene' or 'Slice').

=cut

sub get_adaptor {
    my ($class, $species, $type) = @_;
    return unless $class->registry_setup;
    return unless $species;
    
    if (ref($species)) {
        $species = $species->scientific_name;
    }
    
    return Bio::EnsEMBL::Registry->get_adaptor($species, 'core', $type) if $type;
    return Bio::EnsEMBL::Registry->get_DBAdaptor($species, 'core');
}

=head2 get_gene_by_name

 Title   : get_gene_by_name
 Usage   : my $gene = Bio::Tools::Run::Ensembl->get_gene_by_name();
 Function: Get a gene given species and a gene name. If multiple genes match
           this combination, tries to pick the 'best' match.
 Returns : Bio::EnsEMBL::Gene
 Args    : -species => Bio::Species or string (species name), REQUIRED
           -name => string: gene name, REQUIRED

           If searching for the supplied gene name in the supplied species
           results in no genes, or more than one, you can choose what else is
           attempted in order to find just one gene:

           -use_orthologues   => Bio::Species or string (species name), or array
                                 ref of such things: see if any of these
                                 supplied species have (unambiguously) a gene
                                 with the supplied gene name and if a
                                 (one-to-one) orthologue of that gene in that
                                 species is present in the main desired species
                                 supplied to -species, returns that orthologous
                                 gene. (default: none, do not use orthologues)
           -use_swiss_lookup  => boolean: queries swissprot at expasy and if a
                                 suitable match is found, queries ensembl with
                                 the swissprot id. (default: 0, do not use
                                 swiss)
           -use_entrez_lookup => boolean: queries entrez at the NCBI server if
                                 (only) a single gene could not be found by any
                                 other method, then query ensembl with the
                                 entrez gene id. (default: 0, do not use NCBI)

           (Attempts proceed in this order and return as soon as one method is
           successful.)

           -strict => boolean: return undef with no warnings if more than one,
                      or zero genes were found. (default: 0, warnings are issued
                      and if many genes were found, one of them is returned)

=cut

sub get_gene_by_name {
    my $class = shift;
    return unless $class->registry_setup;
    
    my ($species, $gene_name, $use_swiss, $use_orth, $use_entrez, $strict) =
        $class->_rearrange([qw(SPECIES NAME
                            USE_SWISS_LOOKUP USE_ORTHOLOGUES
                            USE_ENTREZ_LOOKUP STRICT)], @_);
    $species || $class->throw("You must supply a -species");
    $gene_name || $class->throw("You must supply a -name");
    
    my $taxid;
    if (ref($species)) {
        $taxid = $species->id;
        $species = $species->scientific_name;
    }
    
    $TOTAL++;
    #print ". ";
    
    my $gene_adaptor = $class->get_adaptor($species, 'Gene') || return;
    
    # get the first gene that matches our query, warn if more than one did
    my @genes = @{$gene_adaptor->fetch_all_by_external_name($gene_name)};
    my $gene = shift(@genes);
    
    # if not good enough, try again using orthologues
    if ($use_orth && (! $gene || @genes > 0)) {
        my @tests;
        if (ref($use_orth) && ref($use_orth) eq 'ARRAY') {
            @tests = @{$use_orth};
        }
        else {
            @tests = ($use_orth);
        }
        
        my $alias_species = Bio::EnsEMBL::Registry->get_alias($species);
        
        foreach my $test_species (@tests) {
            $test_species = $test_species->scientific_name if ref($test_species);
            $test_species eq $species and next;
            
            my $test_gene = $class->get_gene_by_name(-species => $test_species,
                                                     -name => $gene_name,
                                                     -strict => 1) || next;
            my $homologue_results_ref = $test_gene->get_all_homologous_Genes();
            
            # get the species and gene id of each homologue
            foreach my $result_ref (@{$homologue_results_ref}) {
                my ($homolog_gene, $homology, $homolog_species) = @{$result_ref};
                
                # get_alias returns lower case, underscored version of what we get here
                $homolog_species = lc($homolog_species);
                $homolog_species =~ s/ /_/g;
                $homolog_species eq $alias_species or next;
                
                $homology->description eq 'UBRH' or next;
                
                $gene = $homolog_gene;
                $ORTHS++;
                last;
            }
            
            $gene and last;
        }
    }
    
    # if not good enough, try again using swissprot
    if ($use_swiss && (! $gene || @genes > 0)) {
        my $swiss_id;
        
        #*** swiss look up should be farmed out to some dedicated class
        my $swiss_name = lc($gene_name);
        my $swiss_species = lc($species);
        $swiss_species =~ s/\s/+/g;
        my $url = "http://www.expasy.org/cgi-bin/get-entries?db=sp&db=tr&DE=&GNc=AND&GN=$swiss_name&OC=$swiss_species&view=&num=100";
        my $web_agent = Bio::WebAgent->new();
        $web_agent->url($url);
        my $rq = HTTP::Request->new(GET=>$url);
        my $reply = $web_agent->request($rq);
        if ($reply->is_error) {
            $class->throw($reply->as_string()."\nError getting for url $url!\n");
        }
        my $content = $reply->content;
        if ($content && $content !~ /No entries have been found/) {
            my @possibles = split("<tr><td><input type=checkbox name=ac value=", $content);
            shift(@possibles);
            
            my @good_ids;
            foreach my $poss (@possibles) {
                my ($id, $desc) = $poss =~ /^.+?<td>(.+?)<\/td>.+?<b>.+?<b>(.+?)<\/td>/;
                unless ($desc =~ /Fragment/) {
                    push(@good_ids, $id);
                }
            }
            
            if (@good_ids == 1) {
                $swiss_id = shift(@good_ids);
            }
        }
        
        if ($swiss_id) {
            @genes = @{$gene_adaptor->fetch_all_by_external_name($swiss_id)};
            $gene = shift(@genes);
            $SWISS++ if ($gene && @genes == 0);
        }
    }
    
    # if not good enough, try again with search for the gene name at ncbi
    if ($use_entrez && (! $gene || @genes > 0)) {
        my $esearch = Bio::DB::EUtilities->new(-eutil      => 'esearch',
                                               -db         => 'gene',
                                               -term       => $taxid ? "$gene_name ${taxid}[taxid]" : "$gene_name \"$species\"[Organism]",
                                               -usehistory => 'y',
                                               -verbose    => -1);
        my $esummary = Bio::DB::EUtilities->new(-eutil  => 'esummary',
                                                -history => $esearch->next_History);
        eval {$esummary->parse_data;};
        if (!$@) {
            my $ncbi_id;
            while (my $docsum = $esummary->next_DocSum) {
                my $item = $docsum->get_Item_by_name('Name');
                if (lc($item->get_content) eq lc($gene_name)) {
                    $ncbi_id = $docsum->get_id;
                    last;
                }
            }
            
            if ($ncbi_id) {
                @genes = @{$gene_adaptor->fetch_all_by_external_name($ncbi_id)};
                $gene = shift(@genes);
                $NCBI++ if ($gene && @genes == 0);
            }
        }
    }
    
    if (@genes > 0) {
        return if $strict;
        #$class->warn("Species '$species' had multiple matches to gene '$gene_name', using first gene '".$gene->display_id."'");
    }
    unless ($gene) {
        return if $strict;
        $BAD++;
        #$class->warn("Species '$species' didn't have gene '$gene_name'");
        return;
    }
    
    $GOOD++;
    return $gene;
}

sub _stats {
    print "$TOTAL | $ORTHS | $SWISS | $NCBI | good vs bad = $GOOD vs $BAD\n";
}

1;
