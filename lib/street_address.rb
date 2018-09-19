require 'street_address/version'
require 'street_address/address'
require 'street_address/us'
require 'street_address/ca'

module StreetAddress
  Parsers = [US, CA]

  def self.parse(location, args={})
    return Parsers.map { |klass| klass.parse(location, args) }.compact.max
  end
end
