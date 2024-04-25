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

    xit "places a piece at the bottom of the 2nd column, then two at the 1st column. Alternating players" do
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

    xit "placing 7 pieces in the 1st column returns and error" do
      board = Board.new
      6.times do
      board.place(1)
      end
      expect(board.place(1)).to eql("Error")
    end
  end

  describe "#print_board" do
    xit "displays empty board" do
      board = Board.new
      expect(board.print_board).to eql(
        "| o o o o o o o |\n" +
        "| o o o o o o o |\n" +
        "| o o o o o o o |\n" +
        "| o o o o o o o |\n" +
        "| o o o o o o o |\n" +
        "| o o o o o o o |\n"
      )
    end

    xit "displays board with 2nd column bottom filled with player 1" do
      board = Board.new
      player1_code = "\u2460".force_encoding("utf-8")
      player1_piece = "\e[31m#{player1_code}\e[0m"
      board.place(2)
      expect(board.print_board).to eql(
        "| o o o o o o o |\n" +
        "| o o o o o o o |\n" +
        "| o o o o o o o |\n" +
        "| o o o o o o o |\n" +
        "| o o o o o o o |\n" +
        "| o #{player1_piece} o o o o o |\n"
      )
    end

    xit "displays board with 2nd column containing player 1 and player 2 piece stacked" do
      board = Board.new
      player1_code = "\u2460".force_encoding("utf-8")
      player1_piece = "\e[31m#{player1_code}\e[0m"

      player2_code = "\u2461".force_encoding("utf-8")
      player2_piece = "\e[33m#{player2_code}\e[0m"
      board.place(2)
      board.place(2)
      expect(board.print_board).to eql(
        "| o o o o o o o |\n" +
        "| o o o o o o o |\n" +
        "| o o o o o o o |\n" +
        "| o o o o o o o |\n" +
        "| o #{player2_piece} o o o o o |\n" +
        "| o #{player1_piece} o o o o o |\n"
      )
    end
  end

  describe "#win?" do

    xit "return -1. No player has won" do
      board = Board.new
      3.times do
        board.place(1)
        board.place(2)
      end
      board.place(2)
      expect(board.win?).to eql(-1)
    end

    xit "return 2. Player 2 gets 4 in a row vertically" do
      board = Board.new
      3.times do
      board.place(1)
      board.place(2)
      end
      board.place(3)
      board.place(2)
      expect(board.win?).to eql(2)
    end

    xit "return 1. Player 1 gets 4 in a row horizontally" do
      board = Board.new
      counter = 1
      3.times do
      board.place(counter)
      board.place(counter)
      counter += 1
      end
      board.place(4)
      expect(board.win?).to eql(1)
    end

    xit "return 1. Player 1 gets 4 in a row diagonally" do
      board = Board.new
      board.place(1)
      board.place(2)
      board.place(2)
      3.times do
      board.place(3)
      end
      4.times do
      board.place(4)
      end
      expect(board.win?).to eql(1)
    end
  end
end
