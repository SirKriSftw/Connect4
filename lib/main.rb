item = "\u2460".force_encoding("utf-8")
item2 = "\u2461".force_encoding("utf-8")
puts item
puts item2

puts "Test \e[31m#{item}\e[0m"
puts "\e[33m#{item2}\e[0m"
