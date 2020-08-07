require 'rubygems'

target = 64
number = 2
factors = []

while factors.length != target do
  # Pick the next number.
  number += 1

  factors = (1..number).to_a.filter do |potential_factor|
    (number % potential_factor).zero?
  end
end

puts "Number: #{number}"
puts "Factors: #{factors.join(', ')}"
