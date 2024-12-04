Coordinate = Struct.new(:x, :y) do
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

  def up_left
    Coordinate.new(x - 1, y - 1)
  end

  def up_right
    Coordinate.new(x + 1, y - 1)
  end

  def down_left
    Coordinate.new(x - 1, y + 1)
  end

  def down_right
    Coordinate.new(x + 1, y + 1)
  end
end