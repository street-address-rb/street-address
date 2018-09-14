require 'street_address/version'
require 'street_address/address'
require 'street_address/us'
require 'street_address/ca'

module StreetAddress
  def self.parse(location, args={})
    return US.parse(location, args) || CA.parse(location, args)
  end
end
