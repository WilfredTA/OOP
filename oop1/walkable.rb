module Walkable
    def walk
        puts "Let's go for a walk #{name}!" 
    end
end

class Cat 
   include Walkable
    attr_accessor :name
    def initialize(name)
        self.name = name
    end
    def greet 
        puts "Hello, my name is #{name}"
    end
end

kitty = Cat.new("Kit")
kitty.walk