class Glove::Renderer
  NULL_TRANSFORM = Glove::GLM::Mat4.identity

  @shader_program : Glove::ShaderProgram

  def initialize(@width : Int32, @height : Int32)
    @shader_program = ShaderProgram.from(
      "shaders/vertex_shader.glsl",
      "shaders/fragment_shader.glsl")
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

    sorted_entities = entities.unwrap.sort_by { |e| e.z }
    sorted_entities.each { |e| render(e) }
  end

  private def render(entity : Glove::Entity)
    matrix = transform_matrix_for(entity)
    render(entity, matrix)
  end

  private def render(entity : Glove::Entity, matrix : Glove::GLM::Mat4)
    gl_checked(@shader_program.set_uniform_matrix_4f("model", false, matrix))

    gl_checked(LibGL.bind_texture(LibGL::TEXTURE_2D, texture_id_for(entity)))

    if polygon = entity.polygon
      gl_checked(LibGL.bind_vertex_array(polygon.vertex_array_id))
      gl_checked(LibGL.draw_arrays(LibGL::TRIANGLES, 0, polygon.vertices.size))
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
      if texture = texture_component.texture
        texture.texture_id
      else
        0
      end
    else
      0
    end
  end
end
