struct Glove::Point
  property :x
  property :y

  def initialize(@x : Float32, @y : Float32)
  end

  def +(other : Glove::Vector)
    Glove::Point.new(x + other.dx, y + other.dy)
  end

  def -(other : Glove::Point)
    Glove::Vector.new(@x - other.x, @y - other.y)
  end

  def -(other : Glove::Vector)
    Glove::Point.new(@x - other.dx, @y - other.dy)
  end

  def inspect(io)
    io << "Point(x = " << @x << ", y = " << @y << ")"
  end
end
