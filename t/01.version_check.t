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
    is $ma->html_version,$out;
};

__END__
=== 
--- input: DoCoMo/1.0/F505iGPS/c20/TB/W24H12
--- expected: 5.0

=== 
--- input: DoCoMo/2.0 F883iES(c100;TB;W20H08)
--- expected: 7.0

=== 
--- input: DoCoMo/2.0 F2051(c100;TB)
--- expected: 4.0

=== 
--- input: DoCoMo/1.0/D505i/c20/TB/W20H10
--- expected: 5.0

=== 
--- input: DoCoMo/2.0 F900i(c100;TB;W22H12)
--- expected: 5.0

=== 
--- input: DoCoMo/2.0 N2001(c10)
--- expected: 3.0

=== 
--- input: DoCoMo/2.0 P703imyu(c100;TB;W30H15)
--- expected: 6.0
