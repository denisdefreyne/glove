# QUESTION:
# Can a component define its own event handlers?
# Can a ButtonComponent (or ButtonBehavior) work?
# ButtonComponent needs
# - CursorTrackingComponent (to check whether cursor is inside)
# - EventHandlers::MouseButton (to get mouse up/down events)

class Glove::Entity
  property :components
  property :mouse_event_handler
  property :keyboard_event_handler
  property? :dead
  getter :children
  property :z

  @mouse_event_handler : Glove::EventHandler? # FIXME
  @keyboard_event_handler : Glove::EventHandler? # FIXME

  def initialize
    @components = [] of Glove::Component
    @components_by_name = {} of Symbol => Glove::Component
    @children = [] of Glove::Entity
    @z = 0
    @dead = false
  end

  # TODO: remove
  def texture=(new_texture)
    if com = self[Glove::Components::Texture]?
      com.texture = new_texture
    else
      self << Glove::Components::Texture.new(new_texture)
    end
  end

  def <<(component)
    @components << component
    @components_by_name[component.class.sym] = component
  end

  def [](key)
    @components_by_name[key]
  end

  def []?(key)
    @components_by_name[key]?
  end

  def delete_component(sym : Symbol)
    @components.reject! { |c| c.class.sym == sym }
    @components_by_name.delete(sym)
  end

  def update(delta_time, space, app)
    components.each &.update(self, delta_time, space, app)
  end
end
