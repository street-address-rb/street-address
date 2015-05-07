=begin rdoc

=== Usage:
    StreetAddress::US.parse("1600 Pennsylvania Ave, washington, dc")

=== Valid Address Formats

    1600 Pennsylvania Ave Washington DC 20006
    1600 Pennsylvania Ave #400, Washington, DC, 20006
    1600 Pennsylvania Ave Washington, DC
    1600 Pennsylvania Ave #400 Washington DC
    1600 Pennsylvania Ave, 20006
    1600 Pennsylvania Ave #400, 20006
    1600 Pennsylvania Ave 20006
    1600 Pennsylvania Ave #400 20006

=== Valid Intersection Formats

    Hollywood & Vine, Los Angeles, CA
    Hollywood Blvd and Vine St, Los Angeles, CA
    Mission Street at Valencia Street, San Francisco, CA
    Hollywood & Vine, Los Angeles, CA, 90028
    Hollywood Blvd and Vine St, Los Angeles, CA, 90028
    Mission Street at Valencia Street, San Francisco, CA, 90028

==== License

    Copyright (c) 2007 Riderway (Derrek Long, Nicholas Schlueter)

    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
    LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
    OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
    WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

==== Notes
    If parts of the address are omitted from the original string
    the accessor will be nil in StreetAddress::US::Address.

    Example:
    address = StreetAddress::US.parse("1600 Pennsylvania Ave, washington, dc")
    assert address.postal_code.nil?

==== Acknowledgements

    This gem is a near direct port of the perl module Geo::StreetAddress::US
    originally written by Schuyler D. Erle.  For more information see
    http://search.cpan.org/~sderle/Geo-StreetAddress-US-0.99/

=end

