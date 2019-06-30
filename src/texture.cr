class Glove::Texture
  getter :texture_id
  getter :width
  getter :height

  def self.from(filename : String)
    LibGL.gen_textures(1, out texture_id)

    data = LibSTBImage.load(filename, out width, out height, out comp, LibSTBImage::Channels::RGBAlpha)

    image_type =
      case comp
      when 3
        LibGL::RGB
      when 4
        LibGL::RGBA
      else
        raise "Cannot convert comp #{comp}"
      end

    gl_checked_void(LibGL.bind_texture(LibGL::TEXTURE_2D, texture_id))
    gl_checked_void(LibGL.tex_parameteri(LibGL::TEXTURE_2D, LibGL::TEXTURE_MIN_FILTER, LibGL::LINEAR))
    gl_checked_void(LibGL.tex_parameteri(LibGL::TEXTURE_2D, LibGL::TEXTURE_MAG_FILTER, LibGL::LINEAR))
    gl_checked_void(LibGL.tex_parameteri(LibGL::TEXTURE_2D, LibGL::TEXTURE_WRAP_S, LibGL::REPEAT))
    gl_checked_void(LibGL.tex_parameteri(LibGL::TEXTURE_2D, LibGL::TEXTURE_WRAP_T, LibGL::REPEAT))

    gl_checked_void(LibGL.tex_image_2d(
      LibGL::TEXTURE_2D,
      0,
      image_type,
      width,
      height,
      0,
      image_type,
      LibGL::UNSIGNED_BYTE,
      data.as(Void*)))

    LibSTBImage.image_free(data)
    gl_checked_void(LibGL.bind_texture(LibGL::TEXTURE_2D, 0))

    new(texture_id, width, height)
  end

  def initialize(@texture_id : UInt32, @width : Int32, @height : Int32)
  end
end
