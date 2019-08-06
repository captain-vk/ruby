class Train
  attr_reader :number, :type, :current_station
  attr_accessor :speed, :route

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def ride (speed)
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
    @route = route.stations
    @current_station = @route[0]
  end

  def move_forward
    @current_station = @route[@route.index(@current_station) + 1] if @current_station != @route.last
  end

  def move_back
    @current_station = @route[@route.index(@current_station) - 1]  if @current_station != @route.first
  end

  def show_current_station
    puts "Станция: #{@current_station}"
  end

  def next_station
      puts "Следующая станция: #{@route[@route.index(@current_station) + 1]}" if @current_station != @route.last
    end

    def previous_station
      puts "Предыдущая станция: #{@route[@route.index(@current_station) - 1]}" if @current_station != @route.first
      end
  end
