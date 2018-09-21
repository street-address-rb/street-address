require 'minitest/autorun'
require 'street_address'

class StreetAddressCaTest < MiniTest::Test
  ADDRESSES = {
    "33112 Marshall Rd, V2S 1K5" => {
      :number => '33112',
      :street => 'Marshall',
      :street_type => 'Rd',
      :postal_code => 'V2S 1K5'
    },
    "33112 Marshall Rd N, V2S 1K5" => {
      :number => '33112',
      :street => 'Marshall',
      :street_type => 'Rd',
      :postal_code => 'V2S 1K5',
      :suffix => 'N'
    },
    "33112 Marshall Rd North, V2S 1K5" => {
      :number => '33112',
      :street => 'Marshall',
      :street_type => 'Rd',
      :postal_code => 'V2S 1K5',
      :suffix => 'N'
    },
    "33112 Marshall Rd, Abbotsford, BC" => {
      :number => '33112',
      :street => 'Marshall',
      :street_type => 'Rd',
      :city => 'Abbotsford',
      :state => 'BC'
    },
    "33112 N Marshall Road, Abbotsford, BC" => {
      :number => '33112',
      :street => 'Marshall',
      :street_type => 'Rd',
      :city => 'Abbotsford',
      :state => 'BC',
      :prefix => 'N'
    },
    "33112 N Marshall Rd, Suite 250, Abbotsford, BC" => {
      :number => '33112',
      :street => 'Marshall',
      :street_type => 'Rd',
      :city => 'Abbotsford',
      :state => 'BC',
      :prefix => 'N',
      :unit_prefix => 'Suite',
      :unit => '250'
    },
    "33112 N Marshall Rd Suite 250 Abbotsford, BC" => {
      :number => '33112',
      :street => 'Marshall',
      :street_type => 'Rd',
      :city => 'Abbotsford',
      :state => 'BC',
      :prefix => 'N',
      :unit_prefix => 'Suite',
      :unit => '250'
    },
    "33112 Marshall Rd, Abbotsford, BC V2S 1K5" => {
      :number => '33112',
      :street => 'Marshall',
      :street_type => 'Rd',
      :city => 'Abbotsford',
      :state => 'BC',
      :postal_code => 'V2S 1K5'
    },
    "33112 Marshall Rd, Abbotsford, BC V2S1K5" => {
      :number => '33112',
      :street => 'Marshall',
      :street_type => 'Rd',
      :city => 'Abbotsford',
      :state => 'BC',
      :postal_code => 'V2S 1K5'
    },
    # "33112 Marshall Rd Abbotsford BC V2S 1K5" => {
    #   :number => '33112',
    #   :street => 'Marshall',
    #   :street_type => 'Rd',
    #   :city => 'Abbotsford',
    #   :state => 'BC',
    #   :postal_code => 'V2S 1K5'
    # },
    "33112 Marshall Rd N Abbotsford BC" => {
      :number => '33112',
      :street => 'Marshall',
      :street_type => 'Rd',
      :city => 'Abbotsford',
      :state => 'BC',
      :suffix => 'N'
    },
    "33112 Marshall Rd N, Abbotsford BC" => {
      :number => '33112',
      :street => 'Marshall',
      :street_type => 'Rd',
      :city => 'Abbotsford',
      :state => 'BC',
      :suffix => 'N'
    },
    "33112 Marshall Rd, N Abbotsford BC" => {
      :number => '33112',
      :street => 'Marshall',
      :street_type => 'Rd',
      :city => 'North Abbotsford',
      :state => 'BC',
    },
    "33112 Marshall Rd, North Abbotsford BC" => {
      :number => '33112',
      :street => 'Marshall',
      :street_type => 'Rd',
      :city => 'North Abbotsford',
      :state => 'BC',
    },
    "33112 Marshall Rd Abbotsford BC" => {
      :number => '33112',
      :street => 'Marshall',
      :street_type => 'Rd',
      :city => 'Abbotsford',
      :state => 'BC',
    },
    "33112 Marshall Square Abbotsford BC" => {
      :number => '33112',
      :street => 'Marshall',
      :street_type => 'Sq',
      :city => 'Abbotsford',
      :state => 'BC',
    },
    "33112 Marshall Rd Apt 10 Abbotsford BC" => {
      :number => '33112',
      :street => 'Marshall',
      :street_type => 'Rd',
      :city => 'Abbotsford',
      :state => 'BC',
      :unit_prefix => 'Apt',
      :unit => '10'
    },
    "33112 Marshall Rd #10 Abbotsford BC" => {
      :number => '33112',
      :street => 'Marshall',
      :street_type => 'Rd',
      :city => 'Abbotsford',
      :state => 'BC',
      :unit_prefix => '#',
      :unit => '10'
    },
    "4920 190 St NW, Edmonton, AB T6M, Canada" => {
      :number => '4920',
      :street => '190',
      :street_type => 'St',
      :suffix => 'NW',
      :city => 'Edmonton',
      :state => 'AB',
      :postal_code => 'T6M',
      :country => 'Canada'
    },
    "21265 93 Ave, Langley, BC V1M 1K3, Canada" => {
      :number => '21265',
      :street => '93',
      :street_type => 'Ave',
      :city => 'Langley',
      :state => 'BC',
      :postal_code => 'V1M 1K3',
      :country => 'Canada'
    },
    "245 Chapalina Mews SW, Calgary, Alberta T0L, Canada" => {
      :number => '245',
      :street => 'Chapalina',
      :street_type => 'Mews',
      :suffix => 'SW',
      :city => 'Calgary',
      :state => 'AB',
      :postal_code => 'T0L',
      :country => 'Canada'
    },
    "23 Elgin Terrace, Calgary, AB T2Z 0B7, Canada" => {
      :number => '23',
      :street => 'Elgin',
      :street_type => 'Terr',
      :city => 'Calgary',
      :state => 'AB',
      :postal_code => 'T2Z 0B7',
      :country => 'Canada'
    },
    "34909 Old Yale Rd, Abbotsford, British Columbia V3G 2E7, Canada" => {
      :number => '34909',
      :street => 'Old Yale',
      :street_type => 'Rd',
      :city => 'Abbotsford',
      :state => 'BC',
      :postal_code => 'V3G 2E7',
      :country => 'Canada'
    },
    # TODO
    # "1-9229 University Crescent, Burnaby, BC, Canada" => {
    #   :number => '',
    #   :street => '',
    #   :street_type => '',
    #   :city => '',
    #   :postal_code => ''
    #   :state => ''
    # },
    "909 Sutherland Ave, North Vancouver, BC V7L 4A4, Canada" => {
      :number => '909',
      :street => 'Sutherland',
      :street_type => 'Ave',
      :city => 'North Vancouver',
      :state => 'BC',
      :postal_code => 'V7L 4A4',
      :country => 'Canada'
    },
    "5724 90 Avenue Northwest, Edmonton, AB, Canada" => {
      :number => '5724',
      :street => '90',
      :street_type => 'Ave',
      :suffix => 'NW',
      :city => 'Edmonton',
      :state => 'AB',
      :country => 'Canada'
    },
    # TODO
    # "22 Ave, Surrey, BC V4A, Canada" => {
    #   :number => nil,
    #   :street => '22',
    #   :street_type => 'Ave',
    #   :city => 'Surrey',
    #   :state => 'BC',
    #   :postal_code => 'V4A'
    # },
    "613 Butchart Wynd NW, Edmonton, AB T6R, Canada" => {
      :number => '613',
      :street => 'Butchart',
      :street_type => 'Wynd',
      :suffix => 'NW',
      :city => 'Edmonton',
      :state => 'AB',
      :postal_code => 'T6R',
      :country => 'Canada'
    },
    "16739 77 Ave, Surrey, BC V4N 0L3, Canada" => {
      :number => '16739',
      :street => '77',
      :street_type => 'Ave',
      :city => 'Surrey',
      :state => 'BC',
      :postal_code => 'V4N 0L3',
      :country => 'Canada'
    },
    "17719 86 Ave NE, Edmonton, AB T5T, Canada" => {
      :number => '17719',
      :street => '86',
      :street_type => 'Ave',
      :suffix => 'NE',
      :city => 'Edmonton',
      :state => 'AB',
      :postal_code => 'T5T',
      :country => 'Canada'
    },
    "5606 Pierre Court, Beaumont, AB, Canada" => {
      :number => '5606',
      :street => 'Pierre',
      :street_type => 'Crt',
      :city => 'Beaumont',
      :state => 'AB',
      :postal_code => nil,
      :country => 'Canada'
    },
    "3203 42A Avenue Northwest, Edmonton, AB, Canada" => {
      :number => '3203',
      :street => '42A',
      :street_type => 'Ave',
      :suffix => 'NW',
      :city => 'Edmonton',
      :state => 'AB',
      :postal_code => nil,
      :country => 'Canada'
    },
    "11769 Summit Crescent, Delta, BC V4E 2Z3, Canada" => {
      :number => '11769',
      :street => 'Summit',
      :street_type => 'Cres',
      :city => 'Delta',
      :state => 'BC',
      :postal_code => 'V4E 2Z3',
      :country => 'Canada'
    },
    "5104 106A St NW, Edmonton, AB T6H, Canada" => {
      :number => '5104',
      :street => '106A',
      :street_type => 'St',
      :suffix => 'NW',
      :city => 'Edmonton',
      :state => 'AB',
      :postal_code => 'T6H',
      :country => 'Canada'
    },
    "6908 166th Avenue Northwest, Edmonton, AB, Canada" => {
      :number => '6908',
      :street => '166th',
      :street_type => 'Ave',
      :suffix => 'NW',
      :city => 'Edmonton',
      :state => 'AB',
      :postal_code => nil,
      :country => 'Canada'
    },
    "17422 0 A Ave, Surrey, BC V3S 9P3, Canada" => {
      :number => '17422',
      :street => '0 A',
      :street_type => 'Ave',
      :city => 'Surrey',
      :state => 'BC',
      :postal_code => 'V3S 9P3',
      :country => 'Canada'
    },
    "99 Spruce Place Southwest, Calgary, AB T3C 3X7, Canada" => {
      :number => '99',
      :street => 'Spruce',
      :street_type => 'Pl',
      :city => 'Calgary',
      :state => 'AB',
      :postal_code => 'T3C 3X7',
      :country => 'Canada'
    },
    "164 Endeavour Drive, Cambridge ON N3C 4C9, Canada" => {
      :number => '164',
      :street => 'Endeavour',
      :street_type => 'Dr',
      :city => 'Cambridge',
      :state => 'ON',
      :postal_code => 'N3C 4C9',
      :country => 'Canada'
    },
    "164 Endeavour Drive, Cambridge, Ontario N3C, Canada" => {
      :number => '164',
      :street => 'Endeavour',
      :street_type => 'Dr',
      :city => 'Cambridge',
      :state => 'ON',
      :postal_code => 'N3C',
      :country => 'Canada'
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


  EXPECTED_FAILURES =  [
    "1005 N Gravenstein Hwy Sebastopol",
    "1005 N Gravenstein Hwy Sebastopol CZ",
    "Gravenstein Hwy 95472",
    "E1005 Gravenstein Hwy 95472",
    # "1005E Gravenstein Hwy 95472"
    ## adding from original ruby test suite
    "PO BOX 450, Chicago IL 60657"
  ]


  def test_address_parsing
    ADDRESSES.each_pair do |address, expected|
      addr = StreetAddress::CA.parse(address)
      assert_equal addr.intersection?, false
      compare_expected_to_actual_hash(expected, addr.to_h, address)
    end
  end

  def test_informal_address_parsing
    skip 'Not implemented'
    INFORMAL_ADDRESSES.each_pair do |address, expected|
      addr = StreetAddress::CA.parse(address, informal: true)
      compare_expected_to_actual_hash(expected, addr.to_h, address)
    end
  end


  def test_intersection_address_parsing
    skip 'Not implemented'
    INTERSECTIONS.each_pair do |address, expected|
      addr = StreetAddress::CA.parse(address)
      assert_equal addr.intersection?, true
      compare_expected_to_actual_hash(expected, addr.to_h, address)
    end
  end


  def test_expected_failures
    EXPECTED_FAILURES.each do |address|
      parsed_address = StreetAddress::CA.parse(address)
      assert !parsed_address || !parsed_address.state
    end
  end


  def test_street_type_is_nil_for_road_redundant_street_types
    skip
    address = "36401 County Road 43, Eaton, CO 80615"
    expected_results = {
      :number => '36401',
      :street => 'County Road 43',
      :city   => 'Eaton',
      :state  => 'CO',
      :postal_code => '80615',
      :street_type => nil
    }
    parsed_address = StreetAddress::CA.parse(address, avoid_redundant_street_type: true)
    compare_expected_to_actual_hash(expected_results, parsed_address.to_h, address)
  end


  def test_informal_parse_normal_address
    skip
    a = StreetAddress::CA.parse("2730 S Veitch St, Arlington, VA 222064444", informal: true)
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
    skip
    a = StreetAddress::CA.parse("2730 S Veitch St", informal: true)
    assert_equal "2730", a.number
    assert_equal "S", a.prefix
    assert_equal "Veitch", a.street
    assert_equal "St", a.street_type
  end

  def test_informal_parse_informal_address_trailing_words
    skip
    a = StreetAddress::CA.parse("2730 S Veitch St in the south of arlington", informal: true)
    assert_equal "2730", a.number
    assert_equal "S", a.prefix
    assert_equal "Veitch", a.street
    assert_equal "St", a.street_type
  end

  def test_parse
    skip
    assert_nil StreetAddress::CA.parse("&")
    assert_nil StreetAddress::CA.parse(" and ")

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
      assert(StreetAddress::CA.parse(location), location + " was not parseable")
    end

  end

  def test_comparison
    addr = StreetAddress::CA.parse(ADDRESSES.first[0])
    assert_equal addr.to_s, "33112 Marshall Rd, V2S 1K5"
    assert_equal addr, StreetAddress::CA.parse(ADDRESSES.first[0])
    refute_equal addr, StreetAddress::CA.parse(EXPECTED_FAILURES.first)
    refute_equal addr, nil
  end

  def compare_expected_to_actual_hash(expected, actual, address)
    expected.each_pair do |expected_key, expected_value|
      if expected_value
        assert_equal expected_value, actual[expected_key], "For address '#{address}',  #{actual[expected_key]} != #{expected_value}"
      else
        assert_nil actual[expected_key], "For address '#{address}', #{actual[expected_key]} != nil"
      end
    end
  end

end
