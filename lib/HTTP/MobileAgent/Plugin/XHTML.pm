package HTTP::MobileAgent::Plugin::XHTML;

use warnings;
use strict;
use Carp;
use HTTP::MobileAgent;

use vars qw($VERSION);
$VERSION = '0.26_101';

my $env     = $ENV{"DOCOMO_HTML_VERMAP"};
$HTTP::MobileAgent::DoCoMo::HTMLVerMap = $env ? 
                                             ref($env) ? 
                                                 $env      : 
                                                 eval $env : 
                                             $VERSION lt $HTTP::MobileAgent::VERSION ? 
                                                 $HTTP::MobileAgent::DoCoMo::HTMLVerMap :
                                                 [
    # regex => version
    qr/[DFNP]501i/                                                                       => '1.0',
    qr/502i|821i|209i|691i|(F|N|P|KO)210i|^F671i$/                                       => '2.0',
    qr/(D210i|SO210i)|503i|211i|SH251i|692i|200[12]|2101V/                               => '3.0',
    qr/504i|251i|^F671iS$|^F661i$|^F672i$|212i|SO213i|2051|2102V|2701|850i/              => '4.0',
    qr/eggy|P751v/                                                                       => '3.2',
    qr/505i|506i|252i|253i|P213i|600i|700i|701i|SA800i|880i|SH851i|P851i|881i|900i|901i/ => '5.0',
    qr/882i|601i|D800iDS|P703imyu|F883i$|L704i|P704imyu/                                 => '6.0',
    qr/903i|N703iD|904i|F883iES|[^L]704i$|N704imyu/                                      => '7.0',
    qr/905i/                                                                             => '7.1',
];

##########################################
# Base Module

package HTTP::MobileAgent;

# Base method

sub xhtml_compliant { 0 }

##########################################
# DoCoMo Module

package HTTP::MobileAgent::DoCoMo;

# Redefine original method

{
    no strict 'refs';
    no warnings 'redefine';

    *{"HTTP::MobileAgent::DoCoMo::xhtml_compliant"} = sub {
        $_[0]->is_foma && (!$_[0]->html_version || $_[0]->html_version > 4.0) ? 1 : 0;
    };
}

##########################################
# EZWeb Module

# Defined at Original HTTP::KobileAgent::EZweb

##########################################
# SoftBank Module

package HTTP::MobileAgent::Vodafone;

sub xhtml_compliant{ 
    $_[0]->is_type_w || $_[0]->is_type_3gc ? 1 : 0;
}

##########################################
# WILLCOM Module

# Defined as base method

1; # Magic true value required at end of module
__END__

=head1 NAME

HTTP::MobileAgent::Plugin::XHTML - Add xhtml_compliant method to HTTP::MobileAgent

=head1 VERSION

This document describes HTTP::MobileAgent::Plugin::XHTML version 0.26_101


=head1 SYNOPSIS

  use HTTP::MobileAgent::Plugin::XHTML;
  
  my $ma = HTTP::MobileAgent->new;
  
  # Check terminal supports XHTML or not
  
  if ($ma->xhtml_compliant) { ... }


=head1 DESCRIPTION

HTTP::MobileAgent::Plugin::XHTML is a plugin module of HTTP::MobileAgent, which
implements method to check whether terminal supports xhtml or not.


=head1 CONFIGURATION AND ENVIRONMENT

DoCoMo terminal needs data table to check html version, and it will have to be update.
You can set data to environment variable $ENV{DOCOMO_HTML_VERMAP}, as array reference or
serialized string of array reference.

Format is like below:

  $ENV{DOCOMO_HTML_VERMAP} = [
    qr/[DFNP]501i/                                                                       => '1.0',
    qr/502i|821i|209i|691i|(F|N|P|KO)210i|^F671i$/                                       => '2.0',
    qr/(D210i|SO210i)|503i|211i|SH251i|692i|200[12]|2101V/                               => '3.0',
    qr/504i|251i|^F671iS$|^F661i$|^F672i$|212i|SO213i|2051|2102V|2701|850i/              => '4.0',
    qr/eggy|P751v/                                                                       => '3.2',
    qr/505i|506i|252i|253i|P213i|600i|700i|701i|SA800i|880i|SH851i|P851i|881i|900i|901i/ => '5.0',
    qr/882i|601i|D800iDS|P703imyu|F883i$|L704i|P704imyu/                                 => '6.0',
    qr/903i|N703iD|904i|F883iES|[^L]704i$|N704imyu/                                      => '7.0',
    qr/905i/                                                                             => '7.1',
  ];


=head1 DEPENDENCIES

=over

=item L<HTTP::MobileAgent> 0.26_1

=back


=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to C<nene@kokogiko.net>.


=head1 AUTHOR

OHTSUKA Ko-hei  C<< <nene@kokogiko.net> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2007, OHTSUKA Ko-hei C<< <nene@kokogiko.net> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.


=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
