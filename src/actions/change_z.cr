class Glove::Actions::ChangeZ < Glove::InstantAction
  def initialize(@entity : Glove::Entity, @new_z : Float32)
    super()
  end

  def update(delta_time)
    @entity << Glove::Components::Z.new(@new_z)
  end
end
