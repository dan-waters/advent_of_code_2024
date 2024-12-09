require 'open-uri'
require_relative 'antenna'

antennae = []
max_x = 0
max_y = 0

open(__dir__ + '/input.txt').readlines(chomp: true).each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    antennae << Antenna.new(char, x.to_i, y.to_i) if char != '.'
    max_x = x if x > max_x
    max_y = y if y > max_y
  end
end

# Part 1

antinodes = []

antennae.group_by { |antenna| antenna.code }.map do |code, antennas|
  antennas.combination(2) do |a, b|
    if 0 <= (2 * a.x - b.x) && (2 * a.x - b.x) <= max_x && (0 <= 2 * a.y - b.y) && (2 * a.y - b.y) <= max_y
      antinodes << Antinode.new(code, 2 * a.x - b.x, 2 * a.y - b.y)
    end
    if 0 <= (2 * b.x - a.x) && (2 * b.x - a.x) <= max_x && 0 <= (2 * b.y - a.y) && (2 * b.y - a.y) <= max_y
      antinodes << Antinode.new(code, 2 * b.x - a.x, 2 * b.y - a.y)
    end
  end
end

puts antinodes.map{|node| [node.x, node.y]}.uniq.count

# Part 2

antinodes = []

antennae.group_by { |antenna| antenna.code }.map do |code, antennas|
  antennas.combination(2) do |a, b|
    i = 0
    while 0 <= (a.x + i * (a.x - b.x)) && (a.x + i * (a.x - b.x)) <= max_x && 0 <= (a.y + i * (a.y - b.y)) && (a.y + i * (a.y - b.y)) <= max_y do
      antinodes << Antinode.new(code, a.x + i * (a.x - b.x), a.y + i * (a.y - b.y))
      i += 1
    end

    i = 0
    while 0 <= (b.x + i * (b.x - a.x)) && (b.x + i * (b.x - a.x)) <= max_x && 0 <= (b.y + i * (b.y - a.y)) && (b.y + i * (b.y - a.y)) <= max_y do
      antinodes << Antinode.new(code, b.x + i * (b.x - a.x), b.y + i * (b.y - a.y))
      i += 1
    end
  end
end

puts antinodes.map{|node| [node.x, node.y]}.uniq.count