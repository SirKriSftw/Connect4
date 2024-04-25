require "spec_helper"
require_relative "../lib/board"

describe Board do

  describe "#place" do

    it "places a piece at the bottom of the 1st column" do
      board = Board.new
      expect(board.place(1)).to eql(
        [
          [1, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ])
    end

    it "places a piece at the bottom of the 2nd column, then two at the 1st column. Alternating players" do
      board = Board.new
      board.place(2)
      board.place(1)
      expect(board.place(1)).to eql(
        [
          [2, 1, nil, nil, nil, nil],
          [1, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil]
        ])
    end

    it "placing 7 pieces in the 1st column returns and error" do
      board = Board.new
      6.count do
      board.place(1)
      end
      expect(board.place(1)).to eql("Error")
    end

  end

end
