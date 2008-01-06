use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'HTTP::MobileAgent::Plugin::XHTML',
    license             => 'perl',
    dist_author         => 'OHTSUKA Ko-hei <nene@kokogiko.net>',
    dist_version_from   => 'lib/HTTP/MobileAgent/Plugin/XHTML.pm',
    requires => {
        'Test::More'           => 0,
        'Test::Base'           => 0,
        'HTTP::MobileAgent'    => '0.26_1',
    },
    add_to_cleanup      => [ 'HTTP-MobileAgent-Plugin-XHTML-*' ],
);

$builder->create_build_script();
