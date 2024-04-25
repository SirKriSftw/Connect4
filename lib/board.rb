class Board

  def initialize
    @spots = [
      Array.new(6),
      Array.new(6),
      Array.new(6),
      Array.new(6),
      Array.new(6),
      Array.new(6),
      Array.new(6)
    ]

    @curr_player = 1
  end

  def place(col)
  end

  def print_board
  end

  def win?
  end
end
