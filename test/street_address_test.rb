require 'minitest/autorun'
require 'street_address'

class StreetAddressTest < MiniTest::Test
  def test_parse
    assert_nil StreetAddress.parse("&")
    assert_nil StreetAddress.parse(" and ")

    parseable = {
      nil => [
        "33112 Marshall Rd, Abbotsford, BC V2S 1K5",
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
      ],
      'United States' => [
        "1600 Pennsylvania Ave Washington DC 20006 USA",
        "1600 Pennsylvania Ave #400, Washington, DC, 20006, U.S.A",
        "1600 Pennsylvania Ave Washington, DC United States",
        "1600 Pennsylvania Ave #400 Washington DC, U.S.",
      ],
      'Canada' => [
        "33112 Marshall Rd, Abbotsford, BC V2S 1K5, CAN",
        "33112 Marshall Rd, Abbotsford, BC V2S 1K5, Canada",
        "33112 Marshall Rd, Abbotsford, BC V2S1K5, Canada",
        "164 Endeavour Drive, Cambridge ON N3C 4C9, Canada",
        "164 Endeavour Drive, Cambridge, Ontario N3C, Canada",
        "210 Fir Street, Sherwood Park, Alberta T8A 2G6, Canada"
      ]
    }

    parseable.each do |country, locations|
      locations.each do |location|
        parsed = StreetAddress.parse(location)
        assert(parsed, location + " was not parseable")
        if country
          assert_equal(country, parsed.country, location)
        else
          assert_nil(parsed.country, location)
        end
      end
    end

  end
end
