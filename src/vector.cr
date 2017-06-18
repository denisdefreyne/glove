struct Glove::Vector
  property :dx
  property :dy

  def initialize(@dx : Float32, @dy : Float32)
  end

  def +(other : Glove::Vector)
    Glove::Vector.new(dx + other.dx, dy + other.dy)
  end

  def -(other : Glove::Vector)
    Glove::Vector.new(dx - other.dx, dy - other.dy)
  end

  def *(other)
    Glove::Vector.new(dx * other, dy * other)
  end

  def /(other)
    Glove::Vector.new(dx / other, dy / other)
  end
end
