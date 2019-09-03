# frozen_string_literal: true

require_relative 'company'
require_relative 'instance_counter'
class PassengerWagon
  include Company
  include InstanceCounter

  attr_reader :type, :number, :total_spaces, :free_spaces

  @@passenger_wagons = []

  def initialize(total_spaces, type)
    @number = register_instance
    @total_spaces = total_spaces
    @free_spaces = total_spaces
    @type = type
    @@passenger_wagons << self
  end

  def takes_space
    raise 'Свободных мест нет' if @free_spaces.zero?

    @free_spaces -= 1
  end

  def busy_spaces?
    @total_spaces - @free_spaces
  end

  def free_spaces?
    free_spaces
  end
end
