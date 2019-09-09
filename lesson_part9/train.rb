# frozen_string_literal: true

require_relative 'company'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include Company
  include InstanceCounter
  include Validation

  attr_reader :number, :type, :current_station, :speed, :route, :wagons

  @@trains = {}

  NUMBER_FORMAT = /^[а-яА-Я0-9]{3}-?[а-яА-Я0-9]{2}$/.freeze
  validate :number, :format, NUMBER_FORMAT

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @wagons = []
    validate!
    @@trains[number] = self
    register_instance
  end

  def trains
    @@trains
  end

  # def valid?
  #   validate!
  #   true
  # rescue StandardError
  #   false
  # end

  def self.find(number)
    @@trains[number]
  end

  def increase_speed(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def each_wagon
    @wagons.each { |wagon| yield(wagon) }
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero?
  end

  def delete_wagon
    @wagons.pop if @speed.zero? && !@wagons.empty?
  end

  def count_wagons
    @wagons.size
  end

  def add_route(route)
    @route = route
    @current_station = @route.stations[0]
    @current_station.add_train(self)
  end

  def move_forward
    @current_station = next_station
  end

  def move_back
    @current_station = previous_station
  end

  def show_current_station
    @route.stations.each do |station|
      @current_station = station if station.trains.include?(self)
    end
  end

  # protected

  # def validate!
  #   validate_number!
  # end

  # def validate_number!
  #   raise 'Номер поезда не корректен' if number !~ NUMBER_FORMAT
  # end

  private

  def next_station
    @route.stations[@route.stations.index(@current_station) + 1] if @current_station != @route.stations.last
  end

  def previous_station
    @route.stations[@route.stations.index(@current_station) - 1] if @current_station != @route.stations.first
  end
end
