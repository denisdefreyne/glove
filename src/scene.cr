class Glove::Scene
  getter :spaces

  def initialize
    @spaces = [] of Glove::Space
  end
end
