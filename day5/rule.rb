class Rule
  attr_reader :before, :after

  def initialize(rule)
    @before, @after = rule.split("|").map(&:to_i)
  end

  def verify(update)
    if update.values.include?(@before) && update.values.include?(@after)
      update.values.index(@before) < update.values.index(@after)
    else
      true
    end
  end

  def inspect
    "#{@before}|#{@after}"
  end

  def to_s
    "#{@before}|#{@after}"
  end
end