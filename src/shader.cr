class Glove::Shader
  def self.vertex(source = nil)
    shader = new(LibGL::VERTEX_SHADER)
    shader.with_source(source) if source
    shader
  end

  def self.fragment(source = nil)
    shader = new(LibGL::FRAGMENT_SHADER)
    shader.with_source(source) if source
    shader
  end

  def initialize(type : UInt32)
    @type = type
    @shader_id = LibGL.create_shader(@type)
  end

  def shader_id
    @shader_id
  end

  def with_source(source : String)
    p = source.to_unsafe
    LibGL.shader_source @shader_id, 1, pointerof(p), nil
    self
  end

  def compile
    LibGL.compile_shader @shader_id

    LibGL.get_shader_iv @shader_id, LibGL::COMPILE_STATUS, out result
    LibGL.get_shader_iv @shader_id, LibGL::INFO_LOG_LENGTH, out info_log_length
    info_log = String.new(info_log_length) do |buffer|
      LibGL.get_shader_info_log @shader_id, info_log_length, nil, buffer
      {info_log_length, info_log_length}
    end
    raise "Error compiling shader: #{info_log}" unless result

    self
  end

  def delete
    LibGL.delete_shader @shader_id
  end
end
