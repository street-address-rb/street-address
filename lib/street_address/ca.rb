module StreetAddress
  # @see https://www.canadapost.ca/tools/pg/manual/PGaddress-e.asp
  class CA
    DIRECTIONAL = {
      "north"      => "N",
      "northeast"  => "NE",
      "east"       => "E",
      "southeast"  => "SE",
      "south"      => "S",
      "southwest"  => "SW",
      "west"       => "W",
      "northwest"  => "NW",
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
      'country' => Hash.new('Canada')
    }

    class << self
      attr_accessor(
        :street_type_regexp,
        :street_type_matches,
        :number_regexp,
        :fraction_regexp,
        :state_regexp,
        :city_and_state_regexp,
        :country_regexp,
        :direct_regexp,
        :postal_code_regexp,
        :corner_regexp,
        :unit_regexp,
        :street_regexp,
        :place_regexp,
        :address_regexp,
        :informal_address_regexp,
        :dircode_regexp,
        :unit_prefix_numbered_regexp,
        :unit_prefix_unnumbered_regexp,
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
    # FSA: Forward Sortation Area - LDU: Local Delivery Unit
    # https://en.wikipedia.org/wiki/Postal_codes_in_Canada#Components_of_a_postal_code
    self.postal_code_regexp = /
      (?:(?<FSA>\w\d\w)\s?(?<LDU>\d\w\d)?)?
    /ix

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
        |bureau
        |flo*r?
        |uni?té?
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

    self.country_regexp = /
      (?<country> Cana?d?a?)
    /ix;

    self.place_regexp = /
      (?:#{city_and_state_regexp}\W*)? (?:#{postal_code_regexp}\W*)?
      (?:#{country_regexp})?
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

    class << self
      def parse(location, args={})
        if corner_regexp.match(location)
          parse_intersection(location, args)
        elsif args[:informal]
          parse_address(location, args) || parse_informal_address(location, args)
        else
          parse_address(location, args)
        end
      end

      def parse_address(address, args={})
        return unless match = address_regexp.match(address)

        to_address( match_to_hash(match), args )
      end

      def parse_informal_address(address, args={})
        return unless match = informal_address_regexp.match(address)

        to_address( match_to_hash(match), args )
      end

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
          if( type.gsub!(/s\W*$/i, '') && /\A#{street_type_regexp}\z/i =~ type )
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

          input['redundant_street_type'] = false
          if( input['street'] && !input['street_type'] )
            match = street_regexp.match(input['street'])
            input['street_type'] = match['street_type']
          input['redundant_street_type'] = true
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

          # Return full postal code by default for Canadian addresses
          if input['FSA']
            fsa = input.delete('FSA'); ldu = input.delete('LDU')
            input['postal_code'] = [fsa, ldu].compact.join(' ')
          end

          %w(street street_type street2 street_type2 city unit_prefix).each do |k|
            input[k] = input[k].split.map do |s|
              # properly handle street names like '42A'
              s =~ /^\d+\w$/ ? s : s.capitalize
            end.join(' ') if input[k]
          end

          return StreetAddress::Address.new( input )
        end
    end
  end
end
