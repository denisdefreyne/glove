class Glove::Quad
  getter :vertex_array_id
  getter :vertices

  @vertex_array_id : UInt32

  def initialize
    initialize(1_f32, 1_f32)
  end

  def initialize(width : Float32, height : Float32, texture_width : Float32 = 1f32, texture_height : Float32 = 1f32)
    @vertices =
      [
        0_f32, 0_f32,       0_f32,         texture_height,
        0_f32, height,      0_f32,         0_f32,
        width, 0_f32,       texture_width, texture_height,
        width, height,      texture_width, 0_f32,
      ]

    LibGL.gen_buffers(1, out vertex_buffer)
    LibGL.gen_vertex_arrays(1, out my_vertex_array_id)

    # VAO
    gl_checked(LibGL.bind_vertex_array(my_vertex_array_id))

    # VBO
    LibGL.bind_buffer(LibGL::ARRAY_BUFFER, vertex_buffer)
    LibGL.buffer_data(
      LibGL::ARRAY_BUFFER,
      @vertices.size * sizeof(Float32),
      (@vertices.to_unsafe.as(Void*)),
      LibGL::STATIC_DRAW)

    # Attributes
    LibGL.enable_vertex_attrib_array(0_u32)
    LibGL.enable_vertex_attrib_array(1_u32)
    stride = 4 * sizeof(Float32)
    offset = Pointer(Void).new(2 * sizeof(Float32))
    LibGL.vertex_attrib_pointer(0_u32, 2, LibGL::FLOAT, LibGL::FALSE, stride, nil)
    LibGL.vertex_attrib_pointer(1_u32, 2, LibGL::FLOAT, LibGL::FALSE, stride, offset)

    gl_checked(LibGL.bind_vertex_array(0))

    @vertex_array_id = my_vertex_array_id
  end
end
