require_relative "board"
item = "\u2460".force_encoding("utf-8")
item2 = "\u2461".force_encoding("utf-8")
#puts item
#puts item2
#puts "Test \e[31m#{item}\e[0m"
#puts "\e[33m#{item2}\e[0m"
board = Board.new

counter = 1
3.times do
board.place(counter)
board.place(counter)
counter += 1
end
board.place(4)
puts board.print_board
board.win?
