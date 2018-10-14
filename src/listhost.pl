#!/bin/perl
#
# Script Name: listhost.pl 
# Function   : create host_list.csv of ASI usecase from input file
# Usage      : listhost.pl <input file>
# Exit Code  : 0 ... Normal End
#              1 ... Lack of columns
#              2 ... No valid record
#
######################################################################
#
# History
#
# ID   Date       Name         Description             TaskID
# ---- ---------- -----------  ----------------------- ------------
# N/A  2018/03/16 Fujino        New Creation
# 0001 2018/09/10 Fujino        Change Error message
# working branch 001
# Work04-03
# Work04-06
######################################################################
my $DEFLIST=$ARGV[0];
open(INPUT, $DEFLIST) || die "Error: $! open($DEFLIST)";
######################################################################
my %host;
my @list;
my $num = 0;
while(<INPUT>){
	$_ =~ s/^\xEF\xBB\xBF//;   # remove BOM
	next if /^\s*$/||/^\s*#/;
	my @cols = split(/\s*,\s*/);
	if( $#cols < 1 ){

		print STDERR "ERROR : Columns Insufficient: $_\n";
		# New error message for buffix01
		print STDERR "Check format.\n";

		exit(1);
	}
	$cols[0] =~ s/^\s*//;  # remove blank
	unless( $host{$cols[0]}){
		$host{$cols[0]} = 1;
		$list[$num] = $cols[0];
		$num++;
	} 
}
close(INPUT);
unless( $num ){
	print STDERR "No Valid Record Found\n";
	exit(2);
}
######################################################################
foreach my $node (@list){
	print "$node, asiuser, /home/asitool/.ssh/id_rsa_ASI, AIX, 22\n";
}
######################################################################
