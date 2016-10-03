class Glove::Components::Transform < Glove::Component
  property :width
  property :height
  property :translate_x
  property :translate_y
  property :angle
  property :scale_x
  property :scale_y
  property :anchor_x
  property :anchor_y

  @model_matrix : Glove::GLM::TMat4(Float32)

  def initialize
    @width = 0_f32
    @height = 0_f32
    @translate_x = 0_f32
    @translate_y = 0_f32
    @angle = 0.0_f32
    @scale_x = 1_f32
    @scale_y = 1_f32
    @anchor_x = 0.5_f32
    @anchor_y = 0.5_f32

    @model_matrix = Glove::GLM::Mat4.identity
  end

  def matrix
    Glove::GLM.identity(@model_matrix)
    Glove::GLM.translate(@model_matrix, @translate_x, @translate_y)
    Glove::GLM.rotate_z(@model_matrix, @angle)
    Glove::GLM.scale(@model_matrix, @width * @scale_x, @height * @scale_y)
    Glove::GLM.translate(@model_matrix, -@anchor_x, -@anchor_y)

    @model_matrix
  end

  def bounds
    actual_scale_x = @width * @scale_x
    actual_scale_y = @height * @scale_y

    angle = @angle
    cos = Math.cos(angle)
    sin = Math.sin(angle)
    dxs = [
      actual_scale_x / 2 * cos - actual_scale_y / 2 * sin,
      actual_scale_x / 2 * cos + actual_scale_y / 2 * sin,
      -actual_scale_x / 2 * cos - actual_scale_y / 2 * sin,
      -actual_scale_x / 2 * cos + actual_scale_y / 2 * sin,
    ]
    dys = [
      actual_scale_x / 2 * sin - actual_scale_y / 2 * cos,
      actual_scale_x / 2 * sin + actual_scale_y / 2 * cos,
      -actual_scale_x / 2 * sin - actual_scale_y / 2 * cos,
      -actual_scale_x / 2 * sin + actual_scale_y / 2 * cos,
    ]

    left = @translate_x + dxs.min
    right = @translate_x + dxs.max

    top = @translate_y + dys.max
    bottom = @translate_y + dys.min

    origin = Glove::Point.new(left.to_f32, bottom.to_f32)
    size = Glove::Size.new((right - left).to_f32, (top - bottom).to_f32)
    Glove::Rect.new(origin, size)
  end
end
