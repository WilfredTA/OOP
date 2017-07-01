class Machine
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

 private
 
   attr_writer :switch
 
  def flip_switch(desired_state)
    self.switch = desired_state # even tho attr_writer is private, must specify receiver with setter methods
  end
end

# Modify this class so both flip_switch and the setter method switch= are private methods.

