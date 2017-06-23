#Building on the prior vehicles question, we now must also track a basic 
#motorboat. A motorboat has a single propeller and hull, but otherwise behaves 
#similar to a catamaran. Therefore, creators of Motorboat instances don't need 
#to specify number of hulls or propellers. How would you modify the vehicles 
#code to incorporate a new Motorboat class?


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



#This new class does not fit well with the object hierarchy defined so far. 
#Catamarans don't have tires. But we still want common code to track fuel
# efficiency and range. Modify the class definitions and move code into a 
# Module, as necessary, to share code among the Catamaran and the wheeled vehicles.


module Boat
   attr_accessor :hull_count, :propeller_count
   def set_boat_specs(num_hulls = 1, num_propellers = 1)
      self.hull_count =  num_hulls
      self.propeller_count = num_propellers
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

catar = Catamaran.new(2, 4, 50, 25.0)
p catar.hull_count ; p catar.propeller_count
p catar.range