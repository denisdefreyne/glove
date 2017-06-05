class Glove::Components::Parallax < Glove::Component
  getter :factor
  getter :offset_x
  getter :offset_y

  def initialize(@factor : Float32, @offset_x : Float32, @offset_y : Float32)
  end
end
