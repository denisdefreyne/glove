struct Glove::Vector
  property :dx
  property :dy

  def initialize(@dx : Float32, @dy : Float32)
  end

  def +(other : Glove::Vector)
    self.class.new(dx + other.dx, dy + other.dy)
  end

  def -(other : Glove::Vector)
    self.class.new(dx - other.dx, dy - other.dy)
  end

  def *(other)
    self.class.new(dx * other, dy * other)
  end

  def /(other)
    self.class.new(dx / other, dy / other)
  end
end
