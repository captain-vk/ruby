class CargoTrain < Train
  def initialize(number, type = 'cargo')
    super
  end
  def add_wagon_cargo(wagon)
    wagon.type == type
  end
end
