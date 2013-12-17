require 'test/unit'
require 'street_address'


class StreetAddressUsTest < Test::Unit::TestCase
  def setup
    @addr1 = "2730 S Veitch St Apt 207, Arlington, VA 22206"
    @addr2 = "44 Canal Center Plaza Suite 500, Alexandria, VA 22314"
    @addr3 = "1600 Pennsylvania Ave Washington DC"
    @addr4 = "1005 Gravenstein Hwy N, Sebastopol CA 95472"
    @addr5 = "PO BOX 450, Chicago IL 60657"
    @addr6 = "2730 S Veitch St #207, Arlington, VA 22206"

    @int1 = "Hollywood & Vine, Los Angeles, CA"
    @int2 = "Hollywood Blvd and Vine St, Los Angeles, CA"
    @int3 = "Mission Street at Valencia Street, San Francisco, CA"

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
    a = StreetAddress::US.parse("2730 S Veitch St, Arlington, VA 222064444", :informal => true)
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
    a = StreetAddress::US.parse("2730 S Veitch St", :informal => true)
    assert_equal "2730", a.number
    assert_equal "S", a.prefix
    assert_equal "Veitch", a.street
    assert_equal "St", a.street_type
  end

  def test_informal_parse_informal_address_trailing_words
    a = StreetAddress::US.parse("2730 S Veitch St in the south of arlington", :informal => true)
    assert_equal "2730", a.number
    assert_equal "S", a.prefix
    assert_equal "Veitch", a.street
    assert_equal "St", a.street_type
  end

  def test_parse
    assert_equal StreetAddress::US.parse("&"), nil
    assert_equal StreetAddress::US.parse(" and "), nil

    addr = StreetAddress::US.parse(@addr1)
    assert_equal addr.number, "2730"
    assert_equal addr.postal_code, "22206"
    assert_equal addr.prefix, "S"
    assert_equal addr.state, "VA"
    assert_equal addr.street, "Veitch"
    assert_equal addr.street_type, "St"
    assert_equal addr.unit, "207"
    assert_equal addr.unit_prefix, "Apt"
    assert_equal addr.city, "Arlington"
    assert_equal addr.prefix2, nil
    assert_equal addr.postal_code_ext, nil

    addr = StreetAddress::US.parse(@addr2)
    assert_equal addr.number, "44"
    assert_equal addr.postal_code, "22314"
    assert_equal addr.prefix, nil
    assert_equal addr.state, "VA"
    assert_equal addr.street, "Canal Center"
    assert_equal addr.street_type, "Plz"
    assert_equal addr.unit, "500"
    assert_equal addr.unit_prefix, "Suite"
    assert_equal addr.city, "Alexandria"
    assert_equal addr.street2, nil

    addr = StreetAddress::US.parse(@addr3)
    assert_equal addr.number, "1600"
    assert_equal addr.postal_code, nil
    assert_equal addr.prefix, nil
    assert_equal addr.state, "DC"
    assert_equal addr.street, "Pennsylvania"
    assert_equal addr.street_type, "Ave"
    assert_equal addr.unit, nil
    assert_equal addr.unit_prefix, nil
    assert_equal addr.city, "Washington"
    assert_equal addr.street2, nil


 
    addr = StreetAddress::US.parse(@addr4)
    assert_equal addr.number, "1005"
    assert_equal addr.postal_code, "95472"
    assert_equal addr.prefix, nil
    assert_equal addr.state, "CA"
    assert_equal addr.street, "Gravenstein"
    assert_equal addr.street_type, "Hwy"
    assert_equal addr.unit, nil
    assert_equal addr.unit_prefix, nil
    assert_equal addr.city, "Sebastopol"
    assert_equal addr.street2, nil
    assert_equal addr.suffix, "N"

  
    addr = StreetAddress::US.parse(@addr5)
    assert_equal addr, nil
    
    
    addr = StreetAddress::US.parse(@addr6)
    assert_equal("207", addr.unit)

    addr = StreetAddress::US.parse(@int1)
    assert_equal addr.city, "Los Angeles"
    assert_equal addr.state, "CA"
    assert_equal addr.street, "Hollywood"
    assert_equal addr.street2, "Vine"
    assert_equal addr.number, nil
    assert_equal addr.postal_code, nil
    assert_equal addr.intersection?, true

    addr = StreetAddress::US.parse(@int2)
    assert_equal addr.city, "Los Angeles"
    assert_equal addr.state, "CA"
    assert_equal addr.street, "Hollywood"
    assert_equal addr.street2, "Vine"
    assert_equal addr.number, nil
    assert_equal addr.postal_code, nil
    assert_equal addr.intersection?, true
    assert_equal addr.street_type, "Blvd"
    assert_equal addr.street_type2, "St"
    assert_equal addr.line1, "Hollywood Blvd and Vine St"

    addr = StreetAddress::US.parse(@int3)
    assert_equal addr.city, "San Francisco"
    assert_equal addr.state, "CA"
    assert_equal addr.street, "Mission"
    assert_equal addr.street2, "Valencia"
    assert_equal addr.number, nil
    assert_equal addr.postal_code, nil
    assert_equal addr.intersection?, true
    assert_equal addr.street_type, "St"
    assert_equal addr.street_type2, "St"
    
    parseable = ["1600 Pennsylvania Ave Washington DC 20006", 
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
          "Mission Street at Valencia Street, San Francisco, CA, 90028"]
    
    parseable.each do |location|
      assert_not_nil(StreetAddress::US.parse(location), location + " was not parse able")
    end

  end

end
