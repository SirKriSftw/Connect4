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
        if @clear_turn then system("cls") || system("clear") end
        print_board_with_header
        if @random then play_random end
        if @ai && @board.curr_player == 2 then play_ai end
        if !@random && !(@ai && @board.curr_player == 2) then play_human end
      end
    end
  end

  def print_board_with_header
    puts "\e[47m  \e[30m1 2 3 4 5 6 7  \e[0m"
    puts @board.print_board
    puts "\e[47m  \e[30m1 2 3 4 5 6 7  \e[0m"
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

    unless (@ai == true)
      print "Would you like to let two AIs go against each other? (Y/N)"
      input = gets.chomp
      input.downcase == "y" ? @random = true : @random = false
    end
  end

  def play_random
    while(@board.win? == -1 && @board.has_space?) do
      play_ai
    end
  end

  def play_ai
    loop do
      choice = rand(1..@board.width)
      output = @board.place(choice)
      unless (output == "Error")
        if(@curr_player == 2)
          puts "\n\e[31mAI Player 1\e[0m chose #{choice}"
        else
          puts "\n\e[33mAI Player 2\e[0m chose #{choice}"
        end
        print_board_with_header
        return
      end
    end
  end

  def play_human

    loop do
      choice = 0
      while(!(choice > 0 && choice <= @board.width))
        if(@board.curr_player == 1)
          print "\n\e[31mPlayer #{@board.curr_player}\e[0m what column would you like to place your piece? (1-7): "
        else
          print "\n\e[33mPlayer #{@board.curr_player}\e[0m what column would you like to place your piece? (1-7): "
        end
        choice = gets.chomp.to_i
      end
      output = @board.place(choice)
      if (output == "Error")
        puts "\e[31mCannot place a piece in column #{choice} because it is full!\e[0m"
      else
        puts ""
        if @board.curr_player == 2 then puts "\e[31mPlayer 1\e[0m chose #{choice}" else puts "\e[33mPlayer 2\e[0m chose #{choice}" end
        return
      end
    end
  end
end
