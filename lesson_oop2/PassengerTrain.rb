class PassengerTrain < Train
  def initialize(number, type = 'passenger')
    super
  end
  def add_wagon_cargo(type)
    PassengerWagon.type == type
  end

end
