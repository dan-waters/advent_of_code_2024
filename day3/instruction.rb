class Instruction
  def initialize(instruction, enabled = true)
    @operator = instruction[0]
    @operand1 = instruction[1].to_i
    @operand2 = instruction[2].to_i
    @enabled = enabled
  end

  def resolve
    case @operator
    when 'mul'
      @operand1*@operand2
    end
  end
end