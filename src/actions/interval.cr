abstract class Glove::IntervalAction < Glove::Action
  getter :duration
  getter :duration_spent

  def initialize(@duration : Float32)
    @duration_spent = 0_f32
  end

  def start
  end

  def done?
    @duration_spent >= @duration
  end

  abstract def update(delta_time)

  def update_wrapped(delta_time)
    if @duration_spent == 0_f32
      start
    end

    update(delta_time)

    @duration_spent += delta_time
  end
end
