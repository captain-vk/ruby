class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(number)
    @trains << number
  end

  def list_of_trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def send_trains(number)
    @trains.delete(number)
  end
end
