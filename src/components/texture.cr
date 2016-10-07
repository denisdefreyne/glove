class Glove::Components::Texture < Glove::Component
  property :texture

  @texture : Glove::Texture

  def initialize(@texture : Glove::Texture)
  end
end
