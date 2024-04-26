require_relative "board"

class Game
  def initialize
    @board = Board.new
    @clear_game = false
    @clear_turn = false
    @ai = false
    @random = false
  end

  def play
    ask_options
    play_again = true
    while(play_again) do
      while(@board.win? == -1 && @board.has_space?) do
        
      end
    end
  end

  def ask_options
    puts "Hello, welcome to connect 4"
    print "Would you like to clear the terminal after every game? (Y/N)"
    input = gets.chomp
    input.downcase == "y" ? @clear_game = true : @clear_game = false

    print "Would you like to clear the terminal after every turn? (Y/N)"
    input = gets.chomp
    input.downcase == "y" ? @clear_turn = true : @clear_turn = false

    print "Would you like to go against an AI? (Y/N)"
    input = gets.chomp
    input.downcase == "n" ? @ai = false : @ai = true

    unless (ai == true)
      print "Would you like to let two AIs go against each other? (Y/N)"
      input = gets.chomp
      input.downcase == "y" ? @random = true : @random = false
    end
  end
end
