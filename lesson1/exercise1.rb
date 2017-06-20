
# Given the below usage of the Person class, code the person class
# Has an initialize that stores a @name variable and a getter and setter method

class Person
  attr_writer :name
  def initialize(name)
    self.name = name
  end
  
  def name 
    @name
  end
end


bob = Person.new('bob')
p bob.name                  # => 'bob'
bob.name = 'Robert'
p bob.name                  # => 'Robert'