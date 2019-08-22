module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def print_string
      @@instances
      puts "I am here"
    end

  module InstanceMethods
    attr_accessor :instances
	@@instances ||= 0
    def print_class
      @@instances += 1
      puts self.class.class_variable_get(:@@instances)
    end
  end
end