require 'open-uri'
require 'stackprof'

GC.disable

class Disk
  def initialize(disk_map)
    @disk_map = disk_map
    expand!
  end

  def expand!
    @file = []
    @disk_map.chars.each_with_index do |char, i|
      if i % 2 == 0
        char.to_i.times do
          @file << (i / 2).to_s
        end
      else
        char.to_i.times do
          @file << '.'
        end
      end
    end
  end

  def compress!
    @file.each_with_index do |block, index|
      empty_block_count = @file.count('.')
      sort_count = @file.length - empty_block_count
      if index < sort_count && block == '.'
        last_index = @file.rindex { |x| x != '.' }
        @file[index], @file[last_index] = @file[last_index], @file[index]
      end
    end
  end

  def checksum
    @file.each_with_index.inject(0) do |sum, (block, index)|
      sum + index * block.to_i
    end
  end
end

disk_map = open(__dir__ + '/input.txt').readline(chomp: true)

disk = Disk.new(disk_map)
#disk.compress!
puts disk.checksum

class Disk2 < Disk
  def expand!
    @file = []
    @disk_map.chars.each_with_index do |char, i|
      if i % 2 == 0
        @file << { id: i / 2, length: char.to_i }
      else
        @file << { id: :blank, length: char.to_i }
      end
    end
  end

  def compress!
    @file.reverse.each do |block|
      space = @file.detect { |blank| blank[:id] == :blank && blank[:length] >= block[:length] }
      index = @file.index(space)
      replacement_index = @file.index(block)
      if space.nil? || block[:id] == :blank || replacement_index <= index
        next
      elsif space[:length] > block[:length]
        @file.delete(block)
        @file.insert(replacement_index, {id: :blank, length: block[:length]})
        @file.insert(index, block)
        space[:length] = space[:length] - block[:length]
      elsif space[:length] == block[:length]
        @file.delete_at(index)
        @file.delete(block)
        @file.insert(index, block)
        @file.insert(replacement_index, {id: :blank, length: block[:length]})
      end
    end
  end

  def checksum
    index = 0
    @file.map do |block|
      sum = 0
      block[:length].times do
        if block[:id].is_a?(Integer)
          sum += index * block[:id]
        else
          0
        end
        index += 1
      end
      sum
    end.sum
  end
end

disk = Disk2.new(disk_map)
disk.compress!
puts disk.checksum