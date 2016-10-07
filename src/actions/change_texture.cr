class Glove::Actions::ChangeTexture < Glove::InstantAction
  def initialize(@entity : Glove::Entity, @texture_path : String)
    super()
  end

  def update(delta_time)
    @entity.texture = @texture_path
  end
end
