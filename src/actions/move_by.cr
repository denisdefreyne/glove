class Glove::Actions::MoveBy < Glove::IntervalAction
  def initialize(@entity : Glove::Entity, dx : Float32, dy : Float32, duration : Float32)
    super(duration)
    @tween = Glove::Tween.new(duration)

    @dx = dx
    @dy = dy

    @x = 1.0_f32
    @y = 1.0_f32
    @new_x = 1.0_f32
    @new_y = 1.0_f32
  end

  def start
    if transform = @entity[Glove::Components::Transform]?
      @x = transform.translate_x
      @y = transform.translate_y
      @new_x = @x + @dx
      @new_y = @y + @dy
    end
  end

  def update(delta_time)
    @tween.update(delta_time)
    return if @tween.complete?

    if transform = @entity[Glove::Components::Transform]?
      f = @tween.fraction
      transform.translate_x = f * @new_x + (1_f32 - f) * @x
      transform.translate_y = f * @new_y + (1_f32 - f) * @y
    end
  end
end
