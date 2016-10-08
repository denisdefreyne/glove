# QUESTION:
# Can a component define its own event handlers?
# Can a ButtonComponent (or ButtonBehavior) work?
# ButtonComponent needs
# - CursorTrackingComponent (to check whether cursor is inside)
# - EventHandlers::MouseButton (to get mouse up/down events)

class Glove::Entity
  property :mouse_event_handler
  property :keyboard_event_handler
  property? :dead
  getter :children

  @mouse_event_handler : Glove::EventHandler? # FIXME
  @keyboard_event_handler : Glove::EventHandler? # FIXME

  def initialize
    @components_by_name = {} of Symbol => Glove::Component
    @children = [] of Glove::Entity
    @z = 0.0_f32
    @dead = false
  end

  def components
    @components_by_name.values
  end

  def <<(component)
    @components_by_name[component.class.sym] = component
  end

  def [](key)
    @components_by_name[key]
  end

  def []?(key)
    @components_by_name[key]?
  end

  def delete_component(sym : Symbol)
    @components_by_name.delete(sym)
  end

  def update(delta_time, space, app)
    components.each &.update(self, delta_time, space, app)
  end
end
