# --- 1: Make a textual description of the problem ---
=begin
Here is an overview of the game:
- Both participants are initially dealt 2 cards from a 52-card deck.
- The player takes the first turn, and can "hit" or "stay".
- If the player busts, he loses. If he stays, it's the dealer's turn.
- The dealer must hit until his cards add up to at least 17.
- If he busts, the player wins. If both player and dealer stays, then the highest total wins.
- If both totals are equal, then it's a tie, and nobody wins.
=end

# Two types of nouns: Those that perform actions and those that don't: Those that don't
# perform actions are not classes, but attributes of classes; it's not a noun that performs
# actions but a property of another noun which does perform actions
# nouns and verbs: 
# => Nouns
# => player
# => Dealer
# => deck
# => turn
# => score/total
# => card

# => Verbs
# => Deal
# => Hit
# => Stay
# => Bust

# --- 2: Organize verbs and nouns and do a spike to explore the problem ---
=begin
Player
- hit
- stay
- busted?
- total
Dealer
- hit
- stay
- busted?
- total
- deal (should this be here, or in Deck?)
Participant
Deck
- deal (should this be here, or in Dealer?)
Card
Game
- start
=end
# --- 3: Optional: When you have a better idea of the problem, model it ---

module Hand

	def total?
		total = 0
		cards.each do |card|
		total += card.value
		end
	total
	end

	def total_with_ace_correction
		new_total = total?
		if new_total > 21
			cards.select{|card| card.face == 'Ace'}.count.times do
			break if new_total <= 21
			new_total -= 10
			end
		end
		new_total
	end

	def bust?
		total_with_ace_correction > 21
	end

	def better_hand_than?(other)
		if bust? 
			false
		elsif other.bust? 
			true
		else
			(21 - total_with_ace_correction.abs) < (21 - other.total_with_ace_correction.abs)
		end
	end
end

class Participant
	attr_accessor :cards
	include Hand

	def initialize
		@cards = []
	end
end

class Human < Participant
	attr_accessor :stay

	def show
		hand = []
		@cards.each do |card|
			hand << card.to_s
		end
		hand.join(', ')
	end
end

class Computer < Participant
	def stay?
		total_with_ace_correction >= 17
	end

	def show
		@cards[0].to_s
	end
end

class Deck
	def initialize
		# should create a new deck of 52 card objects
		@fifty_two_cards = []
		Card::FACES.each do |face|
			Card::SUITS.each do |suit|
				@fifty_two_cards << Card.new(suit, face)
			end
		end
end

	def deal
		@fifty_two_cards.pop
	end

	def mix
		(1..51).to_a.sample.times do 
			@fifty_two_cards.shuffle!
		end
	end
end

class Card
	attr_accessor :face, :value, :suit
	SUITS = ['Heart', 'Diamond', 'Clubs', 'Spades']
	FACES = ['Ace', '2', '3', '4', '5', '6', '7', '8', '9', '10',
		'Jack', 'Queen', 'King']

	def initialize(suit, face)
		@suit = suit
		@value = face_to_value(face)
		@face = face
	end

	def face_to_value(face)
		case face
		when 'Ace'
			11
		when 'Jack'
			10
		when 'Queen'
			10
		when 'King'
			10
		else
			face.to_i
		end
	end

	def to_s
		"#{face} of #{suit}"
	end
end

class Game # orchestration engine

	def initialize
		@player = Human.new(:human)
		@computer = Computer.new(:computer)
		@deck = Deck.new
	end

	def deal_cards(quantity = 2)
		counter = 0
		loop do
			break if counter >= quantity
			@player.cards << @deck.deal
			@computer.cards << @deck.deal
			counter += 1
		end
	end

	def shuffle_deck
		@deck.mix
	end

	def player_move
		@player.stay = false
		answer = nil
		loop do
			puts "Would you like to hit or stay?"
			answer = gets.chomp.downcase
			break if ['hit', 'stay'].include?(answer)
			puts 'Error, invalid answer. Please choose to hit or stay'
		end

		if answer == 'hit'
			@player.cards << @deck.deal
		else
			@player.stay = true
			puts "You have decided to stay!"
		end
	end

	def computer_move
		if @computer.stay?
			puts "Dealer has decided to stay!"
			puts ''
		else
			puts "Dealer has decided to hit!"
			puts ''
			@computer.cards << @deck.deal
		end
	end

	def show_player_cards
		puts "Your cards are #{@player.show}"
		puts "You have #{@player.cards.count} cards"
		puts "Your card total is #{@player.total_with_ace_correction}"
		puts ''
	end

	def show_computer_cards
		puts "Dealer's first card is #{@computer.show}"
		puts "Dealer has #{@computer.cards.count} cards."
		puts ''
	end

	def winner?
		if tie?
			tie?
		elsif @player.better_hand_than?(@computer)
			puts "You won!"
			puts ''
		else
			puts "Dealer won!"
			puts ''
		end
	end

	def tie?
		(@computer.bust? && @player.bust?) || 
		@computer.total_with_ace_correction == @player.total_with_ace_correction
	end

	def end_round?
		(@computer.stay? && @player.stay) || @player.bust? || @computer.bust?
	end

	def clear
		system 'cls'
		system 'clear'
	end

	def show_results
		puts "Your hand: #{@player.show}"
		puts "Your hand total: #{@player.total_with_ace_correction}"
		puts ''
		puts "Dealer's hand total: #{@computer.total_with_ace_correction}"
	end

	def start
		shuffle_deck
		deal_cards
		loop do
			show_player_cards
			show_computer_cards
			player_move
			show_player_cards
			clear
			computer_move
			break if end_round?
		end
		winner?
		show_results
	end
end

game = Game.new
game.start
