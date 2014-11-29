require_relative 'utils'

phrase_array = []

File.open("word_bank.txt", "r").each_line do |line|
  phrase_array << line.chomp
end

$graphic_array = ["  +---+\n  |   |\n      |\n      |\n      |\n      |\n      |\n=======\n  ",
	                "  +---+\n  |   |\n  0   |\n      |\n      |\n      |\n      |\n=======\n",
	                "  +---+\n  |   |\n  0   |\n  |   |\n      |\n      |\n      |\n=======\n",
	                "  +---+\n  |   |\n  0   |\n \\|   |\n      |\n      |\n      |\n=======\n",
	                "  +---+\n  |   |\n  0   |\n \\|/  |\n      |\n      |\n      |\n=======\n",
	                "  +---+\n  |   |\n  0   |\n \\|/  |\n  |   |\n      |\n      |\n=======\n",
	                "  +---+\n  |   |\n  0   |\n \\|/  |\n  |   |\n /    |\n      |\n=======\n",
	                "  +---+\n  |   |\n  0   |\n \\|/  |\n  |   |\n / \\  |\n      |\n=======\n",
			"  +---+\n  |   |\n  0   |\n /|\\  |\n  |   |\n / \\  |\n      |\n=======\n"]



$phrase_array = []

File.open("word_bank.txt", "r").each_line do |line|
  $phrase_array << line.chomp
end

class GameBoard
	attr_reader :phrase, :game_board, :letters_remaining, :guessed_letters
	def initialize(phrases)
		@phrase = phrases.sample
		@game_board = @phrase.gsub(/[a-z]/, "_")
		@letters_remaining = ("a".."z").to_a
		@guessed_letters = []
		@graphic = $graphic_array[0]
	end


	def correct_guess?(guessed_letter)
		@phrase.include? guessed_letter
	end

	def update_letter_counts(guessed_letter)
		@letters_remaining.delete(guessed_letter)
		@guessed_letters << guessed_letter unless correct_guess?(guessed_letter)
	end

	def solved?
		@phrase == @game_board
	end

	def update_board(guessed_letter)
		@phrase.chars.each_with_index{ |letter, index| @game_board[index] = letter if guessed_letter == letter}
	end

	def solver(guessed_letter)
		if guessed_letter == "solve"
			puts "Guess the phrase:"
			guess = gets.chomp
			if guess.delete(" ") == @phrase.delete(" ")
				@game_board = @phrase
				puts "Congratulations!!"
				return puts @phrase
			else
				puts "Sorry, try again."
			end
		end

		update_letter_counts(guessed_letter)
		update_board(guessed_letter)
	end
	def game_view
		@graphic = $graphic_array[(@guessed_letters.length)]
		puts @graphic
		p @game_board
		p "Letters remaining: " + @letters_remaining.join(", ")
		p "Letters guessed: " + @guessed_letters.join(", ")
	end
end


