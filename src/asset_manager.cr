class Glove::AssetManager
  def initialize
    @textures = {} of String => Glove::Texture
  end

  @@instance = new

  def self.instance
    @@instance
  end

  def texture_from(path)
    texture = @textures[path]?
    unless texture
      @textures[path] = Glove::Texture.from(path)
    end
    @textures[path]
  end
end
