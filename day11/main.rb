require 'open-uri'

stones = open(__dir__ + '/input.txt').readline(chomp: true).split(' ').map(&:to_i)


def blink(stone)
  if stone == 0
    [1]
  elsif (stone_str = stone.to_s) && stone_str.length % 2 == 0
    stone_str.split(/(?<=\A.{#{stone_str.size / 2}})/).map(&:to_i)
  else
    [stone * 2024]
  end
end

# Part 1

25.times do
  stones = stones.flat_map do |stone|
    blink(stone)
  end
end

puts stones.count

# Part 2

stones = {}
open(__dir__ + '/input.txt').readline(chomp: true).split(' ').map(&:to_i).each do |number|
  stones[number] = 1
end

75.times do
  new_stones = Hash.new(0)
  stones.each do |stone, count|
    blink(stone).each do |new_stone|
      new_stones[new_stone] += count
    end
    stones = new_stones
  end
end

puts stones.values.sum