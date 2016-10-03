class Glove::Actions::ScaleTo < Glove::IntervalAction
  def initialize(@entity : Glove::Entity, @new_scale_x : Float32, @new_scale_y : Float32, duration : Float32)
    super(duration)
    @tween = Glove::Tween.new(duration)

    @scale_x = 1.0_f32
    @scale_y = 1.0_f32
  end

  def start
    if transform = @entity.transform
      @scale_x = transform.scale_x
      @scale_y = transform.scale_y
    end
  end

  def update(delta_time)
    @tween.update(delta_time)
    return if @tween.complete?

    if transform = @entity.transform
      f = @tween.fraction
      transform.scale_x = f * @new_scale_x + (1_f32 - f) * @scale_x
      transform.scale_y = f * @new_scale_y + (1_f32 - f) * @scale_y
    end
  end
end
