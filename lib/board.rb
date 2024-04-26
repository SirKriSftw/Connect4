class Board
  HEIGHT = 6
  WIDTH = 7

  attr_accessor :curr_player, :width
  def initialize
    reset_board
  end

  def play(play_clear = true, turn_clear = false, ai = true, random = false)
    play_again = true
    while(play_again) do
      if play_clear then system("cls") end
      reset_board
      # While no one has won and there is still space play
      while (win? == -1 && has_space?) do
        if turn_clear then system("cls") end
        puts print_board
        choice = 0
        unless (random)
          unless(ai && @curr_player == 2)
            while(!(choice >= 1 && choice <= 7)) do
              if(@curr_player == 1) then print "\e[31mPlayer #{@curr_player}\e[0m what column would you like to place your piece? (1-7)" else print "\e[33mPlayer #{@curr_player}\e[0m what column would you like to place your piece? (1-7)" end

              choice = gets.chomp.to_i
            end
            output = place(choice)
          else
            while(!(choice >= 1 && choice <= 7)) do
              choice = rand(1..7)
              print "\n\n\n\e[33mAI chose #{choice}\e[0m\n"
              output = place(choice)
            end
          end
        else
          while(!(choice >= 1 && choice <= 7)) do
            choice = rand(1..7)
            if(@curr_player == 1) then puts "\e[31mAI##{@curr_player}\e[0m chose #{choice}" else puts "\e[33mAI##{@curr_player}\e[0m chose #{choice}" end
            output = place(choice)
          end
        end
        if(output == "Error")
          puts "\e[31mCannot place a piece in column #{choice} because it is full!\e[0m"
        end
      end
      if(win? == 1 && !random)
        puts print_board
        puts "Player 1 won!"
      elsif(win? == 1)
        puts print_board
        puts "AI#1 won!"
      elsif(win? == 2 && !ai && !random)
        puts print_board
        puts "Player 2 won!"
      elsif(win? == 2 && random)
        puts print_board
        puts "AI#2 won!"
      elsif(win? == 2)
        puts print_board
        puts "AI won!"
      else
        puts print_board
        puts "It is a draw!"
      end
      print "Play again?"
      input = gets.chomp
      if input.downcase == "n" || input.downcase == "n" then play_again = false end
    end
  end

  def has_space?
    @spots.any? do |col|
      col.any? {|spot| spot == nil}
    end
  end

  def reset_board
    @spots = []
    @width = WIDTH
    @width.times do
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
    @curr_player == 1 ? @curr_player = 2 : @curr_player = 1
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
    return win_horizontally? if win_horizontally? != -1
    return win_diagonally? if win_diagonally? != -1
    return -1
  end

  def win_vertically?
    # Only check if the most recently placed piece wins
    @curr_player == 1 ? last_player = 2 : last_player = 1
    check = @spots[@most_recent_piece]
    # Set last_piece to last player to play and do not update. Because only last_player can win
    last_piece = last_player
    counter = 0

    check.each do |piece|
      if (piece == last_piece)
        counter += 1
      else
        counter = 0
      end
      if(counter == 4)
        return last_piece
      end
    end
    return -1
  end

  def win_horizontally?
    # Only check if the most recently placed piece wins
    @curr_player == 1 ? last_player = 2 : last_player = 1
    # Get index of the last played spot
    check = (HEIGHT - 1) - @spots[@most_recent_piece].reverse.index(last_player)
    # Set last_piece to last player to play and do not update. Because only last_player can win
    last_piece = last_player
    counter = 0

    @spots.each do |col|
      if(col[check] == last_piece)
        counter += 1
      else
        counter = 0
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
    top_left = 0
    bot_left = 0
    top_right = 0
    bot_right = 0

    tl_broken = false
    bl_broken = false
    tr_broken = false
    br_broken = false

    left_half = []
    right_half = []
    unless @most_recent_piece == 0 then left_half = @spots[0 .. @most_recent_piece - 1].reverse end
    unless @most_recent_piece == WIDTH then right_half = @spots[@most_recent_piece + 1 .. @spots.length-1] end


    left_half.each_with_index do |col, index|
      tl_offset = check + (index + 1)
      bl_offset = check - (index + 1)

      unless tl_offset < 0 || tl_offset >= HEIGHT
        if (col[tl_offset] == last_piece && !tl_broken)
          top_left += 1
        else
          tl_broken = true
        end
      end

      unless bl_offset < 0 || bl_offset >= HEIGHT
        if (col[bl_offset] == last_piece && !bl_broken)
          bot_left += 1
        else
          bl_broken = true
        end
      end

      if(top_left == 3 || bot_left  == 3)
        return last_piece
      end

      if(tl_broken && bl_broken)
        break
      end
    end


    right_half.each_with_index do |col, index|
      tr_offset = check + (index + 1)
      br_offset = check - (index + 1)

      unless tr_offset < 0 || tr_offset >= HEIGHT
        if (col[tr_offset] == last_piece && !tr_broken)
          top_right += 1
        else
          tr_broken = true
        end
      end

      unless br_offset < 0 || br_offset >= HEIGHT
        if (col[br_offset] == last_piece && !br_broken)
          bot_right += 1
        else
          br_broken = true
        end
      end
      if(bot_right == 3 || top_right == 3 || bot_right + top_left >= 3 || bot_left + top_right >= 3)
        return last_piece
      end

      if(tr_broken && br_broken)
        break
      end

    end
    return -1
  end
end
