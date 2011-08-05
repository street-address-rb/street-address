StreetAddress
    by Taxi Magic/Ridecharge Inc. (Derrek Long, Nicholas Schlueter)
    https://github.com/derrek/street-address

== DESCRIPTION:
  
Parses one line street addresses and returns a normalized address object.

This is a near direct port of the of the perl module 
Geo::StreetAddress::US originally written by Schuyler D. Erle.  
For more information see
http://search.cpan.org/~sderle/Geo-StreetAddress-US-0.99/

== SYNOPSIS:

Parse United States addresses.

=== Basic Usage:
require 'street_address'
address = StreetAddress::US.parse("1600 Pennsylvania Ave, Washington, DC, 20500")
address.street # Pennsylvania
address.number # 1600
address.postal_code # 20500
address.city # Washington
address.state # DC
address.state_name # District of columbia
address.street_type # Ave
address.intersection? # false

StreetAddress::US.parse("1600 Pennsylvania Ave") # nil not a full address

== LICENSE:

(The MIT License)

Copyright (c) 2007, 2011 Ridecharge Inc.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
