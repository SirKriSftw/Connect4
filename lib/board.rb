class Board
  HEIGHT = 6
  WIDTH = 7

  def initialize
    @spots = []

    WIDTH.count do
      @spots.push(Array.new(HEIGHT))
    end

    @curr_player = 1
  end

  def place(col)
  end

  def print_board
  end

  def win?
  end
end
