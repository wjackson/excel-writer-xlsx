###############################################################################
#
# Tests for Excel::XLSX::Writer::Package::SharedStrings methods.
#
# reverse('�'), September 2010, John McNamara, jmcnamara@cpan.org
#

use lib 't/lib';
use TestFunctions;
use strict;
use warnings;
use Excel::XLSX::Writer::Package::SharedStrings;
use XML::Writer;

use Test::More tests => 1;

###############################################################################
#
# Tests setup.
#
my $expected;
my $caption;

open my $got_fh, '>', \my $got or die "Failed to open filehandle: $!";

my $obj    = Excel::XLSX::Writer::Package::SharedStrings->new();
my $writer = new XML::Writer( OUTPUT => $got_fh );

$obj->{_writer} = $writer;

###############################################################################
#
# Test the _assemble_xml_file() method.
#
$caption = " \tSharedStrings: _assemble_xml_file()";

$obj->_set_string_count(7);
$obj->_set_unique_count(3);
$obj->_add_strings(['neptune', 'mars', 'venus']);
$obj->_assemble_xml_file();

$expected = _expected_to_aref();
$got      = _got_to_aref( $got );

_is_deep_diff( $got, $expected, $caption );

__DATA__
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<sst xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" count="7" uniqueCount="3">
  <si>
    <t>neptune</t>
  </si>
  <si>
    <t>mars</t>
  </si>
  <si>
    <t>venus</t>
  </si>
</sst>