module StreetAddress
  class US
    VERSION = '2.0.0'

    DIRECTIONAL = {
      "north" => "N",
      "northeast" => "NE",
      "east" => "E",
      "southeast" => "SE",
      "south" => "S",
      "southwest" => "SW",
      "west" => "W",
      "northwest" => "NW"
    }
    DIRECTION_CODES = DIRECTIONAL.invert

    STREET_TYPES = {
      'allee' => "aly",
      'alley' => "aly",
      'ally'  => "aly",
      'anex'  => "anx",
      'annex' => "anx",
      'annx'  => "anx",
      'arcade'=> "arc",
      'av'    => "ave",
      'aven'  => "ave",
      'avenu' => "ave",
      'avenue'=> "ave",
      'avn'   => "ave",
      'avnue' => "ave",
      'bayoo' => "byu",
      'bayou' => "byu",
      'beach' => "bch",
      'bend'  => "bnd",
      'bluf'  => "blf",
      'bluff' => "blf",
      'bluffs'=> "blfs",
      'bot'   => "btm",
      'bottm' => "btm",
      'bottom'=> "btm",
      'boul'  => "blvd",
      'boulevard'   => "blvd",
      'boulv' => "blvd",
      'branch'=> "br",
      'brdge' => "brg",
      'bridge'=> "brg",
      'brnch' => "br",
      'brook' => "brk",
      'brooks'=> "brks",
      'burg'  => "bg",
      'burgs' => "bgs",
      'bypa'  => "byp",
      'bypas' => "byp",
      'bypass'=> "byp",
      'byps'  => "byp",
      'camp'  => "cp",
      'canyn' => "cyn",
      'canyon'=> "cyn",
      'cape'  => "cpe",
      'causeway'    => "cswy",
      'causway'     => "cswy",
      'cen'   => "ctr",
      'cent'  => "ctr",
      'center'=> "ctr",
      'centers'     => "ctrs",
      'centr' => "ctr",
      'centre'=> "ctr",
      'circ'  => "cir",
      'circl' => "cir",
      'circle'=> "cir",
      'circles'     => "cirs",
      'ck'    => "crk",
      'cliff' => "clf",
      'cliffs'=> "clfs",
      'club'  => "clb",
      'cmp'   => "cp",
      'cnter' => "ctr",
      'cntr'  => "ctr",
      'cnyn'  => "cyn",
      'common'=> "cmn",
      'corner'=> "cor",
      'corners'     => "cors",
      'course'=> "crse",
      'court' => "ct",
      'courts'=> "cts",
      'cove'  => "cv",
      'coves' => "cvs",
      'cr'    => "crk",
      'crcl'  => "cir",
      'crcle' => "cir",
      'crecent'     => "cres",
      'creek' => "crk",
      'crescent'    => "cres",
      'cresent'     => "cres",
      'crest' => "crst",
      'crossing'    => "xing",
      'crossroad'   => "xrd",
      'crscnt'=> "cres",
      'crsent'=> "cres",
      'crsnt' => "cres",
      'crssing'     => "xing",
      'crssng'=> "xing",
      'crt'   => "ct",
      'curve' => "curv",
      'dale'  => "dl",
      'dam'   => "dm",
      'div'   => "dv",
      'divide'=> "dv",
      'driv'  => "dr",
      'drive' => "dr",
      'drives'=> "drs",
      'drv'   => "dr",
      'dvd'   => "dv",
      'estate'=> "est",
      'estates'     => "ests",
      'exp'   => "expy",
      'expr'  => "expy",
      'express'     => "expy",
      'expressway'  => "expy",
      'expw'  => "expy",
      'extension'   => "ext",
      'extensions'  => "exts",
      'extn'  => "ext",
      'extnsn'=> "ext",
      'falls' => "fls",
      'ferry' => "fry",
      'field' => "fld",
      'fields'=> "flds",
      'flat'  => "flt",
      'flats' => "flts",
      'ford'  => "frd",
      'fords' => "frds",
      'forest'=> "frst",
      'forests'     => "frst",
      'forg'  => "frg",
      'forge' => "frg",
      'forges'=> "frgs",
      'fork'  => "frk",
      'forks' => "frks",
      'fort'  => "ft",
      'freeway'     => "fwy",
      'freewy'=> "fwy",
      'frry'  => "fry",
      'frt'   => "ft",
      'frway' => "fwy",
      'frwy'  => "fwy",
      'garden'=> "gdn",
      'gardens'     => "gdns",
      'gardn' => "gdn",
      'gateway'     => "gtwy",
      'gatewy'=> "gtwy",
      'gatway'=> "gtwy",
      'glen'  => "gln",
      'glens' => "glns",
      'grden' => "gdn",
      'grdn'  => "gdn",
      'grdns' => "gdns",
      'green' => "grn",
      'greens'=> "grns",
      'grov'  => "grv",
      'grove' => "grv",
      'groves'=> "grvs",
      'gtway' => "gtwy",
      'harb'  => "hbr",
      'harbor'=> "hbr",
      'harbors'     => "hbrs",
      'harbr' => "hbr",
      'haven' => "hvn",
      'havn'  => "hvn",
      'height'=> "hts",
      'heights'     => "hts",
      'hgts'  => "hts",
      'highway'     => "hwy",
      'highwy'=> "hwy",
      'hill'  => "hl",
      'hills' => "hls",
      'hiway' => "hwy",
      'hiwy'  => "hwy",
      'hllw'  => "holw",
      'hollow'=> "holw",
      'hollows'     => "holw",
      'holws' => "holw",
      'hrbor' => "hbr",
      'ht'    => "hts",
      'hway'  => "hwy",
      'inlet' => "inlt",
      'island'=> "is",
      'islands'     => "iss",
      'isles' => "isle",
      'islnd' => "is",
      'islnds'=> "iss",
      'jction'=> "jct",
      'jctn'  => "jct",
      'jctns' => "jcts",
      'junction'    => "jct",
      'junctions'   => "jcts",
      'junctn'=> "jct",
      'juncton'     => "jct",
      'key'   => "ky",
      'keys'  => "kys",
      'knol'  => "knl",
      'knoll' => "knl",
      'knolls'=> "knls",
      'la'    => "ln",
      'lake'  => "lk",
      'lakes' => "lks",
      'landing'     => "lndg",
      'lane'  => "ln",
      'lanes' => "ln",
      'ldge'  => "ldg",
      'light' => "lgt",
      'lights'=> "lgts",
      'lndng' => "lndg",
      'loaf'  => "lf",
      'lock'  => "lck",
      'locks' => "lcks",
      'lodg'  => "ldg",
      'lodge' => "ldg",
      'loops' => "loop",
      'manor' => "mnr",
      'manors'=> "mnrs",
      'meadow'=> "mdw",
      'meadows'     => "mdws",
      'medows'=> "mdws",
      'mill'  => "ml",
      'mills' => "mls",
      'mission'     => "msn",
      'missn' => "msn",
      'mnt'   => "mt",
      'mntain'=> "mtn",
      'mntn'  => "mtn",
      'mntns' => "mtns",
      'motorway'    => "mtwy",
      'mount' => "mt",
      'mountain'    => "mtn",
      'mountains'   => "mtns",
      'mountin'     => "mtn",
      'mssn'  => "msn",
      'mtin'  => "mtn",
      'neck'  => "nck",
      'orchard'     => "orch",
      'orchrd'=> "orch",
      'overpass'    => "opas",
      'ovl'   => "oval",
      'parks' => "park",
      'parkway'     => "pkwy",
      'parkways'    => "pkwy",
      'parkwy'=> "pkwy",
      'passage'     => "psge",
      'paths' => "path",
      'pikes' => "pike",
      'pine'  => "pne",
      'pines' => "pnes",
      'pk'    => "park",
      'pkway' => "pkwy",
      'pkwys' => "pkwy",
      'pky'   => "pkwy",
      'place' => "pl",
      'plain' => "pln",
      'plaines'   => "plns",
      'plains'=> "plns",
      'plaza' => "plz",
      'plza'  => "plz",
      'point' => "pt",
      'points'=> "pts",
      'port'  => "prt",
      'ports' => "prts",
      'prairie'     => "pr",
      'prarie'=> "pr",
      'prk'   => "park",
      'prr'   => "pr",
      'rad'   => "radl",
      'radial'=> "radl",
      'radiel'=> "radl",
      'ranch' => "rnch",
      'ranches'     => "rnch",
      'rapid' => "rpd",
      'rapids'=> "rpds",
      'rdge'  => "rdg",
      'rest'  => "rst",
      'ridge' => "rdg",
      'ridges'=> "rdgs",
      'river' => "riv",
      'rivr'  => "riv",
      'rnchs' => "rnch",
      'road'  => "rd",
      'roads' => "rds",
      'route' => "rte",
      'rvr'   => "riv",
      'shoal' => "shl",
      'shoals'=> "shls",
      'shoar' => "shr",
      'shoars'=> "shrs",
      'shore' => "shr",
      'shores'=> "shrs",
      'skyway'=> "skwy",
      'spng'  => "spg",
      'spngs' => "spgs",
      'spring'=> "spg",
      'springs'     => "spgs",
      'sprng' => "spg",
      'sprngs'=> "spgs",
      'spurs' => "spur",
      'sqr'   => "sq",
      'sqre'  => "sq",
      'sqrs'  => "sqs",
      'squ'   => "sq",
      'square'=> "sq",
      'squares'     => "sqs",
      'station'     => "sta",
      'statn' => "sta",
      'stn'   => "sta",
      'str'   => "st",
      'strav' => "stra",
      'strave'=> "stra",
      'straven'     => "stra",
      'stravenue'   => "stra",
      'stravn'=> "stra",
      'stream'=> "strm",
      'street'=> "st",
      'streets'     => "sts",
      'streme'=> "strm",
      'strt'  => "st",
      'strvn' => "stra",
      'strvnue'     => "stra",
      'sumit' => "smt",
      'sumitt'=> "smt",
      'summit'=> "smt",
      'terr'  => "ter",
      'terrace'     => "ter",
      'throughway'  => "trwy",
      'tpk'   => "tpke",
      'tr'    => "trl",
      'trace' => "trce",
      'traces'=> "trce",
      'track' => "trak",
      'tracks'=> "trak",
      'trafficway'  => "trfy",
      'trail' => "trl",
      'trails'=> "trl",
      'trk'   => "trak",
      'trks'  => "trak",
      'trls'  => "trl",
      'trnpk' => "tpke",
      'trpk'  => "tpke",
      'tunel' => "tunl",
      'tunls' => "tunl",
      'tunnel'=> "tunl",
      'tunnels'     => "tunl",
      'tunnl' => "tunl",
      'turnpike'    => "tpke",
      'turnpk'=> "tpke",
      'underpass'   => "upas",
      'union' => "un",
      'unions'=> "uns",
      'valley'=> "vly",
      'valleys'     => "vlys",
      'vally' => "vly",
      'vdct'  => "via",
      'viadct'=> "via",
      'viaduct'     => "via",
      'view'  => "vw",
      'views' => "vws",
      'vill'  => "vlg",
      'villag'=> "vlg",
      'village'     => "vlg",
      'villages'    => "vlgs",
      'ville' => "vl",
      'villg' => "vlg",
      'villiage'    => "vlg",
      'vist'  => "vis",
      'vista' => "vis",
      'vlly'  => "vly",
      'vst'   => "vis",
      'vsta'  => "vis",
      'walks' => "walk",
      'well'  => "wl",
      'wells' => "wls",
      'wy'    => "way",
    }

    STREET_TYPES_LIST = {}
    STREET_TYPES.to_a.each do |item|
      STREET_TYPES_LIST[item[0]] = true
      STREET_TYPES_LIST[item[1]] = true
    end

    STATE_CODES = {
      "alabama" => "AL",
      "alaska" => "AK",
      "american samoa" => "AS",
      "arizona" => "AZ",
      "arkansas" => "AR",
      "california" => "CA",
      "colorado" => "CO",
      "connecticut" => "CT",
      "delaware" => "DE",
      "district of columbia" => "DC",
      "federated states of micronesia" => "FM",
      "florida" => "FL",
      "georgia" => "GA",
      "guam" => "GU",
      "hawaii" => "HI",
      "idaho" => "ID",
      "illinois" => "IL",
      "indiana" => "IN",
      "iowa" => "IA",
      "kansas" => "KS",
      "kentucky" => "KY",
      "louisiana" => "LA",
      "maine" => "ME",
      "marshall islands" => "MH",
      "maryland" => "MD",
      "massachusetts" => "MA",
      "michigan" => "MI",
      "minnesota" => "MN",
      "mississippi" => "MS",
      "missouri" => "MO",
      "montana" => "MT",
      "nebraska" => "NE",
      "nevada" => "NV",
      "new hampshire" => "NH",
      "new jersey" => "NJ",
      "new mexico" => "NM",
      "new york" => "NY",
      "north carolina" => "NC",
      "north dakota" => "ND",
      "northern mariana islands" => "MP",
      "ohio" => "OH",
      "oklahoma" => "OK",
      "oregon" => "OR",
      "palau" => "PW",
      "pennsylvania" => "PA",
      "puerto rico" => "PR",
      "rhode island" => "RI",
      "south carolina" => "SC",
      "south dakota" => "SD",
      "tennessee" => "TN",
      "texas" => "TX",
      "utah" => "UT",
      "vermont" => "VT",
      "virgin islands" => "VI",
      "virginia" => "VA",
      "washington" => "WA",
      "west virginia" => "WV",
      "wisconsin" => "WI",
      "wyoming" => "WY"
    }

    STATE_NAMES = STATE_CODES.invert

    STATE_FIPS = {
      "01" => "AL",
      "02" => "AK",
      "04" => "AZ",
      "05" => "AR",
      "06" => "CA",
      "08" => "CO",
      "09" => "CT",
      "10" => "DE",
      "11" => "DC",
      "12" => "FL",
      "13" => "GA",
      "15" => "HI",
      "16" => "ID",
      "17" => "IL",
      "18" => "IN",
      "19" => "IA",
      "20" => "KS",
      "21" => "KY",
      "22" => "LA",
      "23" => "ME",
      "24" => "MD",
      "25" => "MA",
      "26" => "MI",
      "27" => "MN",
      "28" => "MS",
      "29" => "MO",
      "30" => "MT",
      "31" => "NE",
      "32" => "NV",
      "33" => "NH",
      "34" => "NJ",
      "35" => "NM",
      "36" => "NY",
      "37" => "NC",
      "38" => "ND",
      "39" => "OH",
      "40" => "OK",
      "41" => "OR",
      "42" => "PA",
      "44" => "RI",
      "45" => "SC",
      "46" => "SD",
      "47" => "TN",
      "48" => "TX",
      "49" => "UT",
      "50" => "VT",
      "51" => "VA",
      "53" => "WA",
      "54" => "WV",
      "55" => "WI",
      "56" => "WY",
      "72" => "PR",
      "78" => "VI"
    }

    FIPS_STATES = STATE_FIPS.invert

    NORMALIZE_MAP = {
      'prefix'  => DIRECTIONAL,
      'prefix1' => DIRECTIONAL,
      'prefix2' => DIRECTIONAL,
      'suffix'  => DIRECTIONAL,
      'suffix1' => DIRECTIONAL,
      'suffix2' => DIRECTIONAL,
      'street_type'  => STREET_TYPES,
      'street_type1' => STREET_TYPES,
      'street_type2' => STREET_TYPES,
      'state'   => STATE_CODES,
    }

    class << self
      attr_accessor(
        :street_type_regexp,
        :street_type_matches,
        :number_regexp,
        :fraction_regexp,
        :state_regexp,
        :city_and_state_regexp,
        :direct_regexp,
        :zip_regexp,
        :corner_regexp,
        :unit_regexp,
        :street_regexp,
        :place_regexp,
        :address_regexp,
        :informal_address_regexp,
        :dircode_regexp,
        :unit_prefix_numbered_regexp,
        :unit_prefix_unnumbered_regexp,
        :unit_regexp,
        :sep_regexp,
        :sep_avoid_unit_regexp,
        :intersection_regexp
      )
    end

    self.street_type_matches = {}
    STREET_TYPES.each_pair { |type,abbrv|
      self.street_type_matches[abbrv] = /\b (?: #{abbrv}|#{Regexp.quote(type)} ) \b/ix
    }

    self.street_type_regexp = Regexp.new(STREET_TYPES_LIST.keys.join("|"), Regexp::IGNORECASE)
    self.fraction_regexp = /\d+\/\d+/
    self.state_regexp = Regexp.new(
      '\b' + STATE_CODES.flatten.map{ |code| Regexp.quote(code) }.join("|") + '\b',
      Regexp::IGNORECASE
    )
    self.direct_regexp = Regexp.new(
      (DIRECTIONAL.keys +
       DIRECTIONAL.values.sort { |a,b|
         b.length <=> a.length
       }.map { |c|
         f = c.gsub(/(\w)/, '\1.')
         [Regexp::quote(f), Regexp::quote(c)]
       }
      ).join("|"),
      Regexp::IGNORECASE
    )
    self.dircode_regexp = Regexp.new(DIRECTION_CODES.keys.join("|"), Regexp::IGNORECASE)
    self.zip_regexp     = /(?:(?<postal_code>\d{5})(?:-?(?<postal_code_ext>\d{4}))?)/
    self.corner_regexp  = /(?:\band\b|\bat\b|&|\@)/i

    # we don't include letters in the number regex because we want to
    # treat "42S" as "42 S" (42 South). For example,
    # Utah and Wisconsin have a more elaborate system of block numbering
    # http://en.wikipedia.org/wiki/House_number#Block_numbers
    self.number_regexp = /(?<number>\d+-?\d*)(?=\D)/ix

    # note that expressions like [^,]+ may scan more than you expect
    self.street_regexp = /
      (?:
        # special case for addresses like 100 South Street
        (?:(?<street> #{direct_regexp})\W+
           (?<street_type> #{street_type_regexp})\b
        )
        |
        (?:(?<prefix> #{direct_regexp})\W+)?
        (?:
          (?<street> [^,]*\d)
          (?:[^\w,]* (?<suffix> #{direct_regexp})\b)
          |
          (?<street> [^,]+)
          (?:[^\w,]+(?<street_type> #{street_type_regexp})\b)
          (?:[^\w,]+(?<suffix> #{direct_regexp})\b)?
          |
          (?<street> [^,]+?)
          (?:[^\w,]+(?<street_type> #{street_type_regexp})\b)?
          (?:[^\w,]+(?<suffix> #{direct_regexp})\b)?
        )
      )
    /ix;

    # http://pe.usps.com/text/pub28/pub28c2_003.htm
    # TODO add support for those that don't require a number
    # TODO map to standard names/abbreviations
    self.unit_prefix_numbered_regexp = /
      (?<unit_prefix>
        su?i?te
        |p\W*[om]\W*b(?:ox)?
        |(?:ap|dep)(?:ar)?t(?:me?nt)?
        |ro*m
        |flo*r?
        |uni?t
        |bu?i?ldi?n?g
        |ha?nga?r
        |lo?t
        |pier
        |slip
        |spa?ce?
        |stop
        |tra?i?le?r
        |box)(?![a-z])
    /ix;

    self.unit_prefix_unnumbered_regexp = /
      (?<unit_prefix>
        ba?se?me?n?t
        |fro?nt
        |lo?bby
        |lowe?r
        |off?i?ce?
        |pe?n?t?ho?u?s?e?
        |rear
        |side
        |uppe?r
        )\b
    /ix;

    self.unit_regexp = /
      (?:
          (?: (?:#{unit_prefix_numbered_regexp} \W*)
              | (?<unit_prefix> \#)\W*
          )
          (?<unit> [\w-]+)
      )
      |
      #{unit_prefix_unnumbered_regexp}
    /ix;

    self.city_and_state_regexp = /
      (?:
          (?<city> [^\d,]+?)\W+
          (?<state> #{state_regexp})
      )
    /ix;

    self.place_regexp = /
      (?:#{city_and_state_regexp}\W*)? (?:#{zip_regexp})?
    /ix;

    # the \x23 below is an alias for '#' to avoid a bug in perl 5.18.1
    # https://rt.cpan.org/Ticket/Display.html?id=91420
    self.address_regexp = /
      ^
      [^\w\x23]*    # skip non-word chars except # (eg unit)
      #{number_regexp} \W*
      (?:#{fraction_regexp}\W*)?
      #{street_regexp}\W+
      (?:#{unit_regexp}\W+)?
      #{place_regexp}
      \W*         # require on non-word chars at end
      $           # right up to end of string
    /ix;

    self.sep_regexp = /(?:\W+|\Z)/;
    self.sep_avoid_unit_regexp = /(?:[^\#\w]+|\Z)/;

    self.informal_address_regexp = /
      ^
      \s*         # skip leading whitespace
      (?:#{unit_regexp} #{sep_regexp})?
      (?:#{number_regexp})? \W*
      (?:#{fraction_regexp} \W*)?
      #{street_regexp} #{sep_avoid_unit_regexp}
      (?:#{unit_regexp} #{sep_regexp})?
      (?:#{place_regexp})?
      # don't require match to reach end of string
    /ix;

    self.intersection_regexp = /^\W*
      #{street_regexp}\W*?

      \s+#{corner_regexp}\s+

#          (?{ exists $_{$_} and $_{$_.1} = delete $_{$_} for (qw{prefix street type suffix})})
      #{street_regexp}\W+
#          (?{ exists $_{$_} and $_{$_.2} = delete $_{$_} for (qw{prefix street type suffix})})

      #{place_regexp}
      \W*$
    /ix;

=begin rdoc

    parses either an address or intersection and returns an instance of
    StreetAddress::US::Address or nil if the location cannot be parsed

    pass the arguement, :informal => true, to make parsing more lenient

====example
    StreetAddress::US.parse('1600 Pennsylvania Ave Washington, DC 20006')
    or:
    StreetAddress::US.parse('Hollywood & Vine, Los Angeles, CA')
    or
    StreetAddress::US.parse("1600 Pennsylvania Ave", :informal => true)

=end
    class << self
      def parse(location, args={})
        if( corner_regexp.match(location) )
          return parse_intersection(location, args)
        else
          return parse_address(location, args) || parse_informal_address(location, args)
        end
      end

=begin rdoc

    parses only an address and returns an instance of
    StreetAddress::US::Address or nil if the address cannot be parsed

====example
    address = StreetAddress::US.parse('1600 Pennsylvania Ave Washington, DC 20006')
    assert !address.intersection?

=end
      def parse_address(address, args={})
        return unless match = address_regexp.match(address)

        to_address( match_to_hash(match), args )
      end

      def parse_informal_address(address, args={})
        return unless match = informal_address_regexp.match(address)

        to_address( match_to_hash(match), args )
      end

=begin rdoc

    parses only an intersection and returns an instance of
    StreetAddress::US::Address or nil if the intersection cannot be parsed

====example
    address = StreetAddress::US.parse('Hollywood & Vine, Los Angeles, CA')
    assert address.intersection?

=end
      def parse_intersection(intersection, args)
        return unless match = intersection_regexp.match(intersection)

        hash = match_to_hash(match)

        streets = intersection_regexp.named_captures["street"].map { |pos|
          match[pos.to_i]
        }.select { |v| v }
        hash["street"]  = streets[0] if streets[0]
        hash["street2"] = streets[1] if streets[1]

        street_types = intersection_regexp.named_captures["street_type"].map { |pos|
          match[pos.to_i]
        }.select { |v| v }
        hash["street_type"]  = street_types[0] if street_types[0]
        hash["street_type2"] = street_types[1] if street_types[1]

        if(
          hash["street_type"] &&
          (
            !hash["street_type2"] ||
            (hash["street_type"] == hash["street_type2"])
          )
        )
          type = hash["street_type"].clone
          if( type.gsub!(/s\W*$/i, '') && /^#{street_type_regexp}$/i =~ type )
            hash["street_type"] = hash["street_type2"] = type
          end
        end

        to_address( hash, args )
      end

      private
        def match_to_hash(match)
          hash = {}
          match.names.each { |name| hash[name] = match[name] if match[name] }
          return hash
        end

        def to_address(input, args)
          # strip off some punctuation and whitespace
          input.values.each { |string|
            string.strip!
            string.gsub!(/[^\w\s\-\#\&]/, '')
          }

          if( input['street'] && !input['street_type'] )
            match = street_regexp.match(input['street'])
            input['street_type'] = match['street_type']
          end

          NORMALIZE_MAP.each_pair { |key, map|
            next unless input[key]
            mapping = map[input[key].downcase]
            input[key] = mapping if mapping
          }

          if( args[:avoid_redundant_street_type] )
            ['', '1', '2'].each { |suffix|
              street = input['street'      + suffix];
              type   = input['street_type' + suffix];
              next if !street || !type

              type_regexp = street_type_matches[type.downcase] # || fail "No STREET_TYPE_MATCH for #{type}"
              input.delete('street_type' + suffix) if type_regexp.match(street)
            }
          end

          # attempt to expand directional prefixes on place names
          if( input['city'] )
            input['city'].gsub!(/^(#{dircode_regexp})\s+(?=\S)/) { |match|
              DIRECTION_CODES[match[0].upcase] + ' '
            }
          end

          # strip ZIP+4 (which may be missing a hyphen)
          if( input['zip'] )
            input['zip'].gsub!(/^(.{5}).*/, '\1')
          end

          %w(street street_type street2 street_type2 city unit_prefix).each do |k|
            input[k] = input[k].split.map(&:capitalize).join(' ') if input[k]
          end

          return StreetAddress::US::Address.new( input )
        end
    end

=begin rdoc

    This is class returned by StreetAddress::US::parse, StreetAddress::US::parse_address
    and StreetAddress::US::parse_intersection.  If an instance represents an intersection
    the attribute street2 will be populated.

=end
    class Address
      attr_accessor(
        :number,
        :street,
        :street_type,
        :unit,
        :unit_prefix,
        :suffix,
        :prefix,
        :city,
        :state,
        :postal_code,
        :postal_code_ext,
        :street2,
        :street_type2,
        :suffix2,
        :prefix2,
        :redundant_street_type
      )

      def initialize(args)
        args.keys.each do |attrib|
          self.send("#{attrib}=", args[attrib])
        end
        return
      end

      def state_fips
        StreetAddress::US::FIPS_STATES[state]
      end

      def state_name
        name = StreetAddress::US::STATE_NAMES[state] and name.capitalize
      end

      def intersection?
        !street2.nil?
      end

      def line1(s = "")
        parts = []
        if intersection?
          parts << prefix       if prefix
          parts << street
          parts << street_type  if street_type
          parts << suffix       if suffix
          parts << 'and'
          parts << prefix2      if prefix2
          parts << street2
          parts << street_type2 if street_type2
          parts << suffix2      if suffix2
        else
          parts << number
          parts << prefix if prefix
          parts << street if street
          parts << street_type if street_type && !redundant_street_type
          parts << suffix if suffix
          parts << unit_prefix if unit_prefix
          if unit
            #follow guidelines: http://pe.usps.gov/cpim/ftp/pubs/Pub28/pub28.pdf pg28
            parts << (unit_prefix ? unit : "\# #{unit}")
          end
        end
        s + parts.join(' ')
      end


      def line2(s = "")
        parts = []
        if city
          parts << city
        end
        if state
          parts << state
        end
        s = s + parts.join(', ')
        if postal_code
          s << " #{postal_code}"
          s << "-#{postal_code_ext}" if postal_code_ext
        end
        s.strip
      end


      def to_s(format = :default)
        s = ""
        case format
        when :line1
          s << line1(s)
        when :line2
          s << line2(s)
        else
          s << line1(s)
          line2 = line2().strip
          unless line2.empty?
            s << ', '
            s << line2
          end
        end
        s
      end

      def to_h
        self.instance_variables.each_with_object({}) do |var_name, hash|
          var_value = self.instance_variable_get(var_name)
          hash_name = var_name[1..-1].to_sym
          hash[hash_name] = var_value
        end
      end
    end
  end
end
