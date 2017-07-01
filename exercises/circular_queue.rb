# The problem
# Circular queue. Number is number of slots
# Enqeue(arg) adds arg to qeueu
# dequeue removes and returns oldest object in queue, returns nil if queueu slot
#   is empty

# Model
# Must find a way to identify oldest and newest items
# Must keep the oldest at one end and the newest at the other
# Enqueue will find empty space and add value to it, otherwise will overwrite oldest
# Dequeue will find oldest and replace with empty value then return oldest

# Newest objects at the end of the array. Oldest at beginning. 
# Enqeueue pushes value onto end of array and deletes value at beginning
# dequeue deletes value at beginning if value is nil, otherwise deletes first value it finds
    # iterating from left to right



class CircularQueue
    attr_accessor :buffer

   def initialize(size)
       @buffer = Array.new(size)
   end
   
   def enqueue(value)
     buffer.push(value)
     buffer.delete_at(0)
   end
   
   def dequeue
      buffer.each_with_index do |slot, idx|
          if slot != nil
              buffer[idx] = nil
              return slot
          end
       end
       nil
   end
end

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil



