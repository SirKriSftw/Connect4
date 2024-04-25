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
    return win_vertically? if win_vertically? != -1
    return win_hortizontally? if win_hortizontally? != -1
    return win_diagonally? if win_diagonally? != -1
    return -1
  end

  def win_vertically?
    # Only check if the most recently placed piece wins
    @curr_player == 1 ? last_player = 2 : last_player = 1
    check = @spots[@most_recent_piece]
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
    check = @spots[@most_recent_piece].reverse.index(last_player)

    last_piece = last_player
    counter = 1

    end
    return -1
  end

  def win_diagonally?
  end
end
