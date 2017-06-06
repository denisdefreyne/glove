require "../gl"

@[Link("glew")]
lib GLEW
  OK = 0

  $experimental = glewExperimental : LibGL::Boolean

  fun init = glewInit : Int32
end
