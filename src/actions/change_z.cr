class Glove::Actions::ChangeZ < Glove::InstantAction
  def initialize(@entity : Glove::Entity, @new_z : Float32)
    super()
  end

  def update(delta_time)
    @entity.z = @new_z
  end
end
