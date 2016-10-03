class Glove::Actions::ReplaceScene < Glove::InstantAction
  def initialize(@scene : Glove::Scene, @app : Glove::App)
    super()
  end

  def update(delta_time)
    @app.replace_scene(@scene)
  end
end
