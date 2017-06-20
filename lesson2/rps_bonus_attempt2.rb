# Added functionalities 
# Tracking score 
# Score is a noun: Could be a class or could be the state of an existing class

# Keep track of a history of moves. This history should include the round number, the 
# move of each player, and which player won.

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
  attr_accessor :move, :name, :score
  def initialize
    set_name
    self.score = 0
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

class History
  attr_accessor :record, :round
  attr_reader :human, :computer
  
  def initialize(player1, player2)
    @record = {1 => {' winner' => nil,
                     'winning_move' => nil}}
    @round = 1
    @human = player1
    @computer = player2
  end
  
  def increment_round 
    @round += 1
  end
  
  def winner?
    human.score == 2 || computer.score == 2
  end
  
  def update_record
    record[round]= {'winner' => who,
                    'winning_move' => which_move}
  end
  
  def display
    if human.score == 2
      puts "#{human.name} won against #{computer.name}"
    elsif computer.score == 2
      puts "#{computer.name} won against #{human.name}"
    end
  end
  
  def display_history
    record.keys.each do |round_num| 
      puts "round #{round_num}: #{record[round_num]["winner"]} was the winner."
      puts "round #{round_num}: #{record[round_num]["winning_move"]} was the winning move."
      puts ""
      puts "Press enter to see the result for the next round, or type 'end' to exit"
      answer = gets.chomp 
      break if answer.downcase == "end"
    end
  end
  
  private
  def which_move
    if human.move > computer.move
      human.move.value
    elsif human.move < computer.move
      computer.move.value
    else 
      "Tie"
    end
  end
  
  def who
    if which_move == human.move.value
      human.name
    elsif which_move == computer.move.value
      computer.name
    else
      "Nobody"
    end
  end
  
end

# Game orchestration engine
class RPSGame
  attr_accessor :human, :computer, :win
  def initialize
    @human = Human.new
    @computer = Computer.new
    @win = History.new(human, computer)
  end

  def display_welcome_message
    puts "Welcome, #{human.name} to Rock, Paper, Scissors!"
    puts "You will be playing against our robot, #{computer.name}. The 
    first player to win 2 rounds wins the game!"
    puts "Press enter to continue."
    gets 
    system 'cls'
    system 'clear'
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, goodbye!"
  end

  def display_moves
    puts "#{human.name} chose: #{human.move.value}"
    puts "#{computer.name} chose: #{computer.move.value}"
  end
  
  def score_keeper 
    if human.move > computer.move 
      human.score += 1
    elsif human.move < computer.move 
      computer.score += 1
    end
  end
  
  def display_score 
    puts "#{human.name}'s score is #{human.score}"
    puts "#{computer.name}'s score is #{computer.score}"
  end
  
  def round 
     loop do
        human.choose
        computer.choose
        score_keeper
        system 'cls'
        system 'clear'
        display_moves
        puts "Press enter to see results"
        gets
        system 'cls'
        system 'clear'
        display_score
        win.update_record
        break if win.winner?
        win.increment_round
      end
  end

  def play
    display_welcome_message
    loop do
     round
     win.display
     puts "Would you like to see the game history? 
     Type 'yes' to see, otherwise press any key to skip."
     response = gets.chomp 
     win.display_history if response.downcase == "yes"
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
    answer.downcase == "yes"
  end
end
RPSGame.new.play
