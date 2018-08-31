module StreetAddress
  # @see https://www.canadapost.ca/tools/pg/manual/PGaddress-e.asp
  class CA < US
    DIRECTIONAL = {
      "north"      => "N",
      "northeast"  => "NE",
      "east"       => "E",
      "southeast"  => "SE",
      "south"      => "S",
      "southwest"  => "SW",
      "west"       => "W",
      "northwest"  => "NW",
      'est'        => 'E',
      'nord'       => 'N',
      'nord-est'   => 'NE',
      'nord-ouest' => 'NO',
      'sud'        => 'S',
      'sud-est'    => 'SE',
      'sud-ouest'  => 'SO',
      'ouest'      => 'O'
    }
    DIRECTION_CODES = DIRECTIONAL.invert

    STREET_TYPES = {
      'abbey'       => 'abbey',
      'acres'       => 'acres',
      'allée'       => 'allée',
      'alley'       => 'alley',
      'autoroute'   => 'aut',
      # 'avenue'      => 'av',
      'avenue'      => 'ave',
      'bay'         => 'bay',
      'beach'       => 'beach',
      'bend'        => 'bend',
      'boulevard'   => 'blvd',
      # 'boulevard'   => 'boul',
      'by-pass'     => 'bypass',
      'byway'       => 'byway',
      'campus'      => 'campus',
      'cape'        => 'cape',
      'carré'       => 'car',
      'carrefour'   => 'carref',
      # 'centre'      => 'c',
      'centre'      => 'ctr',
      'cercle'      => 'cercle',
      'chase'       => 'chase',
      'chemin'      => 'ch',
      'circle'      => 'cir',
      'circuit'     => 'circt',
      'close'       => 'close',
      'common'      => 'common',
      'concession'  => 'conc',
      'corners'     => 'crnrs',
      'côte'        => 'côte',
      'cour'        => 'cour',
      'cours'       => 'cours',
      'court'       => 'crt',
      'cove'        => 'cove',
      'crescent'    => 'cres',
      'croissant'   => 'crois',
      'crossing'    => 'cross',
      'cul-de-sac'  => 'cds',
      'dale'        => 'dale',
      'dell'        => 'dell',
      'diversion'   => 'divers',
      'downs'       => 'downs',
      'drive'       => 'dr',
      'échangeur'   => 'éch',
      'end'         => 'end',
      'esplanade'   => 'espl',
      'estates'     => 'estate',
      'expressway'  => 'expy',
      'extension'   => 'exten',
      'farm'        => 'farm',
      'field'       => 'field',
      'forest'      => 'forest',
      'freeway'     => 'fwy',
      'front'       => 'front',
      'gardens'     => 'gdns',
      'gate'        => 'gate',
      'glade'       => 'glade',
      'glen'        => 'glen',
      'green'       => 'green',
      'grounds'     => 'grnds',
      'grove'       => 'grove',
      'harbour'     => 'harbr',
      'heath'       => 'heath',
      'heights'     => 'hts',
      'highlands'   => 'hghlds',
      'highway'     => 'hwy',
      'hill'        => 'hill',
      'hollow'      => 'hollow',
      'île'         => 'île',
      'impasse'     => 'imp',
      'inlet'       => 'inlet',
      'island'      => 'island',
      'key'         => 'key',
      'knoll'       => 'knoll',
      'landing'     => 'landng',
      'lane'        => 'lane',
      'limits'      => 'lmts',
      'line'        => 'line',
      'link'        => 'link',
      'lookout'     => 'lkout',
      'loop'        => 'loop',
      'mall'        => 'mall',
      'manor'       => 'manor',
      'maze'        => 'maze',
      'meadow'      => 'meadow',
      'mews'        => 'mews',
      'montée'      => 'montée',
      'moor'        => 'moor',
      'mount'       => 'mount',
      'mountain'    => 'mtn',
      'orchard'     => 'orch',
      'parade'      => 'parade',
      'parc'        => 'parc',
      'park'        => 'pk',
      'parkway'     => 'pky',
      'passage'     => 'pass',
      'path'        => 'path',
      'pathway'     => 'ptway',
      'pines'       => 'pines',
      'place'       => 'pl',
      # 'place'       => 'place',
      'plateau'     => 'plat',
      'plaza'       => 'plaza',
      'point'       => 'pt',
      'pointe'      => 'pointe',
      'port'        => 'port',
      'private'     => 'pvt',
      'promenade'   => 'prom',
      'quai'        => 'quai',
      'quay'        => 'quay',
      'ramp'        => 'ramp',
      'rang'        => 'rang',
      'range'       => 'rg',
      'ridge'       => 'ridge',
      'rise'        => 'rise',
      'road'        => 'rd',
      'rond-point'  => 'rdpt',
      'route'       => 'rte',
      'row'         => 'row',
      'rue'         => 'rue',
      'ruelle'      => 'rle',
      'run'         => 'run',
      'sentier'     => 'sent',
      'square'      => 'sq',
      'street'      => 'st',
      'subdivision' => 'subdiv',
      'terrace'     => 'terr',
      'terrasse'    => 'tsse',
      'thicket'     => 'thick',
      'towers'      => 'towers',
      'townline'    => 'tline',
      'trail'       => 'trail',
      'turnabout'   => 'trnabt',
      'vale'        => 'vale',
      'via'         => 'via',
      'view'        => 'view',
      'village'     => 'villge',
      'villas'      => 'villas',
      'vista'       => 'vista',
      'voie'        => 'voie',
      'walk'        => 'walk',
      'way'         => 'way',
      'wharf'       => 'wharf',
      'wood'        => 'wood',
      'wynd'        => 'wynd',
    }

    STREET_TYPES_LIST = {}
    STREET_TYPES.to_a.each do |item|
      STREET_TYPES_LIST[item[0]] = true
      STREET_TYPES_LIST[item[1]] = true
    end

    STATE_CODES = {
      'alberta'                   => 'AB',
      'british columbia'          => 'BC',
      'colombie-britannique'      => 'BC',
      'manitoba'                  => 'MB',
      'new brunswick'             => 'NB',
      'nouveau-brunswick'         => 'NB',
      'newfoundland and labrador' => 'NL',
      'terre-neuve-et-labrador'   => 'NL',
      'northwest territories'     => 'NT',
      'territoires du nord-ouest' => 'NT',
      'nova scotia'               => 'NS',
      'nouvelle-écosse'           => 'NS',
      'nunavut'                   => 'NU',
      'ontario'                   => 'ON',
      'prince edward island'      => 'PE',
      'île-du-prince-édouard'     => 'PE',
      'québec'                    => 'QC',
      'saskatchewan'              => 'SK',
      'yukon'                     => 'YT',
    }

    STATE_NAMES = STATE_CODES.invert

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
    self.zip_regexp = /(?:(?<postal_code>\w{3}\s\w{3})?)/

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

    self.address_regexp = /
      \A
      [^\w\x23]*    # skip non-word chars except # (eg unit)
      #{number_regexp} \W*
      (?:#{fraction_regexp}\W*)?
      #{street_regexp}\W+
      (?:#{unit_regexp}\W+)?
      #{place_regexp}
      \W*         # require on non-word chars at end
      \z           # right up to end of string
    /ix;

    self.sep_regexp = /(?:\W+|\Z)/;
    self.sep_avoid_unit_regexp = /(?:[^\#\w]+|\Z)/;

    self.informal_address_regexp = /
      \A
      \s*         # skip leading whitespace
      (?:#{unit_regexp} #{sep_regexp})?
      (?:#{number_regexp})? \W*
      (?:#{fraction_regexp} \W*)?
      #{street_regexp} #{sep_avoid_unit_regexp}
      (?:#{unit_regexp} #{sep_regexp})?
      (?:#{place_regexp})?
      # don't require match to reach end of string
    /ix;

    self.intersection_regexp = /\A\W*
      #{street_regexp}\W*?

      \s+#{corner_regexp}\s+

#          (?{ exists $_{$_} and $_{$_.1} = delete $_{$_} for (qw{prefix street type suffix})})
      #{street_regexp}\W+
#          (?{ exists $_{$_} and $_{$_.2} = delete $_{$_} for (qw{prefix street type suffix})})

      #{place_regexp}
      \W*\z
    /ix;
    def initialize
      super
    end
  end
end
