class Glove::Actions::ChangeZ < Glove::InstantAction
  def initialize(@entity : Glove::Entity, @new_z : Int32)
    super()
  end

  def update(delta_time)
    @entity.z = @new_z
  end
end
