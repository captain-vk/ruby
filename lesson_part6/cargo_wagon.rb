require_relative 'company'
class CargoWagon
  include Company
  attr_reader :type

  def initialize(type)
    @type = type
  end
end
