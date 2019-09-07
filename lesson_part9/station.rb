# frozen_string_literal: true

require_relative 'company'
require_relative 'instance_counter'
require_relative 'validation'


class Station
  include Company
  include InstanceCounter
  include Validation


  attr_reader :trains, :name
  @@stations = []
  validate :name, :presence


  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    # validate!
    register_instance
  end

  def stations
    @@stations
  end

  # def valid?
  #   validate!
  # rescue StandardError
  #   false
  # end

  def self.all
    @@stations
  end

  def add_train(number)
    @trains << number
  end

  def each_train
    @trains.each { |train| yield(train) }
  end

  def list_of_trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def send_trains(number)
    @trains.delete(number)
  end

  # protected

  # def validate!
  #   validate_number!
  # end

  # def validate_number!
  #   raise 'Название станции не корректно' if name.length < 5
  # end
end
