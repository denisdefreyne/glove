require "./glfw"
require "./glew"
require "./gl"
require "./metrics"

abstract class Glove::App
  abstract def update(delta_time)
  abstract def render(delta_time)

  def cleanup
  end

  getter :window
  getter :width
  getter :height
  getter :metrics
  getter :event_queue
  property :clear_color

  def initialize(@width : Int32, @height : Int32, @title : String)
    @clear_color = Color::BLACK
    @metrics = Glove::Metrics::Store.new
    @event_queue = Glove::EventQueue.new
    @prev_cursor_position = Point.new(0_f32, 0_f32)

    unless LibGLFW.init
      raise "LibGLFW.init failed"
    end

    error_callback = ->(error : Int32, string : UInt8*) do
      STDERR.puts "GLFW error ##{error}: #{String.new(string)}"
      exit 1
    end
    LibGLFW.set_error_callback(error_callback)

    LibGLFW.window_hint(LibGLFW::SAMPLES, 4)
    LibGLFW.window_hint(LibGLFW::CONTEXT_VERSION_MAJOR, 3)
    LibGLFW.window_hint(LibGLFW::CONTEXT_VERSION_MINOR, 3)
    LibGLFW.window_hint(LibGLFW::OPENGL_FORWARD_COMPAT, LibGL::TRUE)
    LibGLFW.window_hint(LibGLFW::OPENGL_PROFILE, LibGLFW::OPENGL_CORE_PROFILE)

    @window = LibGLFW.create_window(@width, @height, @title, nil, nil)
    LibGLFW.set_current_context(@window)

    @cursor = Glove::Cursor.new(@window, Glove::Size.new(@width.to_f32, @height.to_f32))

    key_callback = ->(window : LibGLFW::Window, key : Int32, scancode : Int32, action : Int32, mods : Int32) do
      app = LibGLFW.get_window_user_pointer(window).as(App*).value

      direction =
        case action
        when LibGLFW::PRESS
          :down
        when LibGLFW::RELEASE
          :up
        when LibGLFW::REPEAT
          :repeat
        else
          raise "Unexpected direction: #{action.inspect}"
        end

      app.event_queue << Glove::Events::Key.new(direction, key)
    end
    LibGLFW.set_key_callback(@window, key_callback)

    mouse_button_callback = ->(window : LibGLFW::Window, button : Int32, action : Int32, mods : Int32) do
      app = LibGLFW.get_window_user_pointer(window).as(App*).value

      mouse_button =
        case button
        when 1
          :middle
        when 2
          :right
        else
          :left
        end

      case action
      when LibGLFW::PRESS
        app.event_queue << Glove::Events::MousePressed.new(mouse_button)
      when LibGLFW::RELEASE
        app.event_queue << Glove::Events::MouseReleased.new(mouse_button)
      end
    end
    LibGLFW.set_mouse_button_callback(@window, mouse_button_callback)

    GLEW.experimental = LibGL::TRUE
    Glove::GL.check_error("before GLEW.init")
    unless GLEW.init == GLEW::OK
      raise "GLEW.init failed"
    end
    Glove::GL.check_error("after GLEW.init")
    puts "The previous INVALID_ENUM error (if any) can be safely ignored."

    LibGLFW.set_input_mode(@window, LibGLFW::CURSOR, LibGLFW::CURSOR_DISABLED)

    LibGL.enable(LibGL::MULTISAMPLE)
    LibGL.enable(LibGL::BLEND)
    LibGL.blend_func(LibGL::SRC_ALPHA, LibGL::ONE_MINUS_SRC_ALPHA);

    LibGL.depth_func(LibGL::LESS)
  end

  def handle_event(event : Glove::Event)
    # Discard by default
  end

  def quit
    LibGLFW.set_window_should_close(window, 1)
  end

  def cursor_position
    @cursor.to_point
  end

  def key_pressed?(key)
    LibGLFW.get_key(window, key) == LibGLFW::PRESS
  end

  def run
    self2 = self
    self_ptr = pointerof(self2).as(Void*)
    LibGLFW.set_window_user_pointer(@window, self_ptr)

    before = LibGLFW.get_time
    LibGL.clear_color(clear_color.r, clear_color.g, clear_color.b, clear_color.a)

    loop do
      sleep 0
      @metrics.inc(:glove_frames_total)
      @metrics.set(:glove_gc_collections, GC.stats.collections)

      LibGLFW.poll_events

      @event_queue.handle { |e| handle_event(e) }
      @cursor.update

      if LibGLFW.window_should_close(@window) == 1
        break
      end

      now = LibGLFW.get_time
      delta_time = now - before

      LibGL.clear(LibGL::COLOR_BUFFER_BIT | LibGL::DEPTH_BUFFER_BIT)
      update(delta_time)
      render(delta_time)
      LibGLFW.swap_buffers(@window)

      before = now
    end

    cleanup
    LibGLFW.terminate
  end
end
