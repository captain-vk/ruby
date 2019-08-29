require_relative 'company'
class CargoWagon
  include Company
  attr_reader :type, :number, :total_volume, :free_volume

  @@instances = 0
  @@cargo_wagons = []

  def initialize(total_volume, type)
  	@@instances += 1
    @number = @@instances
		@total_volume = total_volume
		@free_volume = total_volume
    @@cargo_wagons << self
    @type = type    
  end 

  def takes_volume(volume)
  	raise "Не хватит места" if @free_volume < volume
  	@free_volume -= volume
  end

  def busy_volume
  	@total_volume - @free_volume
  end

  def free_volume
  	@free_volume
  end 
end
