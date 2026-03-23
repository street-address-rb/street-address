# StreetAddress Ruby Gem

## Project Overview
US street address parser gem (`StreetAddress`). Parses address strings into normalized `StreetAddress::US::Address` objects. Port of Perl's `Geo::StreetAddress::US`. Single-file library at `lib/street_address.rb` (~925 lines).

## Quick Commands
```bash
bundle exec rake test    # run tests
```

## Project Structure
```
lib/street_address.rb           # entire library (module, parser, Address class)
test/street_address_test.rb     # parsing tests (Minitest)
test/address_test.rb            # output formatting tests (Minitest)
street_address.gemspec          # gem spec (loads VERSION from lib)
```

## Key Technical Details
- **Version**: 2.0.0 in source, but only 1.0.6 published to RubyGems
- **Ruby**: Tested against 1.9.3–2.2.0 (via CircleCI, now defunct). Current system Ruby is 3.4.4
- **Dependencies**: Zero runtime deps. Dev: bundler, rake, minitest
- **Architecture**: Single module `StreetAddress::US` with class methods (`parse`, `parse_address`, `parse_informal_address`, `parse_intersection`) and inner `Address` class
- **Parsing**: Regex-based with named capture groups. Falls back: strict → informal

## Known Broken Things
- **Tests fail on Ruby 3.x**: Both test files use `MiniTest::Test` (capital T) which was removed — must be `Minitest::Test`
- **Method redefinition warning**: `unit_regexp` is declared twice in the `attr_accessor` block (lines 534 and 542)
- **CI is dead**: `circle.yml` references Ruby 1.9.3–2.2.0 via rvm; CircleCI v1 is long gone
- **`to_s` bug in Address**: `line1` and `line2` both accept and append to a string `s`, but `to_s` passes `s` to them after already appending — causes double output (see issue #54)

## Open Issues (14) — Notable
- #55: Community asking for maintenance/new maintainers
- #54: `line2` doesn't work (bug in `to_s`)
- #52: Nil street when addr has no street type + apt with directional letter
- #48: "Ct" street type parsing issues
- #38: PO Box not supported
- #37/#30: Addresses ending in "United States"/"USA" fail
- #31: TypeError on `line1` access
- #11: Alpha chars in street number not handled
- #10: Street type misidentified when it appears in city name

## Open PRs (10) — Notable
- #51: Fix minitest deprecation warnings (the MiniTest → Minitest fix)
- #50: Handle CT, KY, LA (state abbreviation conflicts with street types)
- #49: `\s` required since regular space ignored in x-mode regex
- #45: Canadian address parsing
- #33: Handle streets where name overlaps street-type map

## Style & Conventions
- No frozen_string_literal pragmas
- Hash rockets throughout (`=>` not `:key =>` symbol shorthand)
- Tests use data-driven pattern: hash of input → expected output, iterated in test methods
- Regex patterns use `/x` (extended) mode extensively
