# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = "StreetAddress"
  s.version = "2.0.0"
  s.licenses = ["MIT"]
  s.summary = "Parse US street addresses into constituent parts."
  s.description = <<~DESC
    StreetAddress::US allows you to send any string to parse and if the string
    is a US address returns an object of the address broken into its constituent parts.

    A port of Geo::StreetAddress::US by Schuyler D. Erle and Tim Bunce.
  DESC

  s.authors = ["Derrek Long"]
  s.email = "derreklong@gmail.com"
  s.homepage = "https://github.com/street-address-rb/street-address"

  s.required_ruby_version = ">= 3.3"
  s.require_paths = ["lib"]
  s.files = Dir.glob(%w[lib/**/*.rb LICENCE README.md CHANGELOG.md])

  s.metadata = {
    "source_code_uri" => s.homepage,
    "changelog_uri" => "#{s.homepage}/blob/master/CHANGELOG.md",
    "bug_tracker_uri" => "#{s.homepage}/issues"
  }

  s.add_development_dependency "bundler", "~> 2.0"
  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "minitest", "~> 5.0"
  s.add_development_dependency "irb", "~> 1.14"
  s.add_development_dependency "rdoc", "~> 6.0"
end
