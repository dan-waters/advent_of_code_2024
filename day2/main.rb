require 'open-uri'
require_relative 'report'

reports = []

open(__dir__ + '/input.txt').readlines(chomp: true).each do |line|
  reports << Report.new(line.split(' ').map(&:to_i))
end

puts reports.count(&:safe?)

puts reports.count(&:dampened_safe?)