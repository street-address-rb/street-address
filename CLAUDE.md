# StreetAddress Ruby Gem

## Project Overview
US street address parser gem (`StreetAddress`). Parses address strings into normalized `StreetAddress::US::Address` objects. Port of Perl's `Geo::StreetAddress::US`. Single-file library at `lib/street_address.rb`.

## Quick Commands
```bash
bundle exec rake test                    # run tests
bundle exec irb -r ./lib/street_address  # interactive REPL
gem build street_address.gemspec         # build the gem
```

## Project Structure
```
lib/street_address.rb           # entire library (module, parser, Address class)
test/street_address_test.rb     # parsing tests (Minitest)
test/address_test.rb            # output formatting tests (Minitest)
street_address.gemspec          # gem spec (version hardcoded as "2.0.0")
.github/workflows/ci.yml       # GitHub Actions CI (Ruby 3.3 + 3.4)
```

## Key Technical Details
- **Version**: 2.0.0
- **Ruby**: >= 3.3 (also works on Ruby 4.0)
- **Dependencies**: Zero runtime deps. Dev: bundler, rake, minitest, irb, rdoc
- **Architecture**: Single module `StreetAddress::US` with class methods (`parse`, `parse_address`, `parse_informal_address`, `parse_intersection`) and inner `Address` class
- **Parsing**: Regex-based with named capture groups. Falls back: strict -> informal
- **frozen_string_literal**: true in all Ruby files
- **Constants**: All lookup hashes are frozen

## Tests
- 38 runs, 872 assertions
- Tests use data-driven pattern: hash of input -> expected output
- `EXPECTED_FAILURES`: addresses that should return nil or no state (PO Box, military, rural route, etc.)
- `KNOWN_MISPARSES`: addresses that parse but produce incorrect values (DuPage County grid numbers)

## Open Issues (14) — Notable
- #55: Community asking for maintenance/new maintainers
- #54: `line2` bug (fixed in v2)
- #52: Nil street with no street type + directional apt letter
- #48: "Ct" street type parsing issues
- #38: PO Box not supported
- #37/#30: Addresses ending in "United States"/"USA" (works now)
- #31: TypeError on `line1` access (fixed in v2)

## Open PRs (10) — Notable
- #51: Fix minitest deprecation warnings (done in v2)
- #50: Handle CT, KY, LA state/street-type conflicts
- #49: `\s` required in x-mode regex
- #45: Canadian address parsing
- #33: Handle streets where name overlaps street-type map
