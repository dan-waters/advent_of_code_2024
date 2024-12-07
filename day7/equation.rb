class Equation
  attr_accessor :total
  def initialize(total, operands)
    @total = total
    @operands = operands
  end

  def variations
    operators = [:+, :*, :concat]
    variations = [[@operands.first]]
    @operands.each_with_index do |operand, i|
      next if i == 0
      new_variations = []
      variations.each do |variation|
        variant_1 = variation + [operators[0], operand]
        variant_2 = variation + [operators[1], operand]
        variant_3 = variation + [operators[2], operand]
        new_variations += [variant_1, variant_2,variant_3]
      end
      variations = new_variations
    end
    variations
  end

  def valid_variation_count
    puts @total
    variations.select { |v| verify(v) }.count
  end

  def verify(variation)
    copy = variation.dup
    running_total = copy.shift
    copy.each_slice(2) do |operator, operand|
      running_total = running_total.send(operator, operand)
    end
    running_total == @total
  end

  def to_s
    "#{@total}: #{@operands.map(&:to_s).join(' ')}"
  end
end

class Integer
  def concat(other)
    self.to_s.concat(other.to_s).to_i
  end
end