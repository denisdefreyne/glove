struct Glove::Color
  property :r
  property :g
  property :b
  property :a

  WHITE = Glove::Color.new(1.0_f32, 1.0_f32, 1.0_f32, 1.0_f32)
  BLACK = Glove::Color.new(0.0_f32, 0.0_f32, 0.0_f32, 1.0_f32)

  def initialize(@r : Float32, @g : Float32, @b : Float32, @a : Float32)
  end

  def lerp(other : Glove::Color, t : Float32)
    t = { {0_f32, t}.max, 1_f32}.min
    tn = 1.0_f32 - t

    Glove::Color.new(
      tn * r + t * other.r,
      tn * g + t * other.g,
      tn * b + t * other.b,
      tn * a + t * other.a,
    )
  end
end
