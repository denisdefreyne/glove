class Glove::Renderer
  NULL_TRANSFORM = Glove::GLM::Mat4.identity

  @shader_program : Glove::ShaderProgram

  def initialize(@width : Int32, @height : Int32)
    vertex_shader = {{ read_file("#{__DIR__}/shaders/vertex_shader.glsl") }}
    fragment_shader = {{ read_file("#{__DIR__}/shaders/fragment_shader.glsl") }}
    @shader_program = ShaderProgram.from(vertex_shader, fragment_shader)
  end

  def self.generic_quad
    @@_generic_quad ||= Glove::Quad.new
  end

  private def projection_matrix(entities : Glove::EntityCollection, camera : Glove::Entity?)
    projection_matrix = Glove::GLM::Mat4.identity
      .translate!(-1.0_f32, -1.0_f32)
      .scale!(2.0_f32/@width, 2.0_f32/@height)

    if camera
      if transform = camera[Glove::Components::Transform]?
        projection_matrix.translate!(@width/2_f32, @height/2_f32)
          .scale!(transform.scale_x, transform.scale_y)
          .rotate_z!(transform.angle)
          .translate!(-transform.translate_x, -transform.translate_y)
      end
    end

    projection_matrix
  end

  def render(entities : Glove::EntityCollection)
    camera = camera_or_nil(entities)

    @shader_program.use
    gl_checked(@shader_program.set_uniform_matrix_4f("projection", false, projection_matrix(entities, camera)))

    sorted_entities = entities.unwrap.sort_by { |e| - z_for(e) }
    sorted_entities.each { |e| render(e, camera) }
  end

  private def render(entity : Glove::Entity, camera : Glove::Entity?)
    matrix = transform_matrix_for(entity, camera)
    render(entity, matrix, camera)
  end

  private def render(entity : Glove::Entity, matrix : Glove::GLM::Mat4, camera : Glove::Entity?)
    gl_checked(@shader_program.set_uniform_matrix_4f("model", false, matrix))

    texture_id = texture_id_for(entity)
    color = color_for(entity)

    if texture_id > 0
      gl_checked(@shader_program.set_uniform_1i("textured", 1))
      gl_checked(@shader_program.set_uniform_4f("spriteColor", 1.0, 1.0, 1.0, 1.0))
      gl_checked_void(LibGL.bind_texture(LibGL::TEXTURE_2D, texture_id))
    else
      gl_checked(@shader_program.set_uniform_1i("textured", 0))
    end

    if color
      gl_checked(@shader_program.set_uniform_4f("spriteColor", color.r, color.g, color.b, color.a))
    else
      gl_checked(@shader_program.set_uniform_4f("spriteColor", 1.0, 1.0, 1.0, 1.0))
    end

    is_renderable = texture_id > 0 || color

    if is_renderable
      gl_checked(@shader_program.set_uniform_1f("z", z_for(entity)))

      quad = quad_for(entity)
      gl_checked_void(LibGL.bind_vertex_array(quad.vertex_array_id))
      gl_checked_void(LibGL.draw_arrays(LibGL::TRIANGLE_STRIP, 0, quad.vertices.size))
      gl_checked_void(LibGL.bind_vertex_array(0))
    end

    parent_matrix = transform_matrix_as_parent(entity)
    entity.children.each do |child_entity|
      child_matrix = transform_matrix_for(child_entity, camera)
      render(child_entity, parent_matrix * child_matrix, camera)
    end
  end

  private def transform_matrix_for(entity : Glove::Entity, camera : Glove::Entity?)
    if transform = entity[Glove::Components::Transform]?
      if camera
        parallax_component = entity[Glove::Components::Parallax]?
        camera_transform = camera[Glove::Components::Transform]?
        if parallax_component && camera_transform
          pf = parallax_component.factor
          dx = camera_transform.translate_x + parallax_component.offset_x
          dy = camera_transform.translate_y + parallax_component.offset_y
          transform.dup.tap do |t|
            t.translate_x = t.translate_x * pf + dx * (1.0 - pf)
            t.translate_y = t.translate_y * pf + dy * (1.0 - pf)
          end.matrix
        else
          transform.matrix
        end
      else
        transform.matrix
      end
    else
      NULL_TRANSFORM
    end
  end

  private def transform_matrix_as_parent(entity : Glove::Entity)
    if transform = entity[Glove::Components::Transform]?
      transform.matrix_for_child
    else
      NULL_TRANSFORM
    end
  end

  private def texture_id_for(entity : Glove::Entity)
    if texture_component = entity[Glove::Components::Texture]?
      texture_component.texture.texture_id
    else
      0
    end
  end

  private def quad_for(entity : Glove::Entity)
    if texture_component = entity[Glove::Components::Texture]?
      texture_component.quad
    else
      self.class.generic_quad
    end
  end

  private def color_for(entity : Glove::Entity)
    if color_component = entity[Glove::Components::Color]?
      color_component.color
    else
      nil
    end
  end

  private def parallax_for(entity : Glove::Entity)
    if parallax_component = entity[Glove::Components::Parallax]?
      parallax_component.factor
    else
      1.0
    end
  end

  private def camera_or_nil(entities : Glove::EntityCollection)
    cameras = entities.all_with_component(Glove::Components::Camera)
    cameras[0]?
  end

  private def z_for(entity : Glove::Entity)
    if z_component = entity[Glove::Components::Z]?
      - z_component.z / 100.0_f32
    else
      0.0
    end
  end
end
