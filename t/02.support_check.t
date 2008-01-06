use strict;
use Test::Base;
plan tests => 1 * blocks;

use HTTP::MobileAgent::Plugin::XHTML;
use CGI;

run {
    local %ENV;

    my $block = shift;
    my $ua  = $block->input;
    my $out = $block->expected;

    $ENV{'HTTP_USER_AGENT'} = $ua;
    $ENV{'REQUEST_METHOD'}  = "GET";

    CGI::initialize_globals;
    my $ma = HTTP::MobileAgent->new;
    is $ma->xhtml_compliant,$out;
};

__END__
=== 
--- input: DoCoMo/1.0/F505iGPS/c20/TB/W24H12
--- expected: 0

=== 
--- input: DoCoMo/2.0 F883iES(c100;TB;W20H08)
--- expected: 1

=== 
--- input: DoCoMo/2.0 F2051(c100;TB)
--- expected: 0

=== 
--- input: DoCoMo/1.0/D505i/c20/TB/W20H10
--- expected: 0

=== 
--- input: DoCoMo/2.0 F900i(c100;TB;W22H12)
--- expected: 1

=== 
--- input: DoCoMo/2.0 N2001(c10)
--- expected: 0

=== 
--- input: DoCoMo/2.0 P703imyu(c100;TB;W30H15)
--- expected: 1

=== 
--- input: KDDI-KC22 UP.Browser/6.0.8.3 (GUI) MMP/1.1
--- expected: 1

=== 
--- input: KDDI-SN31 UP.Browser/6.2.0.7.3.129 (GUI) MMP/2.0
--- expected: 1

=== 
--- input: KDDI-SN24 UP.Browser/6.0.8.2 (GUI) MMP/1.1
--- expected: 1

=== 
--- input: KDDI-SN23 UP.Browser/6.0.8.2 (GUI) MMP/1.1
--- expected: 1

=== 
--- input: J-PHONE/3.0/J-T10
--- expected: 0

=== 
--- input: J-PHONE/3.0/J-D08
--- expected: 0

=== 
--- input: J-PHONE/3.0/J-SH10
--- expected: 0

=== 
--- input: SoftBank/1.0/816SH/SHJ001 Browser/NetFront/3.4 Profile/MIDP-2.0 Configuration/CLDC-1.1
--- expected: 1

=== 
--- input: Vodafone/1.0/V803T/TJ001 Browser/VF-Browser/1.0 Profile/MIDP-2.0 Configuration/CLDC-1.1
--- expected: 1

=== 
--- input: J-PHONE/4.3/V602T TS/2.00 Profile/MIDP-1.0 Configuration/CLDC-1.0 Ext-Profile/JSCL-1.2.2
--- expected: 0

=== 
--- input: SoftBank/1.0/910T/TJ001/SN351774012575317 Browser/NetFront/3.3 Profile/MIDP-2.0 Configuration/CLDC-1.1
--- expected: 1

=== 
--- input: Mozilla/3.0(WILLCOM;SANYO/WX310SA/2;1/1/C128) NetFront/3.3
--- expected: 0
