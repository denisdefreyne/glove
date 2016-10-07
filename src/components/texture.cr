class Glove::Components::Texture < Glove::Component
  property :texture

  @texture : Glove::Texture

  def initialize(@texture : Glove::Texture)
  end

  def initialize(string : String)
    initialize(Glove::AssetManager.instance.texture_from(string))
  end

  def texture=(string : String)
    self.texture = resolve(string)
  end

  private def resolve(string : String)
    Glove::AssetManager.instance.texture_from(string)
  end
end
