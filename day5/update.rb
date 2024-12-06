class Update
  attr_reader :values

  def initialize(update)
    @values = update.split(',').map(&:to_i)
  end

  def verify!(rules)
    values.sort! do |a, b|
      if rules[a]&.include?(b)
        -1
      elsif rules[b]&.include?(a)
        1
      else
        0
      end
    end
  end
end