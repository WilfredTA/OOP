module Swim
  def enable_swimming
    @@class_swim = 0
    @can_swim = "#{@@class_swim} is the class variable for #{self.class}"
  end
end

class Dog
  include Swim
  
  def self.empty?
    "I have a variable" if @@class_swim
  end
  def swim
    "swimming!" if @can_swim
  end
end


teddy = Dog.new
p teddy.enable_swimming
