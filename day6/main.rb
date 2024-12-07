require 'open-uri'
require_relative 'coordinate'

def reset_grid(grid)
  starting_coord = nil
  open(__dir__ + '/input.txt').readlines(chomp: true).each_with_index do |line, y|
    line.chars.each_with_index do |char, x|
      coord = Coordinate.new(x, y)
      grid[coord] = char
      starting_coord = coord if char == '^'
    end
  end
  starting_coord
end

def rotate_right(direction)
  case direction
  when :up
    :right
  when :left
    :up
  when :right
    :down
  when :down
    :left
  else
    raise 'o no'
  end
end

def inside_maze?(coord, grid)
  grid.key?(coord)
end

grid = {}
starting_coord = reset_grid(grid)
current_coord = starting_coord
current_direction = :up
visited = []

while inside_maze?(current_coord, grid) do
  visited << current_coord unless visited.include?(current_coord)
  new_coord = current_coord.send(current_direction)
  if grid[new_coord] == '#'
    current_direction = rotate_right(current_direction)
  else
    current_coord = new_coord
  end
end

puts visited.count

# Part 2

loops = 0

visited[1..].each do |coord|
  new_x = coord.x
  new_y = coord.y

  current_coord = reset_grid(grid)
  grid[Coordinate.new(new_x, new_y)] = '#'
  current_direction = :up
  new_visited = Set.new

  while inside_maze?(current_coord, grid) do
    if new_visited.include?(State.new(current_coord.x, current_coord.y, current_direction))
      loops += 1
      break
    else
      new_visited << State.new(current_coord.x, current_coord.y, current_direction)
      new_coord = current_coord.send(current_direction)
      if grid[new_coord] == '#'
        current_direction = rotate_right(current_direction)
      else
        current_coord = new_coord
      end
    end
  end
end

puts loops