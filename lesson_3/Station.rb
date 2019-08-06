class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_trains(number)
    @trains << number
  end

  def list_of_trains
    @trains.each { |number| puts number }
  end

  def list_of_trains_by_type(type)
    @trains.select {|train| train.type == type}
  end

  def send_trains(number)
    @trains.delete(number)
  end
end
