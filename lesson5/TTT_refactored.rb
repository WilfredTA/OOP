require 'pry'

class Board
  attr_reader :squares
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + #rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + #columns
                  [[1, 5, 9], [3, 5, 7]] #diagonals
   def initialize 
    @squares = {}
    reset
   end
   
  def set_square_at(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select {|key| @squares[key].unmarked?}
  end

  def full?
    unmarked_keys.empty?
  end

  def win?
    !!winning_marker?
  end

  def same_marker(squares)
    compare_to = squares.first.marker
    squares.each do |square|
      return false if square.marker != compare_to[0]
    end
    true
  end

  def squares_marked?(squares)
    squares.each do |square|
      return false if square.unmarked?
    end
    true
  end

  # returns winning marker if markers at squares(*lines)are same, nil otherwise
  def winning_marker?
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line) # array of squares
      if same_marker(squares) && squares_marked?(squares)# checks if all markers are the same
        return squares[0].marker # returns marker
      end
    end
    nil
  end

  def reset
    (1..9).each {|key| @squares[key] = Square.new}
  end

  def draw
      puts "     |     |"
      puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}  "
      puts "     |     |"
      puts "-----+-----+-----"
      puts "     |     |"
      puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}  "
      puts "     |     |"
      puts "-----+-----+-----"
      puts "     |     |"
      puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}  "
      puts "     |     |"
      puts ""
  end
end

class Square
  INITIAL_MARKER = " "
  attr_accessor :marker
   def initialize(marker=INITIAL_MARKER)
      @marker = marker
   end

   def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player 
  attr_reader :marker

   def initialize(marker)
      @marker = marker
   end
end

class TTTGame
    HUMAN_MARKER = "X"
    COMPUTER_MARKER = "O"
    attr_reader :board, :human, :computer
    def initialize
      @board = Board.new # represents state of board at any time; collaborator obj
      @human = Player.new(HUMAN_MARKER)
      @computer = Player.new(COMPUTER_MARKER)
    end

   def play
    display_welcome_message
    clear
    loop do

      display_board

      loop do
       current_player_moves
       break if board.win? || board.full?
       clear_screen_and_display_board if human_turn?
      end

      display_results
      break unless play_again?
      reset
      display_play_again_message
    end

    display_goodbye_message
  end

  private 
  def display_welcome_message
      puts "Welcome to Tic Tac Toe!"
      puts ""
    end

    def display_goodbye_message
      puts "Thank you for playing Tic Tac Toe! Goodbye!"
    end

    def human_moves
      puts "Choose one of the following available squares: #{board.unmarked_keys.join(', ')} "
      square = nil
      loop do 
        square = gets.chomp.to_i
        break if board.unmarked_keys.include?(square)
        puts "Sorry, not a valid choice."
      end
      board.set_square_at(square, human.marker)

    end

    def computer_moves
      board.set_square_at(board.unmarked_keys.sample, computer.marker)
    end

    def clear_screen_and_display_board
      clear
      display_board
    end

    def display_board
      puts "You are a #{human.marker}, computer is a #{computer.marker}"
      puts ""
      board.draw
      puts ""
    end

    def display_results
      display_board
      case board.winning_marker?
      when human.marker
        puts "You won!"
      when computer.marker
        puts "The computer won!"
      else
        puts "It's a tie!"
      end
    end

    def play_again?
      answer = nil
      loop do 
        puts "Would you like to play again? Yes or no?"
        answer = gets.chomp.downcase
        break if ["yes", "no"].include?(answer)
        puts "Error, invalid answer"
      end
      answer == "yes"
    end

    def clear
      system 'clear'
      system 'cls'
    end

    def reset
      board.reset
      clear
    end

    def display_play_again_message
      puts "Let's play again!"
      puts ""
    end

    def current_player? # checks current player and returns "human" or "computer"
      markers = board.squares.values.map do |square| # gets an array of markers on board
        square.marker
      end
      return "human" unless markers.count(HUMAN_MARKER) > 
        markers.count(COMPUTER_MARKER) # compares quantity of human markers to computer markers
      return "computer"
    end

    def human_turn?
      current_player? == "human"
    end

    def current_player_moves
      if human_turn? 
        human_moves
      else
        computer_moves
      end
    end
end

game = TTTGame.new
game.play