class Station

  attr_reader :trains, :name
  @@stations = []

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
  end

  def self.all
    @@stations
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
