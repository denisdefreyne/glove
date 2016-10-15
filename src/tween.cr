class Glove::Tween
  enum Kind
    Linear
    EaseIn
    EaseOut
    EaseInOut
  end

  def initialize(@duration : Float32, @kind : Kind)
    @time_spent = 0_f32
  end

  def linear_fraction
    raw_fraction = @time_spent / @duration
    raw_fraction > 1_f32 ? 1_f32 : raw_fraction
  end

  def fraction
    calc(linear_fraction, @kind)
  end

  private def calc(lf, kind : Kind)
    case kind
    when Kind::Linear
      lf
    when Kind::EaseIn
      lf * lf * lf
    when Kind::EaseOut
      1_f32 - calc(1_f32 - lf, Kind::EaseIn)
    when Kind::EaseInOut
      if lf < 0.5
        calc(lf * 2.0, Kind::EaseIn) / 2.0
      else
        1 - calc((1 - lf) * 2, Kind::EaseIn) / 2
      end
    else
      # TODO: add more types
      0_f32
    end
  end

  def complete?
    linear_fraction == 1_f32
  end

  def update(delta_time)
    @time_spent += delta_time
  end
end
