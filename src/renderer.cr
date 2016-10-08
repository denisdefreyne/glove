class Glove::Renderer
  NULL_TRANSFORM = Glove::GLM::Mat4.identity

  @shader_program : Glove::ShaderProgram

  def initialize(@width : Int32, @height : Int32)
    @shader_program = ShaderProgram.from(
      "shaders/vertex_shader.glsl",
      "shaders/fragment_shader.glsl")

    @generic_quad = Glove::Quad.new
  end

  private def projection_matrix(entities)
    projection_matrix = Glove::GLM::Mat4.identity
    Glove::GLM.translate(projection_matrix, -1.0_f32, -1.0_f32)
    Glove::GLM.scale(projection_matrix, 2.0_f32/@width, 2.0_f32/@height)

    if cameras = entities.all_with_component(Glove::Components::Camera)
      if camera = cameras[0]?
        if transform = camera[Glove::Components::Transform]?
          Glove::GLM.translate(projection_matrix, @width/2_f32, @height/2_f32)
          Glove::GLM.scale(projection_matrix, transform.scale_x, transform.scale_y)
          Glove::GLM.rotate_z(projection_matrix, transform.angle)
          Glove::GLM.translate(projection_matrix, -transform.translate_x, -transform.translate_y)
        end
      end
    end

    projection_matrix
  end

  def render(entities : Glove::EntityCollection)
    @shader_program.use
    gl_checked(@shader_program.set_uniform_matrix_4f("projection", false, projection_matrix(entities)))

    sorted_entities = entities.unwrap.sort_by { |e| - z_for(e) }
    sorted_entities.each { |e| render(e) }
  end

  private def render(entity : Glove::Entity)
    matrix = transform_matrix_for(entity)
    render(entity, matrix)
  end

  private def render(entity : Glove::Entity, matrix : Glove::GLM::Mat4)
    gl_checked(@shader_program.set_uniform_matrix_4f("model", false, matrix))

    texture_id = texture_id_for(entity)
    color = color_for(entity)

    if texture_id > 0
      gl_checked(@shader_program.set_uniform_1i("textured", 1))
      gl_checked(@shader_program.set_uniform_4f("spriteColor", 0.0, 1.0, 0.5, 0.5))
      gl_checked(LibGL.bind_texture(LibGL::TEXTURE_2D, texture_id))
    elsif color
      gl_checked(@shader_program.set_uniform_1i("textured", 0))
      gl_checked(@shader_program.set_uniform_4f("spriteColor", color.r, color.g, color.b, color.a))
    end
    is_renderable = texture_id > 0 || color

    if is_renderable
      gl_checked(@shader_program.set_uniform_1f("z", z_for(entity)))

      gl_checked(LibGL.bind_vertex_array(@generic_quad.vertex_array_id))
      gl_checked(LibGL.draw_arrays(LibGL::TRIANGLES, 0, @generic_quad.vertices.size))
      gl_checked(LibGL.bind_vertex_array(0))
    end

    entity.children.each do |child_entity|
      child_matrix = transform_matrix_for(child_entity)
      render(child_entity, matrix * child_matrix)
    end
  end

  private def transform_matrix_for(entity : Glove::Entity)
    if transform = entity[Glove::Components::Transform]?
      transform.matrix
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

  private def color_for(entity : Glove::Entity)
    if color_component = entity[Glove::Components::Color]?
      color_component.color
    else
      nil
    end
  end

  private def z_for(entity : Glove::Entity)
    if z_component = entity[Glove::Components::Z]?
      - z_component.z / 100.0_f32
    else
      0.0
    end
  end
end
