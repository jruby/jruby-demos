str = "Welcome to JRuby"

regexp = /Welcome to (?<ruby>\w*Ruby)/

match = regexp.match(str)

puts match['ruby']
puts "I hope you enjoy using #{match['ruby']}"