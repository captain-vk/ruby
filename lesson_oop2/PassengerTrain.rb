class PassengerTrain < Train
  def initialize(number, type = 'passenger')
    super
  end
  def add_wagon_cargo(wagon)
    wagon.type == type
  end

end
