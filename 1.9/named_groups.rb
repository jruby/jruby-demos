str = "Welcome to Rails Underground"

regexp = /Welcome to (?<conf>Rails .*)/

match = regexp.match(str)

puts match['conf']
puts "I hope you enjoyed #{match['conf']}"