class Glove::Components::Parallax < Glove::Component
  getter :factor

  def initialize(@factor : Float32)
  end
end
