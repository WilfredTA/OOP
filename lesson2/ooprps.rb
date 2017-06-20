class Player
  attr_accessor :move, :name
  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    set_name
  end
  
  def set_name 
    if human? 
      name = nil
      loop do
        puts "What's your name"
        name = gets.chomp #this is a local variabel called name not setter method
        break unless name.empty?
        puts "Sorry, must enter a name"
      end
      self.name = name
    else
      self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny'].sample
    end
  end
  
  def choose
    if human?
      choice = nil
      loop do
        puts "Please choose rock, paper, or scissors"
        choice = gets.chomp
        break if ['rock', 'paper', 'scissors'].include? choice
        puts "Sorry, invalid choice"
      end
        self.move = choice
    else
     self.move = ['rock','paper','scissors'].sample
    end
  end 
  
  def human? 
    @player_type == :human
  end
end




#Game orchestration engine
class RPSGame
  attr_accessor :human, :computer
  def initialize
    @human = Player.new
    @computer = Player.new(:computer) 
  end
  
  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end
  
  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, goodbye!"
  end
  
  def display_winner 
    puts "#{human.name} chose: #{human.move}"
    puts "#{computer.name} chose: #{computer.move}"
    
    case human.move
      when 'rock'
        puts "It's a tie!" if computer.move == 'rock'
        puts "#{human.name} won!" if computer.move == 'scissors'
        puts "{human.name} lost!" if computer.move == 'paper'
      when 'paper'
        puts "It's a tie!" if computer.move == 'paper'
        puts "#{human.name} won!" if computer.move == 'rock'
        puts "#{human.name} lost!" if computer.move == 'scissors'
      when 'scissors'
        puts "It's a tie!" if computer.move == 'scissors'
        puts "#{human.name} won!" if computer.move == 'paper'
        puts "#{human.name} lost!" if computer.move == 'rock'
    end
  end
  
   def play #Procedural or imperative code goes here
      display_welcome_message
      loop do 
        system 'clear'
        human.choose #Instance method of the player class because human is gonna be an object of Player class
        computer.choose
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
       break if ['yes','no'].include? answer.downcase
       puts "Sorry, your answer must be yes or no!"
     end
     return true if answer.downcase == 'yes'
     false
   end
     
  
end

RPSGame.new.play
