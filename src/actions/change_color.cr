class Glove::Actions::ChangeColor < Glove::IntervalAction
  def initialize(@entity : Glove::Entity, @new_color : Glove::Color, duration : Float32, tween_kind : Glove::Tween::Kind)
    @tween = Glove::Tween.new(duration, tween_kind)
    super(duration)
  end

  private def original_color
    @original_color ||= if color_component = @entity[Glove::Components::Color]?
      color_component.color
    else
      # FIXME: does this make sense?
      Glove::Color.new(0_f32, 0_f32, 0_f32, 0_f32)
    end
  end

  def update(delta_time)
    color_component = @entity[Glove::Components::Color]?
    return unless color_component

    return if @tween.complete?
    @tween.update(delta_time)

    color_component.color = original_color.lerp(@new_color, @tween.fraction)
  end
end
