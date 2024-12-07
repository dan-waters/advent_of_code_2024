require 'open-uri' 
require_relative 'equation'

equations = []

open(__dir__ + '/input.txt').readlines(chomp: true).each do |line|
  total, operands = line.split(':')
  operands = operands.chomp.split(' ').map(&:to_i)
  equations << Equation.new(total.to_i, operands)
end

puts equations.select{|v| v.valid_variation_count > 0 }.map(&:total).sum