require_relative 'company'
require_relative 'instance_counter'

class Route
  include Company
  include InstanceCounter

  attr_reader :stations

  def initialize(first, last)
    @stations = [first, last]
    register_instance
  end

  def add_station(station)
    @stations.insert(1, station)
  end

  def delete_station(station)
    @stations.delete(station) if @stations.last != station && @stations.first
  end

end
