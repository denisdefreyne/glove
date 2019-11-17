class Glove::Cursor
  @x : Float32
  @y : Float32

  def initialize(@window : Pointer(LibGLFW::Window), @window_size : Glove::Size)
    @x = @window_size.width/2
    @y = @window_size.height/2

    @old_cursor_xpos = 0_f32
    @old_cursor_ypos = 0_f32
  end

  def update
    LibGLFW.get_cursor_pos(@window, out new_cursor_xpos, out new_cursor_ypos)
    dx = @old_cursor_xpos - new_cursor_xpos
    dy = @old_cursor_ypos - new_cursor_ypos

    @old_cursor_xpos = new_cursor_xpos.to_f32
    @old_cursor_ypos = new_cursor_ypos.to_f32

    new_x = @x - dx
    new_x = 0_f32 if new_x < 0_f32
    new_x = @window_size.width if new_x > @window_size.width
    @x = new_x.to_f32

    new_y = @y + dy
    new_y = 0_f32 if new_y < 0_f32
    new_y = @window_size.height if new_y > @window_size.height
    @y = new_y.to_f32
  end

  def to_point
    Glove::Point.new(@x, @y)
  end
end
