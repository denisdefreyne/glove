class Glove::Tween
  def initialize(@duration : Float32)
    @time_spent = 0_f32

    # TODO: pass in type
    @type = :ease_out
  end

  def linear_fraction
    raw_fraction = @time_spent / @duration
    raw_fraction > 1_f32 ? 1_f32 : raw_fraction
  end

  def fraction
    lf = linear_fraction

    case @type
      # TODO: add other types
    when :linear
      lf
    when :ease_in
      lf * lf * lf
    when :ease_out
      lf_inv = lf - 1_f32
      lf_inv * lf_inv * lf_inv + 1_f32
    else
      lf
    end
  end

  def complete?
    linear_fraction == 1_f32
  end

  def update(delta_time)
    @time_spent += delta_time
  end
end
