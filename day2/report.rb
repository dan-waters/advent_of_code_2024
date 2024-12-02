class Report
  def initialize(values)
    @values = values
  end

  def direction
    @values[0] > @values[1] ? :decreasing : :increasing
  end

  def safe?
    if direction == :increasing
      @values.each_cons(2).all? do |x, y|
        x < y && (y - x) <= 3
      end
    elsif direction == :decreasing
      @values.each_cons(2).all? {|x,y| y < x && (x - y) <= 3}
    end
  end

  def dampened_safe?
    if safe?
      true
    else
      @values.count.times do |index|
        new_values = @values.dup
        new_values.delete_at(index)
        return true if Report.new(new_values).safe?
      end
      false
    end
  end
end