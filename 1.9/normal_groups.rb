str = "Welcome to JRuby"

regexp = /Welcome to (\w*Ruby)/

match = regexp.match(str)

puts match[1]
puts "I hope you enjoy using #{match[1]}"