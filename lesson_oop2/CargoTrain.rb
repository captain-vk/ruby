class CargoTrain < Train
  def initialize(number, type = :cargo)
    super
  end
  def add_wagon_cargo(CargoWagon)
    CargoWagon.type == type
  end
end
