module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  # class
  module ClassMethods
    attr_accessor :instances

    def print_string
    @@instances
    puts "I am here"
    end
  
   def instances
    @instances = 0
    end
  end

  module InstanceMethods
    def print_class
    self.class.instances += 1
    puts "Werty"
    end
  end
end