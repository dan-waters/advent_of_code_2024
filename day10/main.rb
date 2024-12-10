require 'open-uri'
require_relative 'coordinate'

map = {}

open(__dir__ + '/input.txt').readlines(chomp: true).each_with_index do |line, y|
  line.chars.each_with_index do |char, x|
    map[Coordinate.new(x + 1, y + 1)] = char.to_i
  end
end

trailheads = map.keys.select { |k| map[k] == 0 }

def find_next_trail(trail, map)
  current_position = trail.last
  current_height = map[current_position]
  current_position.neighbours.select { |n| map[n] == current_height + 1 }.map do |neighbour|
    trail + [neighbour]
  end
end

def number_of_peaks(trailhead, map)
  start = [trailhead]
  trails = [start]
  peaks = []
  while trails.any? do
    trails = trails.flat_map do |trail|
      if map[trail.last] == 9
        peaks << trail.last
        []
      else
        find_next_trail(trail, map)
      end
    end
  end
  peaks
end

puts(trailheads.flat_map do |trailhead|
  number_of_peaks(trailhead, map).uniq.count
end.sum)

puts(trailheads.flat_map do |trailhead|
  number_of_peaks(trailhead, map).count
end.sum)