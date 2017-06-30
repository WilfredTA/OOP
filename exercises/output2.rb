class  Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

=begin
On line 13, local var 'name' is initialized to a FixNum object.
On line 14, FixNum 42 is passed into initialize(name). Here, param name points to FixNum obj
42. Then FixNum#to_s is called on param name which returns a new String object
with the value '42'. On line 15, local var name is incremented and now points to a new FixNum obj. 
On line 16, the return value of the getter method for @name is output, which is '42'. On line
17, Pet#to_s is called, which interpolates the value of @name in a string. 
On line 18, the return value of the getter method is once again output to the screen. On line 19,
the local variable is converted to a string via 'puts' and outputted to the screen. As you recall,
we incremented the local variable on line 15, so the output of line 19 should be '43'

=end