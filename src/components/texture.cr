class Glove::Components::Texture < Glove::Component
  @texture : Glove::Texture?

  getter :width
  getter :height
  getter :offset_x
  getter :offset_y

  def initialize(@path : String, @width : Float32 = 1f32, @height : Float32 = 1f32, @offset_x : Float32 = 0f32, @offset_y : Float32 = 0f32)
    @texture = nil
  end

  def texture
    @texture ||= Glove::AssetManager.instance.texture_from(@path)
  end

  def quad
    if @width == 1f32 && @height == 1f32 && @offset_x == 1f32 && @offset_y == 1f32
      Glove::Renderer.generic_quad
    else
      Glove::Quad.new(1f32, 1f32, @width, @height, @offset_x, @offset_y)
    end
  end

  def path=(path : String)
    @path = path
    @texture = nil
  end
end
