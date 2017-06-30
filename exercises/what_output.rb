class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

# What is the output?
=begin 
First, a local variable name is initialized. When fluffy is initialized and passed
the name 'Fluffy', .to_s is immediately called on Fluffy, causing @name to be capitalized.
However, .to_s is defined to mutate the object to which @name is referencing. So, when local 
variable 'name' is passed into #initialize, param 'name' is told to point to 
the same object as local variable name. Then, .to_s is called on param name. But, .to_s 
here is String#.to_s, not Pet#to_s, so it doesn't capitalize param name. So, @name is assigned to param
name 'Fluffy'. This means that 'puts fluffy.name' will output 'Fluffy' because it is
calling 'puts' (i.e. to_s) on a String object, not a Pet object. When 'puts fluffy' is called,
.to_s is called on the Pet object, which mutates the object to which @name is pointing, causing it to
capitalize the string. That is why 'fluffy.name' now returns 'FLUFFY'. Finally, since local var
'name' and @name point to the same object, we see that local vare 'name' was also mutated when @name was mutated. 
The reason calling 'name.to_s' on param name didn't return a copy of param name is that param name was first told
to point to the same object as local var 'name'. Then, we call .to_s on param name. param name
points to a String object, so we are therefore calling String#to_s on param name. String#to_s returns
self, and therefore returns the calling object.

=end