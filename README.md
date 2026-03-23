[![Gem Version](https://img.shields.io/gem/v/StreetAddress.svg)](https://rubygems.org/gems/StreetAddress)
[![CI](https://github.com/street-address-rb/street-address/actions/workflows/ci.yml/badge.svg)](https://github.com/street-address-rb/street-address/actions/workflows/ci.yml)

# StreetAddress

Parses a US street address string and returns a normalized Address object. Returns `nil` when the string is not a recognized US address format.

This is a port of the Perl module [Geo::StreetAddress::US](https://github.com/timbunce/Geo-StreetAddress-US) originally written by Schuyler D. Erle.

## Ruby Version

Requires Ruby 3.3 or later. For Ruby 2.x support, use gem version 1.0.6.

## Installation

```shell
gem install StreetAddress
```

then in your code

```ruby
require 'street_address'
```

or in your Gemfile

```ruby
gem 'StreetAddress', require: 'street_address'
```

## Basic Usage

```ruby
require 'street_address'

address = StreetAddress::US.parse("1600 Pennsylvania Ave, Washington, DC, 20500")
address.number      # "1600"
address.street      # "Pennsylvania"
address.street_type # "Ave"
address.city        # "Washington"
address.state       # "DC"
address.state_name  # "District Of Columbia"
address.postal_code # "20500"
address.intersection? # false
address.to_s        # "1600 Pennsylvania Ave, Washington, DC 20500"
address.to_s(:line1) # "1600 Pennsylvania Ave"
address.to_s(:line2) # "Washington, DC 20500"
address.to_h        # { number: "1600", street: "Pennsylvania", ... }

address = StreetAddress::US.parse("1600 Pennsylvania Ave")
address.street # "Pennsylvania"
address.number # "1600"
address.state  # nil
```

## ZIP+4 Support

```ruby
address = StreetAddress::US.parse("5904 Richmond Hwy Ste 340 Alexandria VA 22303-1864")
address.postal_code     # "22303"
address.postal_code_ext # "1864"
address.full_postal_code # "22303-1864"

# Also works without the hyphen
address = StreetAddress::US.parse("5904 Richmond Hwy Ste 340 Alexandria VA 223031864")
address.postal_code_ext # "1864"
```

## Intersection Parsing

```ruby
address = StreetAddress::US.parse("Hollywood Blvd and Vine St, Los Angeles, CA")
address.intersection? # true
address.street        # "Hollywood"
address.street_type   # "Blvd"
address.street2       # "Vine"
address.street_type2  # "St"
```

## Stricter Parsing

```ruby
address = StreetAddress::US.parse_address("1600 Pennsylvania Avenue")
# nil - not enough information to be a full address

address = StreetAddress::US.parse_address("1600 Pennsylvania Ave, Washington, DC, 20500")
# Returns Address object - full address provided
```

## Known Limitations

- US addresses only (returns `nil` for international addresses)
- PO Boxes are not supported
- Military addresses (APO/FPO) are not supported
- Rural routes (RR) and highway contract routes (HC) are not supported
- Addresses ending in "United States" or "USA" may not parse correctly

## License

The [MIT License](http://opensource.org/licenses/MIT)

Copyright (c) 2007-2026 Derrek Long and Contributors
