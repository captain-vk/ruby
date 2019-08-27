require_relative 'company'
class PassengerWagon
  include Company
  attr_reader :type

  def initialize(type)
    @type = type
  end  
end
