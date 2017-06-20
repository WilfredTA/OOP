#Make a bulldog subclass and override swim method to cant swim

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class BullDog < Dog
   def swim
       "Can't swim!"
   end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim  