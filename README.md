#DESCRIPTION
  
Parses one line street addresses and returns a normalized address object.

This is a near direct port of the of the perl module 
Geo::StreetAddress::US originally written by Schuyler D. Erle.  
For more information see
http://search.cpan.org/~sderle/Geo-StreetAddress-US-0.99/

Since the original port in 2007 the two code bases have drifted somewhat.  Any help porting updates would be greatly appreciated.

## Installation
    gem install StreetAddress

then in your code 
    require 'street_address'

or from Gemfile
    gem 'StreetAddress', :require => "street_address"

## Basic Usage

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
address.to_s # "1600 Pennsylvania Ave, Washington, DC 20500"
address.to_s(:line1) # 1600 Pennsylvania Ave
StreetAddress::US.parse("1600 Pennsylvania Ave") # nil not a full address

## Informal/Loose Parsing

address = StreetAddress::US.parse("1600 Pennsylvania Avenue", :informal => true)
address.number # 1600
address.street # Pennsylvania
address.street_type # Ave
address.to_s # 1600 Pennsylvania Ave

## Zip+4

address = StreetAddress::US.parse("5904 Richmond Hwy Ste 340 Alexandria VA 22303-1864")
address.postal_code_ext # 1846
  
address = StreetAddress::US.parse("5904 Richmond Hwy Ste 340 Alexandria VA 223031864")
address.postal_code_ext # 1846

## License

(The MIT Licencse)
Copyright (c) 2007,2008,2009,2010,2011,2012,2013,2014,2016 Derrek Long
