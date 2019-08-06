class Route
  attr_accessor :stations

  def initialize(first, last)
    @stations = []
    @stations << first
    @stations << last
  end

  def add_station(station)
    @stations.insert(1, station)
  end

  def delete_station(station)
    @stations.delete(station) if @stations.last != station && @stations.first
  end

  def show_stations
    puts @stations
  end
end
