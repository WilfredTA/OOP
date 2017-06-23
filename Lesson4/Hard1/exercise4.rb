#The designers of the vehicle management system now want to make an adjustment 

#for how the range of vehicles is calculated. For the seaborne vehicles, due to prevailing ocean currents, they want to add an additional 10km of range even if the vehicle is out of fuel.

#Alter the code related to vehicles so that the range for autos and motorcycles 
#is still calculated as before, but for catamarans and motorboats, the range
#method will return an additional 10km.

class Vehicle
    attr_accessor :speed, :heading
    def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
        @fuel_efficiency = km_traveled_per_liter
        @fuel_capacity = liters_of_fuel_capacity
    end

    def range
      @fuel_capacity * @fuel_efficiency
    end
end

class WheeledVehicle < Vehicle
  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    super(km_traveled_per_liter, liters_of_fuel_capacity) 
    @tires = tire_array
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end



module Boat
   attr_accessor :hull_count, :propeller_count
   def set_boat_specs(num_hulls = 1, num_propellers = 1) #this takes care of the default values for Motorboat
      self.hull_count =  num_hulls
      self.propeller_count = num_propellers
   end
   
   def range
       (@fuel_capacity * @fuel_efficiency) + 10
   end
end

class Catamaran < Vehicle
    include Boat
    def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
        super(km_traveled_per_liter, liters_of_fuel_capacity)
        set_boat_specs(num_hulls, num_propellers)
    end
end

class Motorboat < Vehicle 
    include Boat
    def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
        super(km_traveled_per_liter, liters_of_fuel_capacity)
        set_boat_specs
    end
end

motor = Motorboat.new(50, 25.0)
car = Auto.new
p motor.instance_variables
p car.instance_variables
