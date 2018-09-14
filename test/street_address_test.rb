require 'minitest/autorun'
require 'street_address'

class StreetAddressTest < MiniTest::Test
  def test_parse
    assert_nil StreetAddress.parse("&")
    assert_nil StreetAddress.parse(" and ")

    parseable = [
      "1600 Pennsylvania Ave Washington DC 20006 USA",
      "1600 Pennsylvania Ave #400, Washington, DC, 20006, U.S.A",
      "1600 Pennsylvania Ave Washington, DC United States",
      "1600 Pennsylvania Ave #400 Washington DC, U.S.",
      "1600 Pennsylvania Ave, 20006",
      "1600 Pennsylvania Ave #400, 20006",
      "1600 Pennsylvania Ave 20006",
      "1600 Pennsylvania Ave #400 20006",
      "Hollywood & Vine, Los Angeles, CA",
      "Hollywood Blvd and Vine St, Los Angeles, CA",
      "Mission Street at Valencia Street, San Francisco, CA",
      "Hollywood & Vine, Los Angeles, CA, 90028",
      "Hollywood Blvd and Vine St, Los Angeles, CA, 90028",
      "Mission Street at Valencia Street, San Francisco, CA, 90028",
      "33112 Marshall Rd, Abbotsford, BC V2S 1K5",
      "33112 Marshall Rd, Abbotsford, BC V2S 1K5, CAN",
      "33112 Marshall Rd, Abbotsford, BC V2S 1K5, Canada"
    ]

    parseable.each do |location|
      assert(StreetAddress.parse(location), location + " was not parseable")
    end

  end
end
