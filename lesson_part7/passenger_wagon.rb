require_relative 'company'
class PassengerWagon
  include Company
  attr_reader :type, :number, :total_spaces, :free_spaces

  @@instances = 0
  @@passenger_wagons = []

  def initialize(total_spaces, type)
    @@instances += 1
    @number = @@instances
    @total_spaces = total_spaces
    @free_spaces = total_spaces
    @type = type 
    @@passenger_wagons << self
  end 

  def takes_space
    raise "Свободных мест нет" if @free_spaces == 0
    @free_spaces -= 1  	
  end

  def busy_spaces
    @total_spaces - @free_spaces
  end

  def free_spaces
    @free_spaces
  end 
end
