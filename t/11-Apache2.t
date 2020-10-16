use v6;
use Test;
use lib <lib>;
use License::Software;
use License::Software::Abstract;

plan 15;
my License::Software::Abstract $license;
my License::Software::Abstract $license-apache = license('apache');
my $pair = "Bahtiar `kalkin-` Gadimov" => 2000..2016;
ok $license = $license-apache.new: $pair;
is $license.name(), 'Apache License, Version 2.0, January 2004', 'License Name';
is $license.short-name(), 'Apache2', 'Short name';
is $license.aliases(), ['Apache2', 'Apache', $license.spdx], 'The only known alias for Apache2 & Apache license is Apache2';
is $license.copyright-note(), 'Copyright [2000-2016] Bahtiar `kalkin-` Gadimov', 'Correct copyright note';
is $license.copyright, 'Copyright', "Copyright is just 'copyright'";
is $license.works-name(), 'This program', "Default programm name should 'This program'";
is $license.note(), 'Please see the file called LICENSE.';
is $license.files().keys.sort, ['LICENSE', 'NOTICE'], 'The Apache license and NOTICE file';

$license= $license-apache.new( "FooBar" );
ok ($license, "Can be initialized with just a name" );
ok ($license.holders[0].year == DateTime.new(time).year, "Year is correct" );

ok $license = $license-apache.new("FooBar", $pair.Hash );
is $license.holders.elems, 1, 'Should have 1 holder';
my $expected-notice = "FooBar\nCopyright [2000-2016] Bahtiar `kalkin-` Gadimov\n";

is $license.files()<NOTICE>, $expected-notice, 'License NOTICE';
is $license.files()<LICENSE>, $license.full-text(), 'License text';

# vim: ft=perl6
