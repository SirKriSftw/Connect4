require "spec_helper"
require_relative "../lib/board"

RSpec.describe "Board Class" do

  describe "#place" do
    it "places a piece at the bottom of the 1st column" do
      board = Board.new
      expect(board.place(1)).to eql([[1],[],[],[],[],[],[]])
    end
  end

end
