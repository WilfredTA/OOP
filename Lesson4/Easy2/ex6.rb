class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# self.manufacturer is a clas method because the self is prepended to manufacturer, indicating
# that manufacturer be called on self. Self here refers to the class. To call this, 
# one would type Television.manufacturer