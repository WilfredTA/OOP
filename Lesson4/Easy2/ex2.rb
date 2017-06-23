class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

=begin 
What is the result of calling the following code:
trip = RoadTrip.new
trip.predict_the_future 
=end 
# The result is one of the elements in the array returned by the choices instance method 
# in the RoadTrip class beign appended to the string "You will"
