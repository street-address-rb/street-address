# frozen_string_literal: true

$LOAD_PATH.unshift "lib"

require "street_address"
require "address"

Gem::Specification.new do |s|
  s.name = "StreetAddress"
  s.licenses = ["MIT"]
  s.version = StreetAddress::VERSION
  s.date = Time.now.utc.strftime("%Y-%m-%d")
  s.summary = "Parse Addresses into substituent parts. This gem includes US only."
  s.authors = ["Derrek Long"]
  s.require_paths = ["lib"]
  s.email = "derreklong@gmail.com"
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test/*`.split("\n")
  s.homepage = "https://github.com/street-address-rb/street-address"
  s.description = <<-DESC
    StreetAddress allows you to send any string to parse and if the string is a US
    address returns an object of the address broken into it's substituent parts.

    A port of Geo::StreetAddress by Schuyler D. Erle and Tim Bunce.
  DESC

  s.add_development_dependency "bundler"
  s.add_development_dependency "minitest"
  s.add_development_dependency "rake"
end
