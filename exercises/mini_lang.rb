# A stack machine has a register and a stack. 
# A stack machine takes a string of commands and executes them from left to right
# A number command adds the number to the register. 
# Pushing a value onto the stack pushes the value from the register onto the stack
# and leaves the value in the register
# You can also perform a variety of commands that pop the last addeed value from the stack
# and performs the specified operation on the popped value and register value and
# Stores the result in the register value
# You can also pop the topmost item from the stack and place it in the register
# You can also print the value in the register

module Operable
   def push
      stack << register 
   end
    
    def pop
       self.register = stack[-1] 
       stack.delete_at(-1)
    end
    
    def n
        self.register = n
    end
    
end

class StackMachine
    include Operable
    attr_accessor :stack, :register
   def initialize
      @stack = []
      @register = 0
   end
    
    
end




class MiniLang
    
    def initialize(commands)
       @commands = commands.split(' ') 
        
    end
    
    
end