SELTR is a small utility meant as a companion to the MULTIMON/MULTIMON-NG decoders taking care of translating selcals into human readable strings using lookup tables.

Prerequisites
Application is written in Perl, which is normally included as a standard in Linux distributions. In addition, DBD::CSV modules will be needed: they can normally be downloaded from your distribution package manager or from CPAN.

Lookup tables must be built according to the following format: semicolumn separated fields, ID/unit pairs. First row must contain headers.
ID;UNIT;
010E1;AGRIGENTO COM.PROV.;
020E1;ALESSANDRIA COM.PROV.;

Usage
seltr.pl must be followed by the follwing mandatory parameters:

- encoding (es. CCIR): will help discriminate strings in case more then one decoder is enabled in MULTIMON;
- number of characters to look for (es. 5): minimum number of chars to trigger a db search. Helps cutting noise when selcals have a fixed length;
- location of database folder (es. /home/johndoe/seltr/database);
- lookup table to use (es. it_vf).

Feeding from GQRX UDP stream:
nc -l -u -p 7355 | sox -t raw -esigned-integer -b 16 -r 48000 - -esigned-integer -b 16 -r 22050 -t raw - | ./multimon-ng/build/multimon-ng -t raw -a CCIR - | ./seltr/seltr.pl CCIR 5 /home/johndoe/seltr/database it_vf

Feeding from RTL_FM:
rtl_fm -f 74062500 -M fm -p -40 -g 25 -s 22050 -l 50 - | ./multimon-ng -t raw -a CCIR - | ./seltr/seltr.pl CCIR 5 /home/johndoe/seltr/database it_vf
