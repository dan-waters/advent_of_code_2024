require 'open-uri'

list1 = []
list2 = []

open(__dir__ + '/input.txt').readlines(chomp: true).each do |line|
  x, y = line.split(/ +/)
  list1 << x.to_i
  list2 << y.to_i
end

list1.sort!
list2.sort!

# Part 1

total = list1.zip(list2).reduce(0) do |total, pair|
  x, y = pair
  total + (x-y).abs
end

puts total

# Part 2

similarity_score = 0

list1.each do |x|
  similarity_score += x*list2.count(x)
end

puts similarity_score