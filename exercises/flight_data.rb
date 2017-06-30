class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# There is no suggestion that database_handle needs to be accessed by users,
# so there are therefore two options: Delelete the attr_accessor or make it private. 
# Deleting it makes more sense since there are no other methods in the class which
# need access to @database_handle, and therefore making it private is superfluous