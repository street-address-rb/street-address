# frozen_string_literal: true

require 'minitest/autorun'
require 'street_address'

class StreetAddressUsTest < Minitest::Test
  ADDRESSES = {
    "1005 Gravenstein Hwy 95472" => {
      :number => '1005',
      :street => 'Gravenstein',
      :postal_code => '95472',
      :street_type => 'Hwy',
    },
    "1005 Gravenstein Hwy, 95472" => {
      :number => '1005',
      :street => 'Gravenstein',
      :postal_code => '95472',
      :street_type => 'Hwy',
    },
    "1005 Gravenstein Hwy N, 95472" => {
      :number => '1005',
      :street => 'Gravenstein',
      :postal_code => '95472',
      :suffix => 'N',
      :street_type => 'Hwy',
    },
    "1005 Gravenstein Highway North, 95472" => {
      :number => '1005',
      :street => 'Gravenstein',
      :postal_code => '95472',
      :suffix => 'N',
      :street_type => 'Hwy',
    },
    "1005 N Gravenstein Highway, Sebastopol, CA" => {
      :number => '1005',
      :street => 'Gravenstein',
      :state => 'CA',
      :city => 'Sebastopol',
      :street_type => 'Hwy',
      :prefix => 'N'
    },
    "1005 N Gravenstein Highway, Suite 500, Sebastopol, CA" => {
      :number => '1005',
      :street => 'Gravenstein',
      :state => 'CA',
      :city => 'Sebastopol',
      :street_type => 'Hwy',
      :prefix => 'N',
      :unit_prefix => 'Suite',
      :unit => '500',
    },
    "1005 N Gravenstein Hwy Suite 500 Sebastopol, CA" => {
      :number => '1005',
      :street => 'Gravenstein',
      :state => 'CA',
      :city => 'Sebastopol',
      :street_type => 'Hwy',
      :prefix => 'N',
      :unit_prefix => 'Suite',
      :unit => '500',
    },
    "1005 N Gravenstein Highway, Sebastopol, CA, 95472" => {
      :number => '1005',
      :street => 'Gravenstein',
      :state => 'CA',
      :city => 'Sebastopol',
      :postal_code => '95472',
      :street_type => 'Hwy',
      :prefix => 'N'
    },
    "1005 N Gravenstein Highway Sebastopol CA 95472" => {
      :number => '1005',
      :street => 'Gravenstein',
      :state => 'CA',
      :city => 'Sebastopol',
      :postal_code => '95472',
      :street_type => 'Hwy',
      :prefix => 'N'
    },
    "1005 Gravenstein Hwy N Sebastopol CA" => {
      :number => '1005',
      :street => 'Gravenstein',
      :state => 'CA',
      :city => 'Sebastopol',
      :suffix => 'N',
      :street_type => 'Hwy',
    },
    "1005 Gravenstein Hwy N, Sebastopol CA" => {
      :number => '1005',
      :street => 'Gravenstein',
      :state => 'CA',
      :city => 'Sebastopol',
      :suffix => 'N',
      :street_type => 'Hwy',
    },
    "1005 Gravenstein Hwy, N Sebastopol CA" => {
      :number => '1005',
      :street => 'Gravenstein',
      :state => 'CA',
      :city => 'North Sebastopol',
      :street_type => 'Hwy',
    },
    "1005 Gravenstein Hwy, North Sebastopol CA" => {
      :number => '1005',
      :street => 'Gravenstein',
      :state => 'CA',
      :city => 'North Sebastopol',
      :street_type => 'Hwy',
    },
    "1005 Gravenstein Hwy Sebastopol CA" => {
      :number => '1005',
      :street => 'Gravenstein',
      :state => 'CA',
      :city => 'Sebastopol',
      :street_type => 'Hwy',
    },
    "115 Broadway San Francisco CA" => {
      :street_type => nil,
      :number => '115',
      :street => 'Broadway',
      :state => 'CA',
      :city => 'San Francisco',
    },
    "7800 Mill Station Rd, Sebastopol, CA 95472" => {
      :number => '7800',
      :street => 'Mill Station',
      :state => 'CA',
      :city => 'Sebastopol',
      :postal_code => '95472',
      :street_type => 'Rd',
    },
    "7800 Mill Station Rd Sebastopol CA 95472" => {
      :number => '7800',
      :street => 'Mill Station',
      :state => 'CA',
      :city => 'Sebastopol',
      :postal_code => '95472',
      :street_type => 'Rd',
    },
    "1005 State Highway 116 Sebastopol CA 95472" => {
      :number => '1005',
      :street => 'State Highway 116',
      :state => 'CA',
      :city => 'Sebastopol',
      :postal_code => '95472',
      :street_type => 'Hwy',
    },
    "1600 Pennsylvania Ave. Washington DC" => {
      :number => '1600',
      :street => 'Pennsylvania',
      :state => 'DC',
      :city => 'Washington',
      :street_type => 'Ave',
    },
    "1600 Pennsylvania Avenue Washington DC" => {
      :number => '1600',
      :street => 'Pennsylvania',
      :state => 'DC',
      :city => 'Washington',
      :street_type => 'Ave',
    },
    "48S 400E, Salt Lake City UT" => {
      :street_type => nil,
      :number => '48',
      :street => '400',
      :state => 'UT',
      :city => 'Salt Lake City',
      :suffix => 'E',
      :prefix => 'S'
    },
    "550 S 400 E #3206, Salt Lake City UT 84111" => {
      :number => '550',
      :street => '400',
      :state => 'UT',
      :unit => '3206',
      :postal_code => '84111',
      :city => 'Salt Lake City',
      :suffix => 'E',
      :street_type => nil,
      :unit_prefix => '#',
      :prefix => 'S'
    },
    "6641 N 2200 W Apt D304 Park City, UT 84098" => {
      :number => '6641',
      :street => '2200',
      :state => 'UT',
      :unit => 'D304',
      :postal_code => '84098',
      :city => 'Park City',
      :suffix => 'W',
      :street_type => nil,
      :unit_prefix => 'Apt',
      :prefix => 'N'
    },
    "100 South St, Philadelphia, PA" => {
      :number => '100',
      :street => 'South',
      :state => 'PA',
      :city => 'Philadelphia',
      :street_type => 'St',
    },
    "100 S.E. Washington Ave, Minneapolis, MN" => {
      :number => '100',
      :street => 'Washington',
      :state => 'MN',
      :city => 'Minneapolis',
      :street_type => 'Ave',
      :prefix => 'SE'
    },
    "3813 1/2 Some Road, Los Angeles, CA" => {
      :number => '3813',
      :street => 'Some',
      :state => 'CA',
      :city => 'Los Angeles',
      :street_type => 'Rd',
    },
    "1 First St, e San Jose CA" => { # lower case city direction
      :number => '1',
      :street => 'First',
      :state => 'CA',
      :city => 'East San Jose',
      :street_type => 'St',
    },
    "123 Maple Rochester, New York" => { # space in state name
      :street_type => nil,
      :number => '123',
      :street => 'Maple',
      :state => 'NY',
      :city => 'Rochester',
    },
    "233 S Wacker Dr 60606-6306" => { # zip+4 with hyphen
      :number => '233',
      :street => 'Wacker',
      :postal_code => '60606',
      :postal_code_ext => '6306',
      :street_type => 'Dr',
      :prefix => 'S'
    },
    "233 S Wacker Dr 606066306" => { # zip+4 without hyphen
      :number => '233',
      :street => 'Wacker',
      :postal_code => '60606',
      :postal_code_ext => '6306',
      :street_type => 'Dr',
      :prefix => 'S'
    },
    "lt42 99 Some Road, Some City LA" => { # no space before sec_unit_num
      :unit => '42',
      :city => 'Some City',
      :number => '99',
      :street => 'Some',
      :unit_prefix => 'Lt',
      :street_type => 'Rd',
      :state => 'LA'
    },
    "36401 County Road 43, Eaton, CO 80615" => { # numbered County Road
      :city => 'Eaton',
      :postal_code => '80615',
      :number => '36401',
      :street => 'County Road 43',
      :street_type => 'Rd',
      :state => 'CO'
    },
    "1234 COUNTY HWY 60E, Town, CO 12345" => {
      :city => 'Town',
      :postal_code => '12345',
      :number => '1234',
      :street => 'County Hwy 60',
      :suffix => 'E',
      :street_type => 'Hwy',
      :state => 'CO'
    },
    "'45 Quaker Ave, Ste 105'" => { # RT#73397
      :number => '45',
      :street => 'Quaker',
      :street_type => 'Ave',
      :unit => '105',
      :unit_prefix => 'Ste'
    },
    ##### pre-existing tests from ruby library
    "2730 S Veitch St Apt 207, Arlington, VA 22206" => {
      :number => "2730",
      :postal_code => "22206",
      :prefix => "S",
      :state => "VA",
      :street => "Veitch",
      :street_type => "St",
      :unit => "207",
      :unit_prefix => "Apt",
      :city => "Arlington",
      :prefix2 => nil,
      :postal_code_ext => nil
    },
    "44 Canal Center Plaza Suite 500, Alexandria, VA 22314" => {
      :number => "44",
      :postal_code => "22314",
      :prefix => nil,
      :state => "VA",
      :street => "Canal Center",
      :street_type => "Plz",
      :unit => "500",
      :unit_prefix => "Suite",
      :city => "Alexandria",
      :street2 => nil
    },
    "1600 Pennsylvania Ave Washington DC" => {
      :number => "1600",
      :postal_code => nil,
      :prefix => nil,
      :state => "DC",
      :street => "Pennsylvania",
      :street_type => "Ave",
      :unit => nil,
      :unit_prefix => nil,
      :city => "Washington",
      :street2 => nil
    },
    "1005 Gravenstein Hwy N, Sebastopol CA 95472" => {
      :number => "1005",
      :postal_code => "95472",
      :prefix => nil,
      :state => "CA",
      :street => "Gravenstein",
      :street_type => "Hwy",
      :unit => nil,
      :unit_prefix => nil,
      :city => "Sebastopol",
      :street2 => nil,
      :suffix => "N"
    },
    "2730 S Veitch St #207, Arlington, VA 22206" => {
      :number=>"2730",
      :street=>"Veitch",
      :street_type=>"St",
      :unit=>"207",
      :unit_prefix=>"#",
      :suffix=>nil,
      :prefix=>"S",
      :city=>"Arlington",
      :state=>"VA",
      :postal_code=>"22206",
      :postal_code_ext=>nil
    },
    # Numbered streets
    "123 E 42nd St, New York, NY 10017" => {
      :number => '123',
      :street => '42nd',
      :street_type => 'St',
      :prefix => 'E',
      :city => 'New York',
      :state => 'NY',
      :postal_code => '10017'
    },
    "456 W 1st Ave, Columbus, OH 43201" => {
      :number => '456',
      :street => '1st',
      :street_type => 'Ave',
      :prefix => 'W',
      :city => 'Columbus',
      :state => 'OH',
      :postal_code => '43201'
    },
    "350 5th Ave, New York, NY 10118" => {
      :number => '350',
      :street => '5th',
      :street_type => 'Ave',
      :city => 'New York',
      :state => 'NY',
      :postal_code => '10118'
    },
    # Multi-word cities
    "100 Main St, Salt Lake City, UT 84101" => {
      :number => '100',
      :street => 'Main',
      :street_type => 'St',
      :city => 'Salt Lake City',
      :state => 'UT',
      :postal_code => '84101'
    },
    "200 Oak Ave, West Palm Beach, FL 33401" => {
      :number => '200',
      :street => 'Oak',
      :street_type => 'Ave',
      :city => 'West Palm Beach',
      :state => 'FL',
      :postal_code => '33401'
    },
    "400 Pine St, San Luis Obispo, CA 93401" => {
      :number => '400',
      :street => 'Pine',
      :street_type => 'St',
      :city => 'San Luis Obispo',
      :state => 'CA',
      :postal_code => '93401'
    },
    # Multi-word street names
    "500 Martin Luther King Jr Blvd, Atlanta, GA 30303" => {
      :number => '500',
      :street => 'Martin Luther King Jr',
      :street_type => 'Blvd',
      :city => 'Atlanta',
      :state => 'GA',
      :postal_code => '30303'
    },
    "600 John F Kennedy Dr, San Francisco, CA 94118" => {
      :number => '600',
      :street => 'John F Kennedy',
      :street_type => 'Dr',
      :city => 'San Francisco',
      :state => 'CA',
      :postal_code => '94118'
    },
    # US Highway / State Route
    "1234 US Highway 20, Lexington, NE 68001" => {
      :number => '1234',
      :street => 'Us Highway 20',
      :street_type => 'Hwy',
      :city => 'Lexington',
      :state => 'NE',
      :postal_code => '68001'
    },
    "5678 State Route 9, Saratoga Springs, NY 12866" => {
      :number => '5678',
      :street => 'State Route 9',
      :street_type => 'Rte',
      :city => 'Saratoga Springs',
      :state => 'NY',
      :postal_code => '12866'
    },
    # Various unit types
    "100 Main St Fl 3, Boston, MA 02101" => {
      :number => '100',
      :street => 'Main',
      :street_type => 'St',
      :unit_prefix => 'Fl',
      :unit => '3',
      :city => 'Boston',
      :state => 'MA',
      :postal_code => '02101'
    },
    "100 Main St Rm 101, Boston, MA 02101" => {
      :number => '100',
      :street => 'Main',
      :street_type => 'St',
      :unit_prefix => 'Rm',
      :unit => '101',
      :city => 'Boston',
      :state => 'MA',
      :postal_code => '02101'
    },
    "100 Main St Bldg 5, Boston, MA 02101" => {
      :number => '100',
      :street => 'Main',
      :street_type => 'St',
      :unit_prefix => 'Bldg',
      :unit => '5',
      :city => 'Boston',
      :state => 'MA',
      :postal_code => '02101'
    },
    "100 Main St Dept A, Boston, MA 02101" => {
      :number => '100',
      :street => 'Main',
      :street_type => 'St',
      :unit_prefix => 'Dept',
      :unit => 'A',
      :city => 'Boston',
      :state => 'MA',
      :postal_code => '02101'
    },
    "100 Main St Unit 4B, Boston, MA 02101" => {
      :number => '100',
      :street => 'Main',
      :street_type => 'St',
      :unit_prefix => 'Unit',
      :unit => '4B',
      :city => 'Boston',
      :state => 'MA',
      :postal_code => '02101'
    },
    "100 Main St Apt A, Boston, MA 02101" => {
      :number => '100',
      :street => 'Main',
      :street_type => 'St',
      :unit_prefix => 'Apt',
      :unit => 'A',
      :city => 'Boston',
      :state => 'MA',
      :postal_code => '02101'
    },
    "100 Main St Apt 1A, Boston, MA 02101" => {
      :number => '100',
      :street => 'Main',
      :street_type => 'St',
      :unit_prefix => 'Apt',
      :unit => '1A',
      :city => 'Boston',
      :state => 'MA',
      :postal_code => '02101'
    },
    # Full state names
    "100 Main St, Rochester, New York 14604" => {
      :number => '100',
      :street => 'Main',
      :street_type => 'St',
      :city => 'Rochester',
      :state => 'NY',
      :postal_code => '14604'
    },
    "200 Oak Ave, Portland, Oregon 97201" => {
      :number => '200',
      :street => 'Oak',
      :street_type => 'Ave',
      :city => 'Portland',
      :state => 'OR',
      :postal_code => '97201'
    },
    # All-caps input should normalize
    "100 MAIN ST, BOSTON, MA 02101" => {
      :number => '100',
      :street => 'Main',
      :street_type => 'St',
      :city => 'Boston',
      :state => 'MA',
      :postal_code => '02101'
    },
    "1600 PENNSYLVANIA AVE, WASHINGTON, DC 20500" => {
      :number => '1600',
      :street => 'Pennsylvania',
      :street_type => 'Ave',
      :city => 'Washington',
      :state => 'DC',
      :postal_code => '20500'
    },
    # Directional abbreviations with periods
    "100 N.W. Main St, Portland, OR 97201" => {
      :number => '100',
      :street => 'Main',
      :street_type => 'St',
      :prefix => 'NW',
      :city => 'Portland',
      :state => 'OR',
      :postal_code => '97201'
    },
    # Hyphenated street number (Queens, NY style)
    "42-15 Crescent St, Long Island City, NY 11101" => {
      :number => '42-15',
      :street => 'Crescent',
      :street_type => 'St',
      :city => 'Long Island City',
      :state => 'NY',
      :postal_code => '11101'
    },
    # No street type
    "1 Broadway, New York, NY 10004" => {
      :number => '1',
      :street => 'Broadway',
      :street_type => nil,
      :city => 'New York',
      :state => 'NY',
      :postal_code => '10004'
    },
    # Famous addresses
    "1 Infinite Loop, Cupertino, CA 95014" => {
      :number => '1',
      :street => 'Infinite',
      :street_type => 'Loop',
      :city => 'Cupertino',
      :state => 'CA',
      :postal_code => '95014'
    },
    # ZIP+4 with suffix direction
    "1600 Pennsylvania Ave NW, Washington, DC 20500-0003" => {
      :number => '1600',
      :street => 'Pennsylvania',
      :street_type => 'Ave',
      :suffix => 'NW',
      :city => 'Washington',
      :state => 'DC',
      :postal_code => '20500',
      :postal_code_ext => '0003'
    },
    # State abbreviation / street type conflicts (issue #48)
    # These state codes conflict with street types: CT=Court, LA=Lane, MT=Mount
    "100 Oak Ln, Hartford, CT 06101" => {
      :number => '100',
      :street => 'Oak',
      :street_type => 'Ln',
      :city => 'Hartford',
      :state => 'CT',
      :postal_code => '06101'
    },
    "100 Main St, Louisville, KY 40202" => {
      :number => '100',
      :street => 'Main',
      :street_type => 'St',
      :city => 'Louisville',
      :state => 'KY',
      :postal_code => '40202'
    },
    "100 Bourbon St, New Orleans, LA 70116" => {
      :number => '100',
      :street => 'Bourbon',
      :street_type => 'St',
      :city => 'New Orleans',
      :state => 'LA',
      :postal_code => '70116'
    },
    "100 Main St, Billings, MT 59101" => {
      :number => '100',
      :street => 'Main',
      :street_type => 'St',
      :city => 'Billings',
      :state => 'MT',
      :postal_code => '59101'
    }
  }


  INTERSECTIONS = {
    "Mission & Valencia San Francisco CA" => {
      :street_type => nil,
      :street_type2 => nil,
      :street => 'Mission',
      :state => 'CA',
      :city => 'San Francisco',
      :street2 => 'Valencia'
    },

    "Mission & Valencia, San Francisco CA" => {
      :street_type => nil,
      :street_type2 => nil,
      :street => 'Mission',
      :state => 'CA',
      :city => 'San Francisco',
      :street2 => 'Valencia'
    },
    "Mission St and Valencia St San Francisco CA" => {
      :street_type => 'St',
      :street_type2 => 'St',
      :street => 'Mission',
      :state => 'CA',
      :city => 'San Francisco',
      :street2 => 'Valencia'
    },
    "Hollywood Blvd and Vine St Los Angeles, CA" => {
      :street_type => 'Blvd',
      :street_type2 => 'St',
      :street => 'Hollywood',
      :state => 'CA',
      :city => 'Los Angeles',
      :street2 => 'Vine'
    },
    "Mission St & Valencia St San Francisco CA" => {
      :street_type => 'St',
      :street_type2 => 'St',
      :street => 'Mission',
      :state => 'CA',
      :city => 'San Francisco',
      :street2 => 'Valencia'
    },
    "Mission and Valencia Sts San Francisco CA" => {
      :street_type => 'St',
      :street_type2 => 'St',
      :street => 'Mission',
      :state => 'CA',
      :city => 'San Francisco',
      :street2 => 'Valencia'
    },
    "Mission & Valencia Sts. San Francisco CA" => {
      :street_type => 'St',
      :street_type2 => 'St',
      :street => 'Mission',
      :state => 'CA',
      :city => 'San Francisco',
      :street2 => 'Valencia'
    },
    "Mission & Valencia Streets San Francisco CA" => {
      :street_type => 'St',
      :street_type2 => 'St',
      :street => 'Mission',
      :state => 'CA',
      :city => 'San Francisco',
      :street2 => 'Valencia'
    },
    "Mission Avenue and Valencia Street San Francisco CA" => {
      :street_type => 'Ave',
      :street_type2 => 'St',
      :street => 'Mission',
      :state => 'CA',
      :city => 'San Francisco',
      :street2 => 'Valencia'
    }
  }


  INFORMAL_ADDRESSES = {
    "#42 233 S Wacker Dr 60606" => {
      :number => "233",
      :postal_code => "60606",
      :prefix => "S",
      :state => nil,
      :street => "Wacker",
      :street_type => "Dr",
      :unit => "42",
      :unit_prefix => "#",
      :city => nil,
      :street2 => nil,
      :suffix => nil
    },
    "Apt. 42, 233 S Wacker Dr 60606" => {
      :number => "233",
      :postal_code => "60606",
      :prefix => "S",
      :state => nil,
      :street => "Wacker",
      :street_type => "Dr",
      :unit => "42",
      :unit_prefix => "Apt",
      :city => nil,
      :street2 => nil,
      :suffix => nil
    },
    "2730 S Veitch St #207" => {
      :number=>"2730",
      :street=>"Veitch",
      :street_type=>"St",
      :unit=>"207",
      :unit_prefix=>"#",
      :suffix=>nil,
      :prefix=>"S",
      :city=>nil,
      :state=>nil,
      :postal_code=>nil
    },
    # Street types that conflict with state codes (issue #48)
    # These should parse as street type, not state
    "122 Blueberry Ct" => {
      :number => '122',
      :street => 'Blueberry',
      :street_type => 'Ct',
      :state => nil
    },
    "122 N Virginia" => {
      :number => '122',
      :street => 'Virginia',
      :prefix => 'N',
      :street_type => nil,
      :state => nil
    },
    "100 Main La" => {
      :number => '100',
      :street => 'Main',
      :street_type => 'Ln',
      :state => nil
    },
    "100 Elm Mt" => {
      :number => '100',
      :street => 'Elm',
      :street_type => 'Mt',
      :state => nil
    },
    "321 S. Washington" => { # RT#82146
      :street_type => nil,
      :prefix => 'S',
      :street => 'Washington',
      :number => '321'
    },
    "233 S Wacker Dr lobby 60606" => { # unnumbered secondary unit type
      :number => '233',
      :street => 'Wacker',
      :postal_code => '60606',
      :street_type => 'Dr',
      :prefix => 'S',
      :unit_prefix => 'Lobby',
    },
    "(233 S Wacker Dr lobby 60606)" => { # surrounding punctuation
      :number => '233',
      :street => 'Wacker',
      :postal_code => '60606',
      :street_type => 'Dr',
      :prefix => 'S',
      :unit_prefix => 'Lobby',
    }
  }


  # Addresses that should either return nil or not produce a valid state.
  # These represent known unsupported formats.
  EXPECTED_FAILURES = [
    "1005 N Gravenstein Hwy Sebastopol",      # no state, ambiguous city
    "1005 N Gravenstein Hwy Sebastopol CZ",    # invalid state code
    "Gravenstein Hwy 95472",                   # no street number
    "E1005 Gravenstein Hwy 95472",             # letter prefix on number
    "PO BOX 450, Chicago IL 60657",            # PO Box not supported
    "PSC 1234, Box 12345, APO AE 09001",       # military APO address
    "RR 1 Box 234, Smalltown, KS 67890",       # rural route
    "HC 68 Box 23, Ruralville, NM 87001",      # highway contract route
    "General Delivery, Anytown, US 99999",     # general delivery
  ].freeze

  # Addresses that parse but produce incorrect results due to
  # limitations in the regex engine. These should be fixed in
  # future versions.
  KNOWN_MISPARSES = [
    "1S155 Myrtle Ave, Oakbrook Terrace, IL 60181", # DuPage County grid number
    "500 BROADWAY APT 1E, NEW YORK NY 10012", # directional letter in unit number (issue #52)
    "500 BROADWAY APT 2N, NEW YORK NY 10012", # directional letter in unit number (issue #52)
    "500 BROADWAY APT 3W, NEW YORK NY 10012", # directional letter in unit number (issue #52)
    "500 BROADWAY APT 4S, NEW YORK NY 10012", # directional letter in unit number (issue #52)
  ].freeze


  def test_address_parsing
    ADDRESSES.each_pair do |address, expected|
      addr = StreetAddress::US.parse(address)
      assert_equal addr.intersection?, false
      compare_expected_to_actual_hash(expected, addr.to_h, address)
    end
  end

  def test_informal_address_parsing
    INFORMAL_ADDRESSES.each_pair do |address, expected|
      addr = StreetAddress::US.parse(address)
      compare_expected_to_actual_hash(expected, addr.to_h, address)
    end
  end


  def test_intersection_address_parsing
    INTERSECTIONS.each_pair do |address, expected|
      addr = StreetAddress::US.parse(address)
      assert_equal addr.intersection?, true
      compare_expected_to_actual_hash(expected, addr.to_h, address)
    end
  end


  def test_expected_failures
    EXPECTED_FAILURES.each do |address|
      parsed_address = StreetAddress::US.parse(address)
      assert !parsed_address || !parsed_address.state
    end
  end


  def test_street_type_is_nil_for_road_redundant_street_types
    address = "36401 County Road 43, Eaton, CO 80615"
    expected_results = {
      :number => '36401',
      :street => 'County Road 43',
      :city   => 'Eaton',
      :state  => 'CO',
      :postal_code => '80615',
      :street_type => nil
    }
    parsed_address = StreetAddress::US.parse(address, avoid_redundant_street_type: true)
    compare_expected_to_actual_hash(expected_results, parsed_address.to_h, address)
  end


  def test_zip_plus_4_with_dash
    addr = StreetAddress::US.parse("2730 S Veitch St, Arlington, VA 22206-3333")
    assert_equal "3333", addr.postal_code_ext
  end

  def test_zip_plus_4_without_dash
    addr = StreetAddress::US.parse("2730 S Veitch St, Arlington, VA 222064444")
    assert_equal "4444", addr.postal_code_ext
  end

  def test_informal_parse_normal_address
    a = StreetAddress::US.parse("2730 S Veitch St, Arlington, VA 222064444")
    assert_equal "2730", a.number
    assert_equal "S", a.prefix
    assert_equal "Veitch", a.street
    assert_equal "St", a.street_type
    assert_equal "Arlington", a.city
    assert_equal "VA", a.state
    assert_equal "22206", a.postal_code
    assert_equal "4444", a.postal_code_ext
  end

  def test_informal_parse_informal_address
    a = StreetAddress::US.parse("2730 S Veitch St")
    assert_equal "2730", a.number
    assert_equal "S", a.prefix
    assert_equal "Veitch", a.street
    assert_equal "St", a.street_type
  end

  def test_informal_parse_informal_address_trailing_words
    a = StreetAddress::US.parse("2730 S Veitch St in the south of arlington")
    assert_equal "2730", a.number
    assert_equal "S", a.prefix
    assert_equal "Veitch", a.street
    assert_equal "St", a.street_type
  end

  def test_parse
    assert_nil StreetAddress::US.parse("&")
    assert_nil StreetAddress::US.parse(" and ")

    parseable = [
      "1600 Pennsylvania Ave Washington DC 20006",
      "1600 Pennsylvania Ave #400, Washington, DC, 20006",
      "1600 Pennsylvania Ave Washington, DC",
      "1600 Pennsylvania Ave #400 Washington DC",
      "1600 Pennsylvania Ave, 20006",
      "1600 Pennsylvania Ave #400, 20006",
      "1600 Pennsylvania Ave 20006",
      "1600 Pennsylvania Ave #400 20006",
      "Hollywood & Vine, Los Angeles, CA",
      "Hollywood Blvd and Vine St, Los Angeles, CA",
      "Mission Street at Valencia Street, San Francisco, CA",
      "Hollywood & Vine, Los Angeles, CA, 90028",
      "Hollywood Blvd and Vine St, Los Angeles, CA, 90028",
      "Mission Street at Valencia Street, San Francisco, CA, 90028"
    ]

    parseable.each do |location|
      assert(StreetAddress::US.parse(location), location + " was not parseable")
    end

  end

  def test_comparison
    addr = StreetAddress::US.parse(ADDRESSES.first[0])
    assert_equal addr, "1005 Gravenstein Hwy, 95472"
    assert_equal addr, StreetAddress::US.parse(ADDRESSES.first[0])
    refute_equal addr, StreetAddress::US.parse(EXPECTED_FAILURES.first)
    refute_equal addr, nil
  end

  def test_known_misparses
    # These addresses parse but produce incorrect field values.
    # This test documents them and ensures they at least don't raise.
    KNOWN_MISPARSES.each do |address|
      addr = StreetAddress::US.parse(address)
      assert addr, "#{address} should parse (even if incorrectly)"
    end
  end

  def test_to_h
    addr = StreetAddress::US.parse("1600 Pennsylvania Ave, Washington, DC 20500")
    hash = addr.to_h
    assert_equal "1600", hash[:number]
    assert_equal "Pennsylvania", hash[:street]
    assert_equal "Ave", hash[:street_type]
    assert_equal "Washington", hash[:city]
    assert_equal "DC", hash[:state]
    assert_equal "20500", hash[:postal_code]
    assert_nil hash[:unit]
    assert_nil hash[:street2]
  end

  def test_to_h_with_intersection
    addr = StreetAddress::US.parse("Hollywood Blvd and Vine St, Los Angeles, CA")
    hash = addr.to_h
    assert_equal "Hollywood", hash[:street]
    assert_equal "Blvd", hash[:street_type]
    assert_equal "Vine", hash[:street2]
    assert_equal "St", hash[:street_type2]
    assert_equal "Los Angeles", hash[:city]
  end

  def test_state_name
    addr = StreetAddress::US.parse("100 Main St, Rochester, NY 14604")
    assert_equal "New York", addr.state_name
  end

  def test_state_name_multi_word
    addr = StreetAddress::US.parse("1600 Pennsylvania Ave, Washington, DC 20500")
    assert_equal "District Of Columbia", addr.state_name
  end

  def test_state_name_nil_state
    addr = StreetAddress::US.parse("100 Main St")
    assert_nil addr.state_name
  end

  def test_state_fips
    addr = StreetAddress::US.parse("100 Main St, Rochester, NY 14604")
    assert_equal "36", addr.state_fips
  end

  def test_state_fips_nil_state
    addr = StreetAddress::US.parse("100 Main St")
    assert_nil addr.state_fips
  end

  def test_full_postal_code_with_ext
    addr = StreetAddress::US.parse("100 Main St, Boston, MA 02101-1234")
    assert_equal "02101-1234", addr.full_postal_code
  end

  def test_full_postal_code_without_ext
    addr = StreetAddress::US.parse("100 Main St, Boston, MA 02101")
    assert_equal "02101", addr.full_postal_code
  end

  def test_full_postal_code_nil
    addr = StreetAddress::US.parse("100 Main St, Boston, MA")
    assert_nil addr.full_postal_code
  end

  def test_intersection_flag
    addr = StreetAddress::US.parse("Hollywood Blvd and Vine St, Los Angeles, CA")
    assert addr.intersection?

    addr = StreetAddress::US.parse("1600 Pennsylvania Ave, Washington, DC 20500")
    refute addr.intersection?
  end

  def compare_expected_to_actual_hash(expected, actual, address)
    expected.each_pair do |expected_key, expected_value|
      if expected_value.nil?
        assert_nil actual[expected_key], "For address '#{address}', expected nil for #{expected_key} but got #{actual[expected_key]}"
      else
        assert_equal expected_value, actual[expected_key], "For address '#{address}', expected #{expected_key}=#{expected_value} but got #{actual[expected_key]}"
      end
    end
  end

end
