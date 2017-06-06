@[Link("glfw3")]
lib LibGLFW
  type Window = Void*
  type Monitor = Void*
  type ErrorCallback = (Int32, UInt8*) -> Void
  type KeyCallback = (Window, Int32, Int32, Int32, Int32) -> Void
  type MouseButtonCallback = (Window, Int32, Int32, Int32) -> Void
  type ScrollCallback = (Window, Float64, Float64) -> Void

  SAMPLES = 0x0002100D_i32

  CONTEXT_VERSION_MAJOR = 0x00022002_i32
  CONTEXT_VERSION_MINOR = 0x00022003_i32

  OPENGL_FORWARD_COMPAT = 0x00022006_i32
  OPENGL_PROFILE        = 0x00022008_i32
  OPENGL_CORE_PROFILE   = 0x00032001_i32

  CURSOR               = 0x00033001
  STICKY_KEYS          = 0x00033002
  STICKY_MOUSE_BUTTONS = 0x00033003

  CURSOR_NORMAL   = 0x00034001
  CURSOR_HIDDEN   = 0x00034002
  CURSOR_DISABLED = 0x00034003

  RELEASE = 0
  PRESS   = 1
  REPEAT  = 2

  KEY_SPACE         =  32
  KEY_APOSTROPHE    =  39
  KEY_COMMA         =  44
  KEY_MINUS         =  45
  KEY_PERIOD        =  46
  KEY_SLASH         =  47
  KEY_0             =  48
  KEY_1             =  49
  KEY_2             =  50
  KEY_3             =  51
  KEY_4             =  52
  KEY_5             =  53
  KEY_6             =  54
  KEY_7             =  55
  KEY_8             =  56
  KEY_9             =  57
  KEY_SEMICOLON     =  59
  KEY_EQUAL         =  61
  KEY_A             =  65
  KEY_B             =  66
  KEY_C             =  67
  KEY_D             =  68
  KEY_E             =  69
  KEY_F             =  70
  KEY_G             =  71
  KEY_H             =  72
  KEY_I             =  73
  KEY_J             =  74
  KEY_K             =  75
  KEY_L             =  76
  KEY_M             =  77
  KEY_N             =  78
  KEY_O             =  79
  KEY_P             =  80
  KEY_Q             =  81
  KEY_R             =  82
  KEY_S             =  83
  KEY_T             =  84
  KEY_U             =  85
  KEY_V             =  86
  KEY_W             =  87
  KEY_X             =  88
  KEY_Y             =  89
  KEY_Z             =  90
  KEY_LEFT_BRACKET  =  91
  KEY_BACKSLASH     =  92
  KEY_RIGHT_BRACKET =  93
  KEY_GRAVE_ACCENT  =  96
  KEY_WORLD_1       = 161
  KEY_WORLD_2       = 162

  KEY_ESCAPE        = 256
  KEY_ENTER         = 257
  KEY_TAB           = 258
  KEY_BACKSPACE     = 259
  KEY_INSERT        = 260
  KEY_DELETE        = 261
  KEY_RIGHT         = 262
  KEY_LEFT          = 263
  KEY_DOWN          = 264
  KEY_UP            = 265
  KEY_PAGE_UP       = 266
  KEY_PAGE_DOWN     = 267
  KEY_HOME          = 268
  KEY_END           = 269
  KEY_CAPS_LOCK     = 280
  KEY_SCROLL_LOCK   = 281
  KEY_NUM_LOCK      = 282
  KEY_PRINT_SCREEN  = 283
  KEY_PAUSE         = 284
  KEY_F1            = 290
  KEY_F2            = 291
  KEY_F3            = 292
  KEY_F4            = 293
  KEY_F5            = 294
  KEY_F6            = 295
  KEY_F7            = 296
  KEY_F8            = 297
  KEY_F9            = 298
  KEY_F10           = 299
  KEY_F11           = 300
  KEY_F12           = 301
  KEY_F13           = 302
  KEY_F14           = 303
  KEY_F15           = 304
  KEY_F16           = 305
  KEY_F17           = 306
  KEY_F18           = 307
  KEY_F19           = 308
  KEY_F20           = 309
  KEY_F21           = 310
  KEY_F22           = 311
  KEY_F23           = 312
  KEY_F24           = 313
  KEY_F25           = 314
  KEY_KP_0          = 320
  KEY_KP_1          = 321
  KEY_KP_2          = 322
  KEY_KP_3          = 323
  KEY_KP_4          = 324
  KEY_KP_5          = 325
  KEY_KP_6          = 326
  KEY_KP_7          = 327
  KEY_KP_8          = 328
  KEY_KP_9          = 329
  KEY_KP_DECIMAL    = 330
  KEY_KP_DIVIDE     = 331
  KEY_KP_MULTIPLY   = 332
  KEY_KP_SUBTRACT   = 333
  KEY_KP_ADD        = 334
  KEY_KP_ENTER      = 335
  KEY_KP_EQUAL      = 336
  KEY_LEFT_SHIFT    = 340
  KEY_LEFT_CONTROL  = 341
  KEY_LEFT_ALT      = 342
  KEY_LEFT_SUPER    = 343
  KEY_RIGHT_SHIFT   = 344
  KEY_RIGHT_CONTROL = 345
  KEY_RIGHT_ALT     = 346
  KEY_RIGHT_SUPER   = 347
  KEY_MENU          = 348
  KEY_LAST          = KEY_MENU

  fun set_error_callback = glfwSetErrorCallback(
                                                callback : ErrorCallback) : ErrorCallback
  fun set_key_callback = glfwSetKeyCallback(
                                            window : Window, callback : KeyCallback) : KeyCallback
  fun set_mouse_button_callback = glfwSetMouseButtonCallback(
                                                             window : Window, callback : MouseButtonCallback) : MouseButtonCallback
  fun set_scroll_callback = glfwSetScrollCallback(
                                                  window : Window, callback : ScrollCallback) : ScrollCallback

  fun set_window_user_pointer = glfwSetWindowUserPointer(
                                                         window : Window, pointer : Void*) : Void
  fun get_window_user_pointer = glfwGetWindowUserPointer(
                                                         window : Window) : Void*

  fun init = glfwInit : Int32
  fun window_hint = glfwWindowHint(target : Int32, hint : Int32) : Void
  fun terminate = glfwTerminate : Void

  fun create_window = glfwCreateWindow(width : Int32, height : Int32, title : UInt8*, monitor : Monitor, share : Window) : Window
  fun set_current_context = glfwMakeContextCurrent(window : Window) : Void
  fun get_current_context = glfwGetCurrentContext : Window

  fun set_input_mode = glfwSetInputMode(window : Window, mode : Int32, value : Int32) : Void
  fun swap_buffers = glfwSwapBuffers(window : Window) : Void
  fun poll_events = glfwPollEvents : Void
  fun get_key = glfwGetKey(window : Window, key : Int32) : Int32
  fun window_should_close = glfwWindowShouldClose(window : Window) : Int32
  fun set_window_should_close = glfwSetWindowShouldClose(window : Window, value : Int32) : Void

  fun get_cursor_pos = glfwGetCursorPos(window : Window, xpos : Float64*, ypos : Float64*) : Void
  fun set_cursor_pos = glfwSetCursorPos(window : Window, xpos : Float64, ypos : Float64) : Void

  fun get_time = glfwGetTime : Float64
end
