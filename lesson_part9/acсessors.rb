# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      instance_variable_set("#{var_name}_history".to_sym, [])
      define_method("#{name}=") do |value|
        old_value = instance_variable_get("@#{name}")
        if instance_variable_get("@#{name}_history")
          send("#{name}_history").push(old_value)
        elsif old_value
          instance_variable_set("@#{name}_history", [])
          send("#{name}_history").push(old_value)
        else
          instance_variable_set("@#{name}_history", [])
        end
        instance_variable_set("@#{name}", value)
      end
      define_method(name.to_sym) { instance_variable_get(var_name) }
      define_method("#{name}_history".to_sym) { instance_variable_get("@#{name}_history") }
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise '...' if value.class != class_name

      instance_variable_set(var_name, value)
    end
  end
end

class Test
  extend Accessors
  attr_accessor_with_history :my_attr, :a, :b, :c
  strong_attr_accessor :l, Integer
end
