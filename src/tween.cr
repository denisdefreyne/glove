class Glove::Tween
  enum Kind
    Linear
    EaseIn
    EaseOut
  end

  def initialize(@duration : Float32, @kind : Kind)
    @time_spent = 0_f32
  end

  def linear_fraction
    raw_fraction = @time_spent / @duration
    raw_fraction > 1_f32 ? 1_f32 : raw_fraction
  end

  def fraction
    lf = linear_fraction

    case @kind
    when Kind::Linear
      lf
    when Kind::EaseIn
      lf * lf * lf
    when Kind::EaseOut
      lf_inv = lf - 1_f32
      lf_inv * lf_inv * lf_inv + 1_f32
    end

    # TODO: add more types
  end

  def complete?
    linear_fraction == 1_f32
  end

  def update(delta_time)
    @time_spent += delta_time
  end
end
