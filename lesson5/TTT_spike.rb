class Board
    attr_accessor :grid
   def initialize 
      @grid = {:row1 => [nil, nil, nil], :row2 => [nil, nil, nil], :row3 => [nil, nil, nil]}
   end
   
   def display
       #somehow print out grid
   end
end

class Square 
   def initialize 
      #Occupied or not occupied?
      # Occupied by which player?
   end
end

class Player 
    # Maybe class variable that stores both symbols and updates to only available symbols when an object is initialized
   def initialize 
      # Symbol associated with Player object to keep track of which symbols are player's. Chooses a symbol from class var
      
      #type of player (human or computer)
   end
   
   def mark 
       
   end
    
end

class TTTGame
    def initialize
       board = Board.new
       human = Player.new
       computer = Player.new
    end

   def play
       loop do
        display_board
        human_move
        break if board.full? || win?
        computer_move
        break if board.full? || win?
       end
       display_board
       display_winner
       display_goodbye_message
   end
end

game = TTTGame.new
game.play