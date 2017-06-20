#Modify the class in exercise 1 to accomodate the code below. there is no name setter

#Now create a smart name= method that can take just a first name or a full name, and knows how to set the first_name and last_name appropriately.
# If we are comparing two objects, how do we check if they have the same name?

class Person
    attr_accessor :last_name, :first_name
    def initialize(full_name)
        get_name(full_name)
    end
    
    def names_are_same?(other)
        compare_name(other)
    end
    
    def name
        first_name + ' ' + last_name
    end
    
    def name=(full_name)
       get_name(full_name) 
    end
    
    
    def to_s
       name 
    end
    
    protected 
    
    def compare_name(other)
        self.name == other.name
    end
    
     def get_name(full_name)
        self.first_name = full_name.split.first
        full_name.split[1] ? @last_name = full_name.split.last : @last_name = ''
     end
end




bob = Person.new("Robert Smith")
joe = Person.new("Robert Smith")
bob.name="Not Bob"

p bob.name