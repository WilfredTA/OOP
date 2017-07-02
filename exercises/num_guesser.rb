#Create an object-oriented number guessing class for numbers in 
# the range 1 to 100, with a limit of 7 guesses per game.

# Nouns: Player, Guess, Range, Guess limit, Game
# Verbs: Guess, hint, count remaining guesses

# Player: Guess
# Game: hint, count remaining guesses


#Included is part 1 and 2


class Player
	attr_reader :guess
	attr_accessor :limit

	def initialize(limit)
		@limit = limit
	end

	def guess_number(number)
		@guess = number
		self.limit -= 1
	end
end


class GuessingGame
	attr_reader :player, :number_to_guess, :range

	def initialize(beginning, ending)
		@max_guesses = Math.log2(ending - beginning + 1).to_i + 1
		@player = Player.new(@max_guesses)
		@range = (beginning..ending)
		@number_to_guess = @range.to_a.sample
	end


	def play
		loop do
			display_remaining_guesses
			player_input_guess
			display_hint
			break if player_correct? || guess_limit_reached?
		end
		display_results
	end

	private

	def display_remaining_guesses
		puts "You have #{player.limit} guesses remaining"
	end

	def player_input_guess
		guess = nil
		loop do
			puts "Enter a number between #{range.min} and #{range.max} "
			guess = gets.chomp.to_i
			break if valid_guess?(guess)
			error_message(guess)
		end
		player.guess_number(guess)
	end


	def valid_guess?(guess)
		range.include?(guess)
	end

	def display_hint
		if player.guess < number_to_guess
			puts "Your guess is too low"
		elsif player.guess > number_to_guess
			puts "Your guess is too high"
		end
	end

	def error_message(guess)
		if (guess < range.min) || (guess > range.max)
			puts "Error: enter a number between #{range.min} and #{range.max}"
		else 
			puts "Error: must enter an integer"
		end
	end

	def player_correct?
		player.guess == number_to_guess
	end

	def guess_limit_reached?
		player.limit == 0
	end

	def display_results
		if player.guess == number_to_guess
			puts "You won! The correct number to guess was #{number_to_guess}"
		else
			puts "You have used the maximum number of guesses"
			puts ''
			puts "The correct number to guess was #{number_to_guess}"
		end
	end
end

game = GuessingGame.new(501, 1500)
game.play