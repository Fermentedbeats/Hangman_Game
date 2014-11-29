require_relative 'Hang-Woman2'
require_relative 'utils'

class Runner
  def initialize
    run
  end

  def get_user_input
    puts "Enter a letter or write solve and guess the puzzle."
    user_input = gets.chomp
    user_input.downcase!

    if user_input.include? "solve"
      @game.solver(user_input)
    elsif user_input.length > 1 && user_input[0] != 'solve'
      puts "Invalid input.  Try again"
      get_user_input
    elsif @game.guessed_letters.include? user_input
      puts "That letter has already been guessed.  Try again"
      get_user_input
    elsif @game.letters_remaining.include? user_input
      @game.solver(user_input)
    else
      puts "That's not a letter. Try again"
      get_user_input
    end
  end


  def run

    @game = GameBoard.new($phrase_array)
    @game.game_view
    until @game.solved? || @game.guessed_letters.length > 6 #initiates loop
      clear_screen! #called from the utils file
       @game.game_view #board printed
       sleep(0.5)
       get_user_input # prompt user for input or solution
    end
    #After loop is broken: (this should be its own method)
    @game.game_view #display final results
    # self.outcome #when game is over, print 'win/lose' message
    return puts "Congrats!" if @game.solved?
    return puts "You were hung."
  end

end


new_game = Runner.new

