class Glove::EntityApp < Glove::App
  def initialize(width : Int32, height : Int32, title : String)
    super(width, height, title)

    @scene_stack = [] of Glove::Scene
    @scene_stack << Glove::Scene.new
    @renderer = Renderer.new(width, height)
  end

  def update(delta_time)
    current_scene.spaces.each &.update(delta_time, self)
  end

  def render(delta_time)
    current_scene.spaces.each { |s| @renderer.render(s.entities) }
  end

  def current_scene
    @scene_stack.last
  end

  def push_scene(scene)
    @scene_stack << scene
  end

  def pop_scene
    @scene_stack.pop
  end

  def replace_scene(scene)
    @scene_stack[-1] = scene
  end

  def cleanup
  end

  def bounds
    Rect.new(
      Point.new(0_f32, 0_f32),
      Size.new(@width.to_f32, @height.to_f32),
    )
  end

  def handle_event(event : Glove::Event)
    current_scene.spaces.each do |space|
      space.handle_event(event, self)
    end
  end
end
