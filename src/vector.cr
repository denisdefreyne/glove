struct Glove::Vector
  property :dx
  property :dy

  def initialize(@dx : Float32, @dy : Float32)
  end
end
