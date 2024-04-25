class Board
  HEIGHT = 6
  WIDTH = 7

  def initialize
    @spots = []

    WIDTH.times do
      @spots.push(Array.new(HEIGHT))
    end

    @curr_player = 1
  end

  def place(col)
    avaliable_slot = @spots[col].index(nil)
    p avaliable_slot
    return "Error" if avaliable_slot == nil
    @spots[col][avaliable_slot] = @curr_player
    if @curr_player == 1
      @curr_player = 2
    else
      @curr_player = 1
    end
    @spots
  end

  def print_board
  end

  def win?
  end
end
