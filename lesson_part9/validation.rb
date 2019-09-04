
# frozen_string_literal: true

module Validation
  def validate_presence(attr)
    raise "..." if attr == nil || attr.empty?
  end

  def validate_format(attr, format)
    raise "..." if attr.to_s !~ format    
  end

  def validate_type(attr, format)
    raise "..." if attr.to_s !~ format    
  end  




class Test
  extend Accessors
  attr_accessor_with_history :my_attr, :a, :b, :c
  strong_attr_accessor :l, Integer
end
