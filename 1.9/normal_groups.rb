str = "Welcome to Rails Underground!"

regexp = /Welcome to (Rails .*)/

match = regexp.match(str)

puts match[1]
puts "I hope you enjoyed #{match[1]}"