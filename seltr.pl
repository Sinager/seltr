#!/usr/bin/perl

use DBI;

$encoding = $ARGV[0];
$idlen = $ARGV[1];
$dbloc = $ARGV[2];
$dbtable = $ARGV[3];

if ((length($encoding)==0) or (length($idlen)==0) or (length($dbloc)==0) or (length($dbtable)==0)){
	print "SELTR: must specify encoding, number of digits, database location and lookup table name\n";
	print "       Example:   seltr.pl CCIR 5 /home/jdoe/database it_vf\n";
	exit;}

# DB init
$dbh = DBI->connect ("dbi:CSV:", undef, undef, {
    f_dir => $dbloc,
    f_ext      => ".csv/r",
    RaiseError => 1,
    csv_sep_char => ";",
    }) or die "Cannot connect: $DBI::errstr";

# prepare DB query
$sth = $dbh->prepare ("select UNIT from $dbtable where (ID = ?)");


print "-- SELTR running with: $encoding $idlen $dbloc $dbtable\n"; 

# main loop
while (<STDIN>){
	chomp;
	$unit = $_;
	$unit =  substr $unit, (length($encoding)+2);
	if(length($unit) >= $idlen){
		print "$unit ";
		$sth->execute($unit);
		$descr = $sth->fetchrow_array();
		print "> $descr\n";
		}
	}
