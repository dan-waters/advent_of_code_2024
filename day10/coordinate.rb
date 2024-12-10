Coordinate = Struct.new(:x, :y) do
  def ==(other)
    x == other.x && y == other.y
  end

  def left
    Coordinate.new(x - 1, y)
  end

  def right
    Coordinate.new(x + 1, y)
  end

  def up
    Coordinate.new(x, y - 1)
  end

  def down
    Coordinate.new(x, y + 1)
  end

  def neighbours
    [up, down, left, right]
  end

  def to_s
    "(#{x}, #{y})"
  end

  alias :inspect :to_s
end
