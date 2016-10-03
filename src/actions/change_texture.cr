class Glove::Actions::ChangeTexture < Glove::InstantAction
  @texture : Glove::Texture

  def initialize(@entity : Glove::Entity, @texture_path : String)
    super()
    @texture = Glove::AssetManager.instance.texture_from(texture_path)
  end

  def update(delta_time)
    @entity.texture = @texture
  end
end
