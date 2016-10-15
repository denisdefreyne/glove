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

    Glove::Color.new(
      (1.0_f32 - t) * r + t * other.r,
      (1.0_f32 - t) * g + t * other.g,
      (1.0_f32 - t) * b + t * other.b,
      (1.0_f32 - t) * a + t * other.a,
    )
  end
end
