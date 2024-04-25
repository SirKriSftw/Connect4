class Board
  HEIGHT = 6
  WIDTH = 7

  attr_accessor :spots
  def initialize
    @spots = []

    WIDTH.times do
      @spots.push(Array.new(HEIGHT))
    end

    @curr_player = 1
    @most_recent_piece = -1
  end

  def play
    # While no one has won and there is still space play
    while (win? == -1 && has_space?) do
      print_board
      while(choice >= 1 && choice <= 7) do
      print "Player #{curr_player} what column would you like to place your piece? (1-7)"
      choice = get.chomp
      end
      place(choice)
    end

  end

  def has_space?
    @spots.any? do |col|
      col.any? {|spot| spot == nil}
    end
  end

  def place(col)
    col = col - 1
    avaliable_slot = @spots[col].index(nil)
    return "Error" if avaliable_slot == nil
    @spots[col][avaliable_slot] = @curr_player
    @most_recent_piece = col
    if @curr_player == 1
      @curr_player = 2
    else
      @curr_player = 1
    end
    @spots
  end

  def print_board
    # A red circle with 1 in the middle
    player1_code = "\u2460".force_encoding("utf-8")
    player1_piece = "\e[31m#{player1_code}\e[0m"

    # A yellow circle with 2 in the middle
    player2_code = "\u2461".force_encoding("utf-8")
    player2_piece = "\e[33m#{player2_code}\e[0m"

    output = ""
    counter = -1
    HEIGHT.times do
      output += "| "
      @spots.each do |col|
        if col[counter] == nil
          output += "o "
        else
          col[counter] == 1 ? output += "#{player1_piece} " : output += "#{player2_piece} "
        end
      end
      counter -= 1
      output += "|\n"
    end

    output
  end

  def win?
    return -1 if @most_recent_piece == -1
    return win_vertically? if win_vertically? != -1
    return win_hortizontally? if win_hortizontally? != -1
    return win_diagonally? if win_diagonally? != -1
    return -1
  end

  def win_vertically?
    # Only check if the most recently placed piece wins
    @curr_player == 1 ? last_player = 2 : last_player = 1
    check = @spots[@most_recent_piece]
    # Set last_piece to last player to play and do not update. Because only last_player can win
    last_piece = last_player
    counter = 1

    check.each do |piece|
      if (piece == last_piece)
        counter += 1
      else
        counter = 1
      end
      if(counter == 4)
        return last_piece
      end
    end
    return -1
  end

  def win_hortizontally?
    # Only check if the most recently placed piece wins
    @curr_player == 1 ? last_player = 2 : last_player = 1
    # Get index of the last played spot
    check = (HEIGHT - 1) - @spots[@most_recent_piece].reverse.index(last_player)
    # Set last_piece to last player to play and do not update. Because only last_player can win
    last_piece = last_player
    counter = 1

    @spots.each do |col|
      if(col[check] == last_piece)
        counter += 1
      else
        counter = 1
      end
      if(counter == 4)
        return last_piece
      end
    end
    return -1
  end

  def win_diagonally?
    # Only check if the most recently placed piece wins
    @curr_player == 1 ? last_player = 2 : last_player = 1
    # Get index of the last played spot
    check = (HEIGHT - 1) - @spots[@most_recent_piece].reverse.index(last_player)
    # Set last_piece to last player to play and do not update. Because only last_player can win
    last_piece = last_player
    counter = 1
    top_left = 0
    bot_left = 0
    top_right = 0
    bot_right = 0

    left_half = @spots[0 .. @most_recent_piece - 1]
    right_half = @spots[@most_recent_piece + 1 .. @spots.length-1]


    left_half.each_with_index do |col, index|
      if (col[check - (@most_recent_piece - index)] == last_piece)
        bot_left += 1
      else
        bot_left = 0
      end

      if (col[check + (@most_recent_piece - index)] == last_piece)
        top_left += 1
      else
        top_left = 0
      end

      if(bot_left == 3 || top_left == 3)
        return last_piece
      end
    end

    right_half.each_with_index do |col, index|
      if (col[check - (@most_recent_piece - index)] == last_piece)
        bot_right += 1
      else
        bot_right = 0
      end

      if (col[check + (@most_recent_piece - index)] == last_piece)
        top_right += 1
      else
        top_right = 0
      end

      if(bot_right == 3 || top_right == 3 || bot_right + top_left == 3 || bot_left + top_right == 3)
        return last_piece
      end
    end
    return -1
  end
end
