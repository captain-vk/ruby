module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
end

module ClassMethods
  def instances
    @@instances
  end
  def print_string
    puts "I am here"
  end
end

module InstanceMethods
  attr_accessor :instances
  @@instances ||= 0
  def register_instance
    @@instances += 1
    puts self.class.class_variable_get(:@@instances)
  end
end