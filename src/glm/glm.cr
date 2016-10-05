# FIXME: propose moving these into Crystal std-library
struct Float32
  def self.zero
    0_f32
  end
  def self.one
    1_f32
  end
end

struct Float64
  def self.zero
    0_f64
  end
  def self.one
    1_f64
  end
end

module Glove::GLM
  struct TMat4(T)
    @buffer : T*

    def self.zero
      TMat4(T).new { T.zero }
    end

    def self.identity
      m = zero
      m[0] = m[5] = m[10] = m[15] = T.one
      m
    end

    def self.new(&block : Int32 -> T)
      m = TMat4(T).new
      p = m.to_unsafe
      0.upto(15) { |i|
        p[i] = yield i
      }
      m
    end

    def initialize
      @buffer = Pointer(T).malloc(16)
    end

    def buffer
      @buffer
    end

    def to_unsafe
      @buffer
    end

    def [](i)
      raise IndexError.new if i < 0 || i >= 16
      @buffer[i]
    end

    def [](row, col)
      self[row + col*4]
    end

    def []=(i, value : T)
      raise IndexError.new if i < 0 || i >= 16
      @buffer[i] = value
    end

    def []=(row, col, value : T)
      self[row + col*4] = value
    end

    def *(other : Mat4)
      res = Mat4.identity

      mult = ->(res : Mat4, a : Mat4, b : Mat4, row : Int32, col : Int32) do
        a[row, 0] * b[0, col] +
        a[row, 1] * b[1, col] +
        a[row, 2] * b[2, col] +
        a[row, 3] * b[3, col]
      end

      res[0, 0] = mult.call(res, self, other, 0, 0)
      res[0, 1] = mult.call(res, self, other, 0, 1)
      res[0, 2] = mult.call(res, self, other, 0, 2)
      res[0, 3] = mult.call(res, self, other, 0, 3)

      res[1, 0] = mult.call(res, self, other, 1, 0)
      res[1, 1] = mult.call(res, self, other, 1, 1)
      res[1, 2] = mult.call(res, self, other, 1, 2)
      res[1, 3] = mult.call(res, self, other, 1, 3)

      res[2, 0] = mult.call(res, self, other, 2, 0)
      res[2, 1] = mult.call(res, self, other, 2, 1)
      res[2, 2] = mult.call(res, self, other, 2, 2)
      res[2, 3] = mult.call(res, self, other, 2, 3)

      res[3, 0] = mult.call(res, self, other, 3, 0)
      res[3, 1] = mult.call(res, self, other, 3, 1)
      res[3, 2] = mult.call(res, self, other, 3, 2)
      res[3, 3] = mult.call(res, self, other, 3, 3)

      res
    end

    def transform(x : Float32, y : Float32)
      new_x = self[0, 0] * x + self[0, 1] * y + self[0, 3]
      new_y = self[1, 0] * x + self[1, 1] * y + self[1, 3]

      {new_x, new_y}
    end

    def inspect(io)
      io << String.build do |sb|
        sb << "+------------+------------+------------+------------+\n"
        0.upto(3) do |i|
          sb << sprintf(
            "| %10.3f | %10.3f | %10.3f | %10.3f |\n",
            self[i, 0].to_f64,
            self[i, 1].to_f64,
            self[i, 2].to_f64,
            self[i, 3].to_f64)
          sb << "+------------+------------+------------+------------+\n"
        end
      end
    end
  end

  alias Mat4 = TMat4(Float32)

  def self.identity(mat : Mat4)
    mat[0, 0] = 1_f32
    mat[1, 0] = 0_f32
    mat[2, 0] = 0_f32
    mat[3, 0] = 0_f32

    mat[0, 1] = 0_f32
    mat[1, 1] = 1_f32
    mat[2, 1] = 0_f32
    mat[3, 1] = 0_f32

    mat[0, 2] = 0_f32
    mat[1, 2] = 0_f32
    mat[2, 2] = 1_f32
    mat[3, 2] = 0_f32

    mat[0, 3] = 0_f32
    mat[1, 3] = 0_f32
    mat[2, 3] = 0_f32
    mat[3, 3] = 1_f32
  end

  def self.translate(mat : Mat4, dx : Float32, dy : Float32)
    mat[0, 3] = mat[0, 0] * dx + mat[0, 1] * dy + mat[0, 3]
    mat[1, 3] = mat[1, 0] * dx + mat[1, 1] * dy + mat[1, 3]
    mat[2, 3] = mat[2, 0] * dx + mat[2, 1] * dy + mat[2, 3]
    mat[3, 3] = mat[3, 0] * dx + mat[3, 1] * dy + mat[3, 3]
  end

  def self.scale(mat : Mat4, x : Float32, y : Float32)
    mat[0, 0] *= x
    mat[1, 0] *= x
    mat[2, 0] *= x
    mat[3, 0] *= x

    mat[0, 1] *= y
    mat[1, 1] *= y
    mat[2, 1] *= y
    mat[3, 1] *= y
  end

  def self.rotate_z(mat : Mat4, angle : Float32)
    sin = Math.sin(angle)
    cos = Math.cos(angle)

    tmp_00 = mat[0, 0]
    tmp_01 = mat[0, 1]
    tmp_02 = mat[0, 2]
    tmp_03 = mat[0, 3]

    tmp_10 = mat[1, 0]
    tmp_11 = mat[1, 1]
    tmp_12 = mat[1, 2]
    tmp_13 = mat[1, 3]

    tmp_20 = mat[2, 0]
    tmp_21 = mat[2, 1]
    tmp_22 = mat[2, 2]
    tmp_23 = mat[2, 3]

    tmp_30 = mat[3, 0]
    tmp_31 = mat[3, 1]
    tmp_32 = mat[3, 2]
    tmp_33 = mat[3, 3]

    mat[0, 0] = tmp_00 * cos + tmp_01 * sin
    mat[1, 0] = tmp_10 * cos + tmp_11 * sin
    mat[2, 0] = tmp_20 * cos + tmp_21 * sin
    mat[3, 0] = tmp_30 * cos + tmp_31 * sin

    mat[0, 1] = - tmp_00 * sin + tmp_01 * cos
    mat[1, 1] = - tmp_10 * sin + tmp_11 * cos
    mat[2, 1] = - tmp_20 * sin + tmp_21 * cos
    mat[3, 1] = - tmp_30 * sin + tmp_31 * cos
  end
end
