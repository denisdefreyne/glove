@[Link(framework: "OpenGL")] ifdef darwin
lib LibGL
  alias Enum = UInt32     # unsigned int
  alias Boolean = UInt8   # unsigned char
  alias Bitfield = UInt32 # unsigned int
  alias Byte = Int8       # signed char
  alias Short = Int16     # unsigned short
  alias Int = Int32       # int
  alias Sizei = Int32     # int
  alias Ubyte = UInt8     # unsigned char
  alias Ushort = UInt16   # unsigned short
  alias Uint = UInt32     # unsigned int
  alias Float = Float32   # float
  alias Clampf = Float32  # float

  alias Char = UInt8      # char

  alias Sizeiptr = Int32  # long

  TRUE  = 1_u8
  FALSE = 0_u8

  # ??
  MULTISAMPLE = 0x809D
  BLEND_DST = 0x0BE0
  BLEND_SRC = 0x0BE1
  BLEND     = 0x0BE2

  SRC_COLOR           = 0x0300
  ONE_MINUS_SRC_COLOR = 0x0301
  SRC_ALPHA           = 0x0302
  ONE_MINUS_SRC_ALPHA = 0x0303
  DST_ALPHA           = 0x0304
  ONE_MINUS_DST_ALPHA = 0x0305
  DST_COLOR           = 0x0306
  ONE_MINUS_DST_COLOR = 0x0307
  SRC_ALPHA_SATURATE  = 0x0308

  # DataType
  BYTE            = 0x1400_u32
  UNSIGNED_BYTE   = 0x1401_u32
  SHORT           = 0x1402_u32
  UNSIGNED_SHORT  = 0x1403_u32
  INT             = 0x1404_u32
  UNSIGNED_INT    = 0x1405_u32
  FLOAT           = 0x1406_u32
  DOUBLE          = 0x140A_u32

  # AttribMask
  DEPTH_BUFFER_BIT   = 0x00000100_u32
  STENCIL_BUFFER_BIT = 0x00000400_u32
  COLOR_BUFFER_BIT   = 0x00004000_u32

  # Alpha/Depth/Stencil Function
  NEVER    = 0x0200_u32
  LESS     = 0x0201_u32
  EQUAL    = 0x0202_u32
  LEQUAL   = 0x0203_u32
  GREATER  = 0x0204_u32
  NOTEQUAL = 0x0205_u32
  GEQUAL   = 0x0206_u32
  ALWAYS   = 0x0207_u32

  # BeginMode
  POINTS         = 0x0000_u32
  LINES          = 0x0001_u32
  LINE_LOOP      = 0x0002_u32
  LINE_STRIP     = 0x0003_u32
  TRIANGLES      = 0x0004_u32
  TRIANGLE_STRIP = 0x0005_u32
  TRIANGLE_FAN   = 0x0006_u32
  QUADS          = 0x0007_u32

  # ErrorCode
  NO_ERROR          = 0_u32
  INVALID_ENUM      = 0x0500_u32
  INVALID_VALUE     = 0x0501_u32
  INVALID_OPERATION = 0x0502_u32
  STACK_OVERFLOW    = 0x0503_u32
  STACK_UNDERFLOW   = 0x0504_u32
  OUT_OF_MEMORY     = 0x0505_u32

  # GetPName
  DEPTH_TEST = 0x0B71_u32
  TEXTURE_2D = 0x0DE1_u32

  # PixelFormat
  STENCIL_INDEX   = 0x1901_u32
  DEPTH_COMPONENT = 0x1902_u32
  RED             = 0x1903_u32
  GREEN           = 0x1904_u32
  BLUE            = 0x1905_u32
  ALPHA           = 0x1906_u32
  RGB             = 0x1907_u32
  RGBA            = 0x1908_u32

  # StringName
  VENDOR     = 0x1F00_u32
  RENDERER   = 0x1F01_u32
  VERSION    = 0x1F02_u32
  EXTENSIONS = 0x1F03_u32

  # TextureMagFilter
  NEAREST = 0x2600_i32
  LINEAR  = 0x2601_i32

  # TextureMinFilter
  NEAREST_MIPMAP_NEAREST = 0x2700_i32
  LINEAR_MIPMAP_NEAREST  = 0x2701_i32
  NEAREST_MIPMAP_LINEAR  = 0x2702_i32
  LINEAR_MIPMAP_LINEAR   = 0x2703_i32

  # TextureParameterName
  TEXTURE_MAG_FILTER = 0x2800_u32
  TEXTURE_MIN_FILTER = 0x2801_u32
  TEXTURE_WRAP_S     = 0x2802_u32
  TEXTURE_WRAP_T     = 0x2803_u32

  # TextureWrapMode
  REPEAT = 0x2901_u32

  # OpenGL 1.5
  ARRAY_BUFFER = 0x8892_u32
  STATIC_DRAW  = 0x88E4_u32

  # OpenGL 2.0
  VERTEX_SHADER   = 0x8B31_u32
  FRAGMENT_SHADER = 0x8B30_u32
  COMPILE_STATUS  = 0x8B81_u32
  LINK_STATUS     = 0x8B82_u32
  INFO_LOG_LENGTH = 0x8B84_u32

  # OpenGL 3.0
  NUM_EXTENSIONS = 0x821D_u32

  # Utility functions
  fun get_error = glGetError() : Enum

  fun get_string = glGetString(name : Enum) : Ubyte*
  fun get_stringi = glGetStringi(name : Enum, index : Uint) : Ubyte*
  fun get_integerv = glGetIntegerv(pname : Enum, params : Uint*) : Void

  # State functions
  fun clear_color = glClearColor(red : Float, green : Float, blue : Float, alpha : Float) : Void
  fun clear = glClear(mask : Bitfield) : Void
  fun enable = glEnable(cap : Enum) : Void
  fun disable = glDisable(cap : Enum) : Void
  fun depth_func = glDepthFunc(func : Enum) : Void

  # Vertex and array buffers
  fun gen_vertex_arrays = glGenVertexArrays(n : Sizei, ids : Uint*) : Void
  fun bind_vertex_array = glBindVertexArray(id : Uint) : Void

  fun blend_func = glBlendFunc(sfactor : Uint, dfactor : Uint)

  fun gen_buffers = glGenBuffers(n : Sizei, ids : Uint*) : Void
  fun bind_buffer = glBindBuffer(target : Enum, id : Uint) : Void
  fun buffer_data = glBufferData(target : Enum, size : Sizeiptr, data : Void*, usage : Enum) : Void

  fun enable_vertex_attrib_array = glEnableVertexAttribArray(index : Uint) : Void
  fun disable_vertex_attrib_array = glDisableVertexAttribArray(index : Uint) : Void
  fun vertex_attrib_pointer = glVertexAttribPointer(index : Uint, size : Int, type : Enum, normalized : Boolean, stride : Sizei, pointer : Void*) : Void
  fun draw_arrays = glDrawArrays(mode : Enum, first : Int, count : Sizei) : Void

  # Textures
  fun gen_textures = glGenTextures(n : Sizei, textures : Uint*) : Void
  fun bind_texture = glBindTexture(target : Enum, texure : Uint) : Void
  fun tex_image_2d = glTexImage2D(target : Enum, level : Int, internal_format : Uint, width : Sizei, height : Sizei, border : Int, format : Enum, type : Enum, pixels : Void*) : Void
  fun tex_parameteri = glTexParameteri(target : Enum, pname : Enum, param : Int) : Void
  fun generate_mipmap = glGenerateMipmap(target : Enum) : Void

  # Shaders and programs
  fun create_shader = glCreateShader(type : Enum) : Uint
  fun shader_source = glShaderSource(shader : Uint, count : Sizei, string : Char**, length : Int*) : Void
  fun compile_shader = glCompileShader(shader : Uint) : Void
  fun delete_shader = glDeleteShader(shader : Uint) : Void

  fun get_shader_iv = glGetShaderiv(shader : Uint, pname : Enum, params : Int*) : Void
  fun get_shader_info_log = glGetShaderInfoLog(shader : Uint, buf_size : Sizei, length : Sizei*, info_log : Char*) : Void

  fun create_program = glCreateProgram() : Uint
  fun attach_shader = glAttachShader(program : Uint, shader : Uint) : Void
  fun link_program = glLinkProgram(program : Uint) : Void

  fun get_program_iv = glGetProgramiv(program : Uint, pname : Enum, params : Int*) : Void
  fun get_program_info_log = glGetProgramInfoLog(program : Uint, buf_size : Sizei, length : Sizei*, info_log : Char*) : Void

  fun use_program = glUseProgram(program : Uint) : Void

  fun get_uniform_location = glGetUniformLocation(program : Uint, name : Char*) : Int
  fun uniform_matrix_4fv = glUniformMatrix4fv(location : Int, count : Sizei, transpose : Boolean, value : Float*) : Void
  fun uniform_1i = glUniform1i(location : Int, value : Int) : Void
  fun uniform_4f = glUniform4f(location : Int, v0 : Float, v1 : Float, v2 : Float, v3 : Float) : Void
end
