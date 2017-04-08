#!/usr/bin/perl

use DBI;

$unit = $ARGV[0];

# DB init
$dbh = DBI->connect ("dbi:CSV:", undef, undef, {
	f_dir => "./database",
    f_ext      => ".csv/r",
    RaiseError => 1,
    csv_sep_char => ";",
    }) or die "Cannot connect: $DBI::errstr";

$sth = $dbh->prepare ("select UNIT from ids where (ID = ?)");
	
while (<STDIN>){
	print "$unit ";
	$sth->execute($unit);
	$descr = $sth->fetchrow_array();
	print "> $descr\n";
	}
