class Glove::Space
  getter :entities
  getter :actions
  getter :systems

  def initialize
    @entities = Glove::EntityCollection.new
    @actions = [] of Glove::Action
    @systems = [] of Glove::System
  end

  def update(delta_time, app)
    # FIXME: also update child entities
    entities.each { |e| e.update(delta_time, self, app) }
    entities.remove_dead

    systems.each { |s| s.update(delta_time, self, app) }

    actions.each { |a| a.update_wrapped(delta_time) }
    actions.reject! { |a| a.done? }
  end

  # TODO: return false if unhandled, true if it is
  def handle_event(event : Glove::Event, app : Glove::EntityApp)
    case event
    when Glove::Events::Key
      if entity = entities.find { |e| e.keyboard_event_handler }
        if keyboard_event_handler = entity.keyboard_event_handler
          keyboard_event_handler.handle(event, entity, self, app)
        end
      end
    when Glove::Events::MousePressed
      # Find entity
      entity =
        entities.find do |entity|
          if entity.mouse_event_handler.nil?
            false
          elsif transform = entity[Glove::Components::Transform]?
            transform.bounds.contains?(app.cursor_position)
          else
            false
          end
        end

      # Pass on to entity
      if entity
        if mouse_event_handler = entity.mouse_event_handler
          mouse_event_handler.handle(event, entity, self, app)
        end
      end
    when Glove::Events::MouseReleased
      entities.each do |entity|
        if mouse_event_handler = entity.mouse_event_handler
          mouse_event_handler.handle(event, entity, self, app)
        end
      end
    when Glove::Events::Scrolled
      entities.each do |entity|
        if mouse_event_handler = entity.mouse_event_handler
          mouse_event_handler.handle(event, entity, self, app)
        end
      end
    end
  end
end
