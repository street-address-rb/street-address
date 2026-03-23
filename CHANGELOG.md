# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/).

## [2.0.0] - 2026-03-23

### Added
- `line1` and `line2` methods for USPS-formatted address lines
- `to_s` with format argument (`:line1`, `:line2`, `:default`)
- `to_h` method to convert address to a hash
- `full_postal_code` method (returns "12345" or "12345-6789")
- `==` comparison operator for Address objects
- `state_fips` and `state_name` methods
- `avoid_redundant_street_type` option for `parse`
- ZIP+4 support (with or without hyphen)
- Informal address parsing (partial addresses without city/state)
- City directional expansion ("e San Jose" → "East San Jose")
- Word capitalization normalization for street, city, unit_prefix
- GitHub Actions CI (Ruby 3.3 and 3.4)
- CHANGELOG.md

### Changed
- Minimum Ruby version is now 3.3 (dropped support for Ruby < 3.3)
- Named capture groups in regexes replace positional match indices
- `\A`/`\z` anchors replace `^`/`$` for correctness with multiline strings
- Modernized gemspec (removed shell commands, added metadata)
- Replaced CircleCI with GitHub Actions

### Removed
- CircleCI configuration (replaced by GitHub Actions)
- Inline rdoc blocks (moved to README)

### Fixed
- `MiniTest::Test` → `Minitest::Test` for modern Minitest compatibility
- Duplicate `unit_regexp` declaration in `attr_accessor` block
- `assert_equal nil` → `assert_nil` in tests for modern Minitest

## [1.0.6] - 2014-12-21

### Fixed
- Various bug fixes and improvements

## [1.0.0] - 2011-08-05

- Initial release as a Ruby gem
- Port of Perl module Geo::StreetAddress::US
