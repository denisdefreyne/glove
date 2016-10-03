class Glove::Actions::Sequence < Glove::IntervalAction
  def initialize(@actions : Array(Glove::Action))
    duration = @actions.sum(&.duration)
    super(duration)

    @active_index = 0
  end

  def done?
    @active_index >= @actions.size
  end

  def update(delta_time)
    return if @active_index >= @actions.size
    if animation = @actions[@active_index]
      if animation.done?
        @active_index += 1
        update(delta_time)
      else
        animation.update_wrapped(delta_time)
      end
    end
  end
end
