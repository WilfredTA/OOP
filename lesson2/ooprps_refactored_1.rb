class Move
  attr_reader :value
  VALUES = ['rock', 'paper', 'scissors']
  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end
end

class Player
  attr_accessor :move, :name
  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    name = nil
    loop do
      puts "What's your name"
      name = gets.chomp
      break unless name.empty?
      puts "Sorry, must enter a name"
    end
    self.name = name
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice"
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny'].sample
  end

  def choose
    self.move = Move.new(Move:: VALUES.sample)
  end
end

# Game orchestration engine
class RPSGame
  attr_accessor :human, :computer
  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, goodbye!"
  end

  def display_moves
    puts "#{human.name} chose: #{human.move.value}"
    puts "#{computer.name} chose: #{computer.move.value}"
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie"
    end
  end

  def play # Procedural or imperative code goes here
    display_welcome_message
    loop do
      system 'clear'
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? Yes or no?"
      answer = gets.chomp
      break if ['yes', 'no'].include? answer.downcase
      puts "Sorry, your answer must be yes or no!"
    end
    return true if answer.downcase == 'yes'
    return false if answer.downcase == 'no'
  end
end

RPSGame.new.play
