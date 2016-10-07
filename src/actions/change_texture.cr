class Glove::Actions::ChangeTexture < Glove::InstantAction
  def initialize(@entity : Glove::Entity, @texture_path : String)
    super()
  end

  def update(delta_time)
    @entity << Glove::Components::Texture.new(@texture_path)
  end
end
