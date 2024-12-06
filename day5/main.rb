require 'open-uri'
require_relative 'rule'
require_relative 'update'

rules = open(__dir__ + '/rules.txt').readlines(chomp: true).map do |line|
  Rule.new(line)
end

updates = open(__dir__ + '/updates.txt').readlines(chomp: true).map do |line|
  Update.new(line)
end

# Part 1

puts updates.select { |u| rules.all? { |r| r.verify(u) } }.map { |u| u.values[(u.values.count - 1) / 2] }.sum

# Part 2

later_page_rules = {}

rules.each do |rule|
  if later_page_rules[rule.before]
    later_page_rules[rule.before] << rule.after
  else
    later_page_rules[rule.before] = [rule.after]
  end
end

incorrect_updates = updates.reject { |u| rules.all? { |r| r.verify(u) } }
incorrect_updates.each do |u|
  u.verify!(later_page_rules)
end

puts incorrect_updates.map { |u| u.values[(u.values.count - 1) / 2] }.sum

