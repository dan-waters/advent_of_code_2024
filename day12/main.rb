require 'open-uri'
require_relative 'coordinate'
require_relative 'region'

garden = {}

open(__dir__ + '/input.txt').readlines(chomp: true).each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    garden[Coordinate.new(x, y)] = char
  end
end

regions = []

coords = garden.keys.dup

def populate_region(current_coord, region, coords, garden)
  current_coord.neighbours
    .select { |n| coords.include?(n) && garden[n] == region.char }
    .each do |neighbour|
      coords.delete(neighbour)
      region.coords << neighbour
      populate_region(neighbour, region, coords, garden)
    end
end

while coords.any? do
  current = coords.shift
  current_char = garden[current]
  region = Region.new(current_char, [current])
  populate_region(current, region, coords, garden)
  regions << region
end

puts regions.map(&:price).sum

puts regions.map(&:discounted_price).sum