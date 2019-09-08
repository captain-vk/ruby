# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(type, var, arg = nil)
      @validations ||= []
      @validations.push(type: type, var: var, arg: arg)
    end

    def validations
      @validations
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        send("validate_#{validation[:type]}".to_sym, instance_variable_get("@#{validation[:var]}"), validation[:arg])
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def validate_presence(attr, _)
      raise 'Строка пустая или nil' if attr.nil? || attr.empty?
    end

    def validate_format(attr, format)
      raise 'Не соответствует формату' if attr.to_s !~ format
    end

    def validate_type(attr, type)
      raise 'Не соответствует заданному классу' if attr.to_s !~ type
    end
  end
end

# class Test
#   extend Accessors
#   attr_accessor_with_history :my_attr, :a, :b, :c
#   strong_attr_accessor :l, Integer
# end
