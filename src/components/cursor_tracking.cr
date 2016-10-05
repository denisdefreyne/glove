# Listens to changes in cursor position and sets inside/outside.
class Glove::Components::CursorTracking < ::Glove::Component
  getter? :inside
  property? :pressed

  def initialize
    @inside = false
    @pressed = false
  end

  def update(entity, delta_time, space, app)
    if transform = entity[Glove::Components::Transform]?
      bounds = transform.bounds
      point = Glove::Point.new(app.cursor_position.x, app.cursor_position.y)
      new_inside = bounds.contains?(point)

      if @inside != new_inside
        if event_handler = entity.mouse_event_handler
          event_handler.handle(
            new_inside ? Glove::Events::CursorEntered.new : Glove::Events::CursorExited.new,
            entity,
            space,
            app
          )
        end
      end

      @inside = new_inside
    end
  end
end
