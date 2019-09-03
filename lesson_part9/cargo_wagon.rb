# frozen_string_literal: true

require_relative 'company'
require_relative 'instance_counter'
class CargoWagon
  include Company
  include InstanceCounter

  attr_reader :type, :number, :total_volume, :free_volume

  @@cargo_wagons = []

  def initialize(total_volume, type)
    @number = register_instance
    @total_volume = total_volume
    @free_volume = total_volume
    @@cargo_wagons << self
    @type = type
  end

  def takes_volume(volume)
    raise 'Не хватит места' if @free_volume < volume

    @free_volume -= volume
  end

  def busy_volume?
    @total_volume - @free_volume
  end

  def free_volume?
    @free_volume
  end
end
