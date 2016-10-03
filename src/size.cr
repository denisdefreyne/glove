struct Glove::Size
  property :width
  property :height

  def initialize(@width : Float32, @height : Float32)
  end
end
