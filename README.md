![Gem Version](http://img.shields.io/gem/v/StreetAddress.svg)
![Build Status](https://circleci.com/gh/derrek/street-address.svg?style=shield)

# SEEKING NEW MAINTAINER

Though I've had this gem for almost 10 years now, I haven't had time in the last 18 months to update the code and ensure the updates will not completely wreak havok on the world.  If you'd like to volunteer to maintain this repo and the associated gem let me know via github messaging or by leaving a message [on this issue](https://github.com/derrek/street-address/issues/32)

# DESCRIPTION
  
Parses a string returning a normalized Address object. When the string is not an US address it returns nil.

This is a port of the perl module [Geo::StreetAddress::US](https://github.com/timbunce/Geo-StreetAddress-US) originally written by Schuyler D. Erle. 

## Ruby Version
StreetAddress::US version 2+ is designed to work with ruby 2+.  It may work with ruby 1.9.3, but will not work with ruby 1.8.x. If you need this to work pre ruby 2.0 please use gem version 1.0.6 or below.

## Installation

```shell
    gem install StreetAddress
```

then in your code

```ruby
    require 'street_address'
```

or from Gemfile

```ruby
    gem 'StreetAddress', :require => "street_address"
```

## Basic Usage

```ruby
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

    address = StreetAddress::US.parse("1600 Pennsylvania Ave") 
    address.street # Pennsylvania
    address.number # 1600
    address.state # nil

    address = StreetAddress::US.parse("5904 Richmond Hwy Ste 340 Alexandria VA 22303-1864")
    address.postal_code_ext # 1846
    address = StreetAddress::US.parse("5904 Richmond Hwy Ste 340 Alexandria VA 223031864")
    address.postal_code_ext # 1846
```
## Stricter Parsing

```ruby
    address = StreetAddress::US.parse_address("1600 Pennsylvania Avenue")
    # nil - not enough information to be a full address
    
    address = StreetAddress::US.parse_address("1600 Pennsylvania Ave, Washington, DC, 20500")
    # same results as above
```

## License
The [MIT Licencse](http://opensource.org/licenses/MIT)

Copyright (c) 2007,2008,2009,2010,2011,2012,2013,2014,2015 Derrek Long and Contributors
