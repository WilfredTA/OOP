class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end


#given the follow code what is the result of calling 
#oracle = Oracle.new
#p oracle.predict_the_future

# The result is the return of a string in which one of the strings returned by the choices instance method
# is appended to the string "You will" E.g. "You will eat a nice lunch"