# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    history_var = []
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name.to_sym) { instance_variable_get(var_name) }
      define_method("#{name}_history".to_sym) { instance_variable_get(history_var) }
      define_method("#{name}=".to_sym) { |value| instance_variable_set(var_name, value) }
      # history_var << value
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      puts name.class
      puts class_name
      raise '...' if name.class != class_name

      instance_variable_set(var_name, value)
    end
  end
end

class Test
  extend Accessors
  attr_accessor_with_history :my_attr, :a, :b, :c
  strong_attr_accessor :l, Integer
end
