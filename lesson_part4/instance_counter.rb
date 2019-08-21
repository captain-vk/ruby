module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end
  # class
  module ClassMethods
    def print_string
    @@instances
    puts "I am here"
    end
  end

  module InstanceMethods
    def print_class
    self.class.instances += 1
    puts self.class
    end
  end
end