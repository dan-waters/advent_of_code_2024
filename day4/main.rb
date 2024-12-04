require 'open-uri'
require_relative 'coordinate'

directions = [:up, :down, :left, :right, :up_left, :up_right, :down_left, :down_right]
TARGET = 'XMAS'

# Part 1

puzzle = {}

open(__dir__ + '/input.txt').readlines(chomp: true).each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    coord = Coordinate.new(x + 1, y + 1)
    puzzle[coord] = char
  end
end

def check_direction(direction, starting_coord, puzzle)
  coord = starting_coord
  TARGET.chars.each_with_index do |char, i|
    next if i == 0
    coord = coord.send(direction)
    if puzzle[coord] != char
      return false
    end
  end
  true
end

match_count = 0

puzzle.each do |coord, char|
  next unless char == 'X'
  directions.each do |direction|
    if check_direction(direction, coord, puzzle)
      match_count += 1
    end
  end
end

puts match_count

# Part 2

match_count = 0

puzzle.each do |coord, char|
  next unless char == 'A'
  if puzzle[coord.up_left] == 'S' && puzzle[coord.down_right] == 'M' || puzzle[coord.up_left] == 'M' && puzzle[coord.down_right] == 'S'
    if puzzle[coord.down_left] == 'S' && puzzle[coord.up_right] == 'M' || puzzle[coord.down_left] == 'M' && puzzle[coord.up_right] == 'S'
      match_count += 1
    end
  end
end

puts match_count