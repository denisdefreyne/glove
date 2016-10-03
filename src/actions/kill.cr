class Glove::Actions::Kill < Glove::InstantAction
  def initialize(@entity : Glove::Entity)
    super()
  end

  def update(_delta_time)
    @entity.dead = true
  end
end
