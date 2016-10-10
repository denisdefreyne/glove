class Glove::Components::Texture < Glove::Component
  @texture : Glove::Texture?

  def initialize(@path : String)
    @texture = nil
  end

  def texture
    @texture ||= Glove::AssetManager.instance.texture_from(@path)
  end

  def path=(path : String)
    @path = path
    @texture = nil
  end
end
