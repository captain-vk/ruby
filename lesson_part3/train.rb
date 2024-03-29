class Train
  attr_reader :number, :type, :current_station, :speed, :route, :xxx

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def increase_speed(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @wagons += 1 if @speed == 0
  end

  def delete_wagon
    @wagons -= 1 if (@speed == 0) && (@wagons > 0)
  end

  def add_route(route)
    @route = route
    @current_station = @route.stations[0]
    @current_station.add_train(self)
  end

  def move_forward
    @current_station = @route.stations[@route.stations.index(@current_station) + 1] if @current_station != @route.stations.last
  end

  def move_back
    @current_station = @route.stations[@route.stations.index(@current_station) - 1] if @current_station != @route.stations.first
  end

    def show_current_station
    @route.stations.each do |station|
      @current_station = station if station.trains.include?(self)
    end
  end

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] if @current_station != @route.stations.last
    end

  def previous_station
    @current_station = @route.stations[@route.stations.index(@current_station) - 1] if @current_station != @route.stations.first
    end
  end
