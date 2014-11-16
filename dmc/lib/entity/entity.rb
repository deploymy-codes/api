require 'virtus'
require_relative './persistence'

module Entity
  include Virtus.model
  include Persistence
end
