class Glove::Actions::RotateBy < Glove::IntervalAction
  def initialize(@entity : Glove::Entity, angle_diff : Float32, duration : Float32, tween_kind : Glove::Tween::Kind)
    super(duration)
    @tween = Glove::Tween.new(duration, tween_kind)

    @angle_diff = angle_diff

    @angle = 1.0_f32
    @new_angle = 1.0_f32
  end

  def start
    if transform = @entity[Glove::Components::Transform]?
      @angle = transform.angle
      @new_angle = @angle + @angle_diff
    end
  end

  def update(delta_time)
    @tween.update(delta_time)
    return if @tween.complete?

    if transform = @entity[Glove::Components::Transform]?
      f = @tween.fraction
      transform.angle = f * @new_angle + (1_f32 - f) * @angle
    end
  end
end
