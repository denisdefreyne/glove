class Glove::Components::Color < Glove::Component
  property :color

  def initialize(@color : Glove::Color)
  end
end
