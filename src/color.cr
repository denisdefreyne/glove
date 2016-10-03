struct Glove::Color
  property :r
  property :g
  property :b
  property :a

  WHITE = Glove::Color.new(1.0_f32, 1.0_f32, 1.0_f32, 1.0_f32)
  BLACK = Glove::Color.new(0.0_f32, 0.0_f32, 0.0_f32, 1.0_f32)

  def initialize(@r : Float32, @g : Float32, @b : Float32, @a : Float32)
  end
end
