class Glove::Actions::ChangeColor < Glove::IntervalAction
  def initialize(@entity : Glove::Entity, @new_color : Glove::Color, duration : Float32)
    @tween = Glove::Tween.new(duration)

    if color_component = @entity[Glove::Components::Color]?
      @original_color = color_component.color
    else
      # FIXME: does this make sense?
      @original_color = Glove::Color.new(0_f32, 0_f32, 0_f32, 0_f32)
    end

    super(duration)
  end

  def update(delta_time)
    color_component = @entity[Glove::Components::Color]?
    return unless color_component

    return if @tween.complete?
    @tween.update(delta_time)

    color_component.color = @original_color.lerp(@new_color, @tween.fraction)
  end
end
