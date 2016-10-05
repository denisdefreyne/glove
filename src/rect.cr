struct Glove::Rect
  property :origin
  property :size

  def initialize(@origin : Glove::Point, @size : Glove::Size)
  end

  def contains?(point : Glove::Point)
    @origin.x <= point.x && point.x <= @origin.x + @size.width &&
      @origin.y <= point.y && point.y <= @origin.y + @size.height
  end

  def grow(size : Float32)
    Rect.new(
      Point.new(@origin.x - size, @origin.y - size),
      Size.new(@size.width + 2 * size, @size.width + 2 * size),
    )
  end

  def left
    @origin.x
  end

  def right
    @origin.x + @size.width
  end

  def bottom
    @origin.y
  end

  def top
    @origin.y + @size.height
  end

  def overlaps_with?(other : Glove::Rect)
    self.left < other.right &&
      self.right > other.left &&
      self.bottom < other.top &&
      self.top > other.bottom
  end

  def overlaps_on_bottom_with?(other : Glove::Rect)
    self.left < other.right &&
      self.right > other.left &&
      self.bottom < other.top &&
      self.bottom > other.bottom
  end
end
