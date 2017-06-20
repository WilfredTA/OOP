=begin 
--------------STEP 1: TEXTUAL DESCRIPTION -------
Rock, Paper, Scissors is a two-player game where each player chooses
one of three possible moves: rock, paper, or scissors. The chosen moves
will then be compared to see who wins, according to the following rules:

- rock beats scissors
- scissors beats paper
- paper beats rock

If the players chose the same move, then it's a tie.

--------------STEP 2: EXTRACT NOUNS AND VERBS-------

Nouns: Player, Move, Rule
Verbs: Choose, Compare

--------------STEP 3: ORGANIZE VERBS WITH NOUNS-------
Player
    -Chooose
Move
Rule
- Compare

We aren't sure where compare goes, yet, and only player has a verb right now...

--------------STEP 4: CONVERT TO CLASSES AND METHODS-------
Keep in mind the 'states' the objects of these classes should have...
This step only requires you make a rough class skeleton
Great way to set oneself up for specifying the classes is to ask questions by 
inserting comments in places where you are unsure about what code belongs there.
=end

class Player
  def initialize
    # maybe a "name"? what about a "move"?
  end

  def choose

  end
end

class Move
  def initialize
    # seems like we need something to keep track
    # of the choice... a move object can be "paper", "rock" or "scissors"
  end
end

class Rule
  def initialize
    # not sure what the "state" of a rule object should be
  end
end

# not sure where "compare" goes yet
def compare(move1, move2)

end


# We need an orchestration engine, where the procedural flow should be
#class RPSGame
  #def initialize

#  end

 # def play --- #Starting from that skeleton, we can start to think about what objects are required in the play method to facilitate the game.
 #   display_welcome_message
#  human_choose_move
 # computer_choose_move ---#Both human_choose move and comp_choose move are similar. To eliminate
                        #redundancy, we can decide that both human and computer are objects of the player class
                        # especially since the player class already has a choose method. With this in mind,
                        # We update the RPS class
 # display_winner
 # display_goodbye_message
 # end
#end


# The RPSGame class is a model for an actual game. The above classes and methods 
# are material that the RPSGame class will use. Each instance of the RPSGame - i.e. each object - 
# is an entire game. Therefore, the attributes of the game object will be the nouns identified above, and therefore
# will be instance variables of the game object. The specific values will be the details of each game. 
# When we store a string value in an instance variable, we are simply storing a String object in 
# an instance variable. Below is no different. The only difference is that the objects we store below
# are objects of classes that we have created: collaborator objects. Player and computer are two different
# components or attributes of an entire game. Player and Computer are a special type of object: A Player object
# and each Player object has specific attributes and behaviors of its own as specified by its 'template' or Class. 
class RPSGame
  attr_accessor :player, :computer
  def initialize
    @human = Player.new
    @computer = Player.new 
  end
  
   def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
   end
  
end

#What we've done here is create a class for each of the nouns that are important for our game, 
# and also isolated the important actions.
# We've then created another class that should model the game itself: It puts all the 
# nouns (classes) and verbs (methods) together. So far, this overarching model (class RPSGame)
# instructs any RPSGame object (i.e. a specific game) to automaticlaly initialize 
# two Player objects: one called 'computer' annd one called 'player'. Player objects, according to the 
# Player class, have access to the 'choose' instance method as well. 
# In the RPSGame, we also outline the action or the dynamic aspect that a each game instance should take: 
# this is defined in the 'play' instance method. 