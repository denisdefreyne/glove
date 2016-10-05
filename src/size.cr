struct Glove::Size
  property :width
  property :height

  def initialize(@width : Float32, @height : Float32)
  end

  def inspect(io)
    io << "Size(width = " << @width << ", height = " << @height << ")"
  end
end
