class Glove::Components::Color < Glove::Component
  property :color

  @color : Glove::Color

  def initialize(@color : Glove::Color)
  end
end
