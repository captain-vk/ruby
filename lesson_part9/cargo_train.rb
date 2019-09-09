# frozen_string_literal: true

require_relative 'company'
require_relative 'instance_counter'
require_relative 'validation'

class CargoTrain < Train
  include Company
  include InstanceCounter
  include Validation

  NUMBER_FORMAT = /^[а-яА-Я0-9]{3}-?[а-яА-Я0-9]{2}$/.freeze
  validate :number, :format, NUMBER_FORMAT

  def initialize(number, type = :cargo)
    @number = number
    validate!
    super
  end

  def add_wagon(wagon)
    super if wagon.type == type
  end
end
