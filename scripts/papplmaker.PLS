#!/usr/bin/perl -w
#
#   Usage: ./papplmaker -h
#   or: perldoc papplmaker
#
#   senger@ebi.ac.uk
#   July 2002
#
#   $Id: papplmaker.PLS,v 1.6 2005-10-09 14:49:30 heikki Exp $
#-----------------------------------------------------------------------------

use strict;

sub get_usage {
    return <<"END_OF_USAGE";
Usage:
   papplmaker [options]

where 'options' are:
   -a <access>    access method (default 'soap')
   -l <location>  where are the analyses
                  (default: http://www.ebi.ac.uk/soaplab/services)
   -n <name>      name of an analysis,
                  (default: generate for all available, unless -r given)
   -r <regexp>    regular expression for matching analysis names
                  (default: generate for all available, unless -n given)
   -m <module>    name of generated module,
                  can be a template (\$ANALYSIS, \$CATEGORY, \$SERVICE)
                  (default: same as service name)
   -d <directory> output directory
                  (default: current directory)
   -f!            overwrite existing files
                  (default: skip generation of the existing files)
   -s, -S         show what and where will be generated but do not do it
   -h             this help

Environment variables:
   HTTPPROXY      HTTP proxy server (use by some access method,
                  e.g. by the SOAP access)

For more details type:  perldoc papplmaker.PLS

END_OF_USAGE
}

BEGIN {
    # add path to the directory with this script
    my $mylib;
    ($mylib = $0) =~ s|/[^/]+$||;
    unshift @INC, $mylib;

    use vars qw($VERSION $Revision $Cmdline);
    $Cmdline = join (' ', @ARGV);

    # be prepare for command-line options/arguments
    use Getopt::Std;
    use vars qw/ $opt_h $opt_a $opt_l $opt_n $opt_r $opt_m /;
    use vars qw/ $opt_d $opt_f $opt_v $opt_s $opt_S /;
    my $switches = 'adflmnr';   # switches taking an argument (a value)
    getopt ($switches);


    # set the version for version checking
    $VERSION = do { my @r = (q[$Revision: 1.6 $] =~ /\d+/g); sprintf "%d.%-02d", @r };
    $Revision = q[$Id: papplmaker.PLS,v 1.6 2005-10-09 14:49:30 heikki Exp $];

    # help wanted?
    if ($opt_h) {
	print get_usage;
	exit 0;
    }

    # print version of this script and exit
    if ($opt_v) {
	print "$0 $VERSION\n";
	exit 0;
    }
}

use Bio::Tools::Run::Analysis;        # to access analysis tools directly
use Bio::Tools::Run::AnalysisFactory; # to access list/factory of analysis tools

# --- create a factory object;
my @access    = ('-access', $opt_a) if defined $opt_a;
my @location  = ('-location', $opt_l) if defined $opt_l;
my @httpproxy = ('-httpproxy', $ENV{'HTTPPROXY'}) if defined $ENV{'HTTPPROXY'};
my $factory = new Bio::Tools::Run::AnalysisFactory (@location, @httpproxy)
    unless $opt_n;

# --- create an analysis (service) object;
my @name = ('-name', $opt_n) if defined $opt_n;
my $service = new Bio::Tools::Run::Analysis (@name, @location, @httpproxy);

# find names of services we are going to generate stubs for
my (@names) = $opt_n ? ($opt_n) : @{ $factory->available_analyses };
@names = grep /$opt_r/i, @names if $opt_r;
print (join ("\n", @names), "\n") and exit 0 if $opt_s;
$opt_f = 'no' unless $opt_f;

for my $name (@names) {

    # service name can consist of category and analysis name
    my ($category, $analysis) = split (/\./, $name, 2);
    unless ($analysis) {  # swap them if category does not exist
	$analysis = $category;
	$category = undef;
    }

    # module may be a template for a real name
    my $module = $opt_m ? $opt_m : $name;
    $module =~ s/\$\{?SERVICE\}?/$name/ig;
    $module =~ s/\$\{?ANALYSIS\}?/$analysis/ig;
    $module =~ s/\$\{?CATEGORY\}?/$category/ig if $category;
    $module =~ s/[ -\/]/_/g;  # would cause troubles in module name (?)

    # destination for generation
    my $file = $module;
    $file =~ s/[ \/]/_/g;
    $file =~ s|::|/|g;
    if ($opt_d) {
	$opt_d .= '/' unless $opt_d =~ m|/$|;
	$file = "$opt_d$file";
    }
    $file .= '.pm';

    # show what would happen... or do it
    if ($opt_S) {
	print "SERVICE: $name\n\tMODULE: $module\n\tFILE:   $file\n";
    } else {

	# create a service object (we will ask it for service metadata)
	$service = $factory->create_analysis ($name) unless ($opt_n);
#        $service = $service->new (-name => $name);  # an alternative if 'create_analysis' does not work

	# get metadata from the service
	print "Accessing service '$name'...\n";
	my $input_spec = $service->input_spec;
	my $result_spec = $service->result_spec;

	# create necessary directories
	my $dirs = $file;
	while ($dirs =~ s|/[^/]*$||) {
	    next unless $dirs;
	    mkdir ($dirs) or die "Directory '$dirs': $!\n" unless -d $dirs;
	}

	# generate and write a module for the service
	print "Creating module '$module'...\n";
	print ("\tFile '$file' exists, skipped...\n") and next if -s $file and $opt_f ne '!';
	open (MODULE, ">$file") or die "File '$file': $!\n";
	print MODULE &generate ($service, $file, $module, $input_spec, $result_spec);
	close (MODULE) or die "File '$file': $!\n";
	print "\tFile '$file' created\n";
    }
}

# generated method names are created from the data input and result
# nams which may have some strange syntax not allowed in Perl - so
# make them more perlish here
sub esc_method_name {
    my ($name) = shift;
    $name =~ s/\W/_/g;
    $name = "_$name" if $name =~ /^\d/;
    return $name;
}


sub generate {
    my ($service, $file, $module, $input_spec, $result_spec) = @_;

    my $code1 = <<'EOC',
use Bio::Tools::Run::Analysis;
use vars qw(@ISA $AUTOLOAD);

sub new {
    my ($class, @args) = @_;
    my $parent = new Bio::Tools::Run::Analysis (-access => '$$$ACCESS$$$',
						-location => '$$$LOCATION$$$',
						-name => '$$$SERVICE$$$',
						@args
						);
    @ISA = (ref $parent);
    $self->{'_inputs'} = {};
    bless $parent, '$$$PACKAGE$$$';
}

sub create_job {
    my ($self, $params) = @_;
    my $parent_object;
    if (! defined $params) {
	$parent_object =
	    $self->SUPER::create_job ( $self->_prepare_inputs ($self->{'_inputs'}) );
    } elsif (ref $params) {
	$parent_object =
	    $self->SUPER::create_job ( $self->_prepare_inputs ($self->{'_inputs'}, $params) );
    } else {
	$parent_object =
	    $self->SUPER::create_job ($params);
    }
    my $parent_ref = ref $parent_object;
    my $job = bless $parent_object, '$$$PACKAGE$$$::Job';
    $job->_isa ($parent_ref);
    $job;
}

sub AUTOLOAD {
  my $method = substr ($AUTOLOAD, rindex ($AUTOLOAD, '::') + 2);
  return if $method eq 'DESTROY';

  die "Unrecognized method '$method'.\n" .
      "List of available methods for setting input data:\n\t" .
      join ("\n\t", sort keys %set_methods) . "\n";
}

{ no strict 'refs';
    foreach my $method_name ( keys %set_methods ) {
        my %method_def = %{ $set_methods{$method_name} };
        *$method_name = sub {
            my $self = shift;
            my $value = $self->_read_value (shift);
	    if (@{ $method_def{'allowed_values'} } > 0) {
		my $found;
		foreach my $allowed ( @{ $method_def{'allowed_values'} } ) {
		    ($found = 1, last) if ($value eq $allowed);
		}
		warn ("Possibly '$value' is not allowed. Allowed values are:\n\t" .
		      join ("\n\t", @{ $method_def{'allowed_values'} }) . "\n")
		    unless $found;
	    }
            ${ $self->{'_inputs'} }{ $method_def{'input_name'} } = $value;
            $self;
        }
    }
}
EOC

    my $code2 = <<'EOC',
use vars qw(@ISA $AUTOLOAD);

sub _isa { @ISA = $_[1] }

sub AUTOLOAD {
  my $method = substr ($AUTOLOAD, rindex ($AUTOLOAD, '::') + 2);
  return if $method eq 'DESTROY';

  die "Unrecognized method '$method'.\n" .
      "List of available methods for getting result data:\n\t" .
      join ("\n\t", sort keys %get_methods) . "\n";
}

{ no strict 'refs';
    foreach my $method_name ( keys %get_methods ) {
        my %method_def = %{ $get_methods{$method_name} };
	my $result_name = $method_def{'result_name'};
        *$method_name = sub {
            my $self = shift;
	    ${ $self->results ( { $result_name => shift } ) } {$result_name};
        }
    }
}
EOC

my %replace = ( '\$\$\$ACCESS\$\$\$'   => $$service{'_access'},
		'\$\$\$LOCATION\$\$\$' => $$service{'_location'},
		'\$\$\$SERVICE\$\$\$'  => $$service{'_name'},
		'\$\$\$PACKAGE\$\$\$'  => $module,
		);
foreach (keys %replace) {
    $code1 =~ s/$_/$replace{$_}/eg;
}

#
# --- here starts the generated output
#
join ("\n", 
      "package $module;\n",

      "# -- generated by Bio::Tools::Run::Analysis papplmaker (v$VERSION)",
      "# -- Copyright (C) 2003 Martin Senger and EMBL-EBI",
      "# -- generated from location: $service->{'_location'}",
      "# -- using command line:",
      "# --    $0 $Cmdline",
      "# -- [" . localtime() . "]\n",

      'my %set_methods = (',

      (map { my %input = %$_;
	     my $method_name = &esc_method_name ($input{'name'});
	     my @attrs = ("        input_name => '$input{'name'}',");
	     push (@attrs, "        mandatory => '$input{'mandatory'}',") if defined $input{'mandatory'};
	     push (@attrs, "        default => '$input{'default'}',") if defined $input{'default'};
	     push (@attrs, "        type => '$input{'type'}',") if $input{'type'};
	     join("\n", 
		  "    $method_name => {",
		  @attrs,
		  '        allowed_values => [' .
		      ($input{'allowed_values'} ? join (',', map "'$_'", @{ $input{'allowed_values'} }) : '') .
		      ']',
		  '    },'
		  ),
	   } @{ $input_spec} ),
      ");",

      $code1,

      "\n", 
      "package ${module}::Job;\n",

      'my %get_methods = (',

      (map { my %result = %$_;
	     my $method_name = &esc_method_name ($result{'name'});
	     my @attrs = ("        result_name => '$result{'name'}',");
	     push (@attrs, "        type => '$result{'type'}',") if $result{'type'};
	     join("\n", 
		  "    $method_name => {",
		  @attrs,
		  '    },'
		  ),
	   } @{ $result_spec} ),
      ");",

      $code2,
      <<'EOC');
1;
EOC
}

__END__

=head1 NAME

papplmaker.PLS -  Analysis tools module generator

=head1 SYNOPSIS

  # get some help
  papplmaker.PLS -h

  # generate module for program 'seqret'
  papplmaker.PLS -n edit.seqret

  # ditto, but specify where to find 'seqret'
  papplmaker.PLS -n edit::seqret
             -l http://localhost:8080/axis/services

  # ditto, but specify a non-default access method to 'seqret'
  papplmaker.PLS -n edit::seqret
             -l http://corba.ebi.ac.uk/IOR/Analyses.ref
             -a corba

  # generate modules for all available analyses
  # (using default location and default access method)
  papplmaker.PLS

  # do not generate but see what would be generated
  papplmaker.PLS -s
  papplmaker.PLS -S

  # generate module for analysis 'edit::seqret'
  # but name it 'MySeqret'
  papplmaker.PLS -n edit::seqret -m MySeqret

      # ...and use it
      use MySeqret;
      print new MySeqret->sequence_direct_data ('tatatacccgt')
                        ->osformat ('embl')
                        ->wait_for
                        ->outseq;

  # ditto but put the result into directory '/tmp/my'
  # (directories do not need to exist)
  papplmaker.PLS -n edit::seqret -m MySeqret -d /tmp/my/

  # generate modules for all analysis whose names
  # matches given regular expression (case insensitive)
  papplmaker.PLS -r 'edit'

  # ditto, but name generated module with your own names
  # (letting papplmaker.PLS substitute parts of your names)
  papplmaker.PLS -r 'edit' -m 'My_$ANALYSIS'

=head1 DESCRIPTION

The module C<Bio::Tools::Run::Analysis> provides access to the local and remote
analysis tools in a unified way (defined in C<Bio::AnalysisI>). The
module uses general approach allowing to set arbitrary input data and
to retrieve results by naming them. However, sometimes is more
convenient to use a specific module, representing one analysis tool,
that already knows about available input and result names.

The generator C<papplmaker.PLS> creates such dedicated modules.

C<papplmaker.PLS> uses the same access method as the general module -
which means that depending on the parameter C<access> it can use SOAP,
CORBA or any other (supported) protocol, or it can access local
analysis (available on the same machine where C<papplmaker.PLS> is
invoked).

C<papplmaker.PLS> does its job either for one named analysis (specified
by the C<-n> option, or it uses C<Bio::Tools::Run::AnalysisFactory> module in
order to find what analyses are available, and can limit their number
by matching against a regular expression given by the C<-r> option.

The generated module or modules are named by default similarly to the
names of the corresponding analyses, but this can be changed by the
C<-m> option which is actually a template where the following strings
are recognised and replaced:

=over 4

=item $ANALYSIS or ${ANALYSIS}

Will be replaced by the name of the analysis.

=item $CATEGORY or ${CATEGORY}

Will be replaced by the name of the category where the analysis belongs to.

=item $SERVICE or ${SERVICE}

Will be replaced by the entire name of the service (which is usually a
concatenation of a category and a analysis name, and it is used also
as a default module name, btw).

=back

What is a difference between the C<service> and C<analysis>, and what
does C<category> mean? Sometimes these terms may be confusing because
they may mean slightly different things depending on the access method
used to communicate with them. Generally, an C<analysis> is a program
(an application, a tool) running somewhere, but sometimes on a local
machine. An example of an analysis is C<seqret> (from the EMBOSS
package). The analyses can be grouped into categories by their
functions or by type of data they deal with (but sometimes there are
no categories at all). Each analyses can be accessed using a higher
level of abstraction, a C<service>. A service is usually a
protocol-dependent wrapper, such as a Web Service, or a CORBA
service. For example there is a C<edit::seqret> service which
represents analysis C<seqret> in the category C<edit>.

=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to
the Bioperl mailing list.  Your participation is much appreciated.

  bioperl-l@bioperl.org              - General discussion
  http://bioperl.org/MailList.shtml  - About the mailing lists

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
of the bugs and their resolution. Bug reports can be submitted via the
web:

  http://bugzilla.bioperl.org/

=head1 AUTHOR

Martin Senger (senger@ebi.ac.uk)

=head1 COPYRIGHT

Copyright (c) 2003, Martin Senger and EMBL-EBI.
All Rights Reserved.

This script is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 DISCLAIMER

This software is provided "as is" without warranty of any kind.

=head1 BUGS AND LIMITATIONS

None known at the time of writing this.

=cut
