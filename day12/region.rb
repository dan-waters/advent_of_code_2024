Region = Struct.new(:char, :coords) do
  def price
    coords.length * (4 * coords.length - internal_neighbour_count)
  end

  def discounted_price
    coords.length * number_of_corners
  end

  def internal_neighbour_count
    @internal_neighbour_count ||= begin
                                    coords.map do |coord|
                                      coord.neighbours.count { |neighbour| coords.include?(neighbour) }
                                    end.sum
                                  end
  end

  def number_of_corners
    @number_of_corners ||= begin
                             coords.map do |coord|
                               corners = 0
                               if !coords.include?(coord.left) && !coords.include?(coord.up)
                                 corners += 1
                               end

                               if !coords.include?(coord.right) && !coords.include?(coord.down)
                                 corners += 1
                               end

                               if !coords.include?(coord.left) && !coords.include?(coord.down)
                                 corners += 1
                               end

                               if !coords.include?(coord.right) && !coords.include?(coord.up)
                                 corners += 1
                               end

                               if coords.include?(coord.left) && coords.include?(coord.down) && !coords.include?(coord.down_left)
                                 corners += 1
                               end

                               if coords.include?(coord.right) && coords.include?(coord.up) && !coords.include?(coord.up_right)
                                 corners += 1
                               end

                               if coords.include?(coord.left) && coords.include?(coord.up) && !coords.include?(coord.up_left)
                                 corners += 1
                               end

                               if coords.include?(coord.right) && coords.include?(coord.down) && !coords.include?(coord.down_right)
                                 corners += 1
                               end
                               corners
                             end.sum
                           end
  end
end