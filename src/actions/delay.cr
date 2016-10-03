class Glove::Actions::Delay < Glove::IntervalAction
  def initialize(@duration : Float32)
    super(@duration)
  end

  def update(delta_time)
  end
end
