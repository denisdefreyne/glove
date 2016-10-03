abstract class Glove::InstantAction < Glove::Action
  def initialize
    @done = false
  end

  def start
  end

  def done?
    @done
  end

  def duration
    0_f32
  end

  def duration_spent
    0_f32
  end

  abstract def update(_delta_time)

  def update_wrapped(delta_time)
    update(delta_time)
    @done = true
  end
end
