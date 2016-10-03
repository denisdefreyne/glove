require "./lib"

macro gl_checked(call)
  value = {{call}}
  error = LibGL.get_error
  if error != LibGL::NO_ERROR
    details = "#{error} / #{GL.error_to_s(error)}"
    raise "OpenGL call failed: " + {{call.stringify}} + ": #{details}"
  end
  value
end

module GL
  def self.check_error(where="")
    if error = GL.last_error
      puts "GL error @ #{where}: 0x#{error.to_s(16)} (#{GL.last_error_message})"
    end
  end

  def self.last_error
    @@last_error = LibGL.get_error
    @@last_error = nil if @@last_error == LibGL::NO_ERROR
    @@last_error
  end

  def self.last_error_message
    error_to_s(@@last_error)
  end

  def self.error_to_s(error)
    case error
    when nil
      nil
    when LibGL::NO_ERROR
      nil
    when LibGL::INVALID_ENUM
      "INVALID_ENUM"
    when LibGL::INVALID_VALUE
      "INVALID_VALUE"
    when LibGL::INVALID_OPERATION
      "INVALID_OPERATION"
    when LibGL::STACK_OVERFLOW
      "STACK_OVERFLOW"
    when LibGL::STACK_UNDERFLOW
      "STACK_UNDERFLOW"
    when LibGL::OUT_OF_MEMORY
      "OUT_OF_MEMORY"
    else
      "UNKNOWN"
    end
  end

  def self.version
    String.new(LibGL.get_string(LibGL::VERSION))
  end

  def self.extensions
    LibGL.get_integerv(LibGL::NUM_EXTENSIONS, out n)
    extensions = [] of String
    0.upto(n - 1) do |i|
      extensions << String.new(LibGL.get_stringi(LibGL::EXTENSIONS, i.to_u32))
    end
    extensions
  end

  def self.to_boolean(value)
    if value
      LibGL::TRUE
    else
      LibGL::FALSE
    end
  end
end
