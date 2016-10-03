class Glove::Actions::Spawn < Glove::IntervalAction
  def initialize(@actions : Array(Glove::Action))
    duration = @actions.map(&.duration).max
    super(duration)
  end

  def update(delta_time)
    @actions.each { |a| a.update_wrapped(delta_time) }
  end
end
