require 'open-uri'
require_relative 'instruction'

MUL_REGEX = /(mul)\((\d+),(\d+)\)/

# Part 1

raw_instructions = open(__dir__ + '/input.txt').readlines.join('|')

instructions = []
raw_instructions.scan(MUL_REGEX).each do |instruction|
  instructions << Instruction.new(instruction)
end

puts instructions.inject(0) { |acc, instruction| acc + instruction.resolve }

# Part 2

MUL_DO_REGEX = /(mul)\((\d+),(\d+)\)|(do\(\))|(don't\(\))/

instructions = []
enabled = true

raw_instructions.scan(MUL_DO_REGEX).each do |instruction|
  if instruction[3]
    enabled = true
  elsif instruction[4]
    enabled = false
  elsif enabled
    instructions << Instruction.new(instruction)
  end
end

puts instructions.inject(0) { |acc, instruction| acc + instruction.resolve }