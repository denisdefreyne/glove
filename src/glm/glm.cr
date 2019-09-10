module Glove::GLM
  struct TMat4(T)
    @buffer : T*

    def self.zero
      TMat4(T).new { T.zero }
    end

    def self.identity
      zero.identity!
    end
    def identity!
      update! do |i|
        T.new(i % 5 != 0 ? 0 : 1)
      end
    end

    def self.new(&block : Int32 -> T)
      TMat4(T).new.update!(&block)
    end

    def update!(&block : Int32 -> T)
      0.upto(15) do |i|
        self[i] = yield i
      end
      self
    end

    def initialize(buffer : Pointer(T))
      @buffer = buffer
    end
    def initialize
      initialize Pointer(T).malloc(16)
    end

    def clone
      TMat4(T).new @buffer.clone
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

    def translate(dx : Float32, dy : Float32)
      clone.translate!(dx, dy)
    end
    def translate!(dx : Float32, dy : Float32)
      self[0, 3] = self[0, 0] * dx + self[0, 1] * dy + self[0, 3]
      self[1, 3] = self[1, 0] * dx + self[1, 1] * dy + self[1, 3]
      self[2, 3] = self[2, 0] * dx + self[2, 1] * dy + self[2, 3]
      self[3, 3] = self[3, 0] * dx + self[3, 1] * dy + self[3, 3]

      self
    end

    def scale(x : Float32, y : Float32)
      clone.scale!(x, y)
    end
    def scale!(x : Float32, y : Float32)
      self[0, 0] *= x
      self[1, 0] *= x
      self[2, 0] *= x
      self[3, 0] *= x

      self[0, 1] *= y
      self[1, 1] *= y
      self[2, 1] *= y
      self[3, 1] *= y

      self
    end

    def rotate_z(angle : Float32)
      clone.rotate_z!(angle)
    end
    def rotate_z!(angle : Float32)
      sin = Math.sin(angle)
      cos = Math.cos(angle)

      tmp_00 = self[0, 0]
      tmp_01 = self[0, 1]
      tmp_02 = self[0, 2]
      tmp_03 = self[0, 3]

      tmp_10 = self[1, 0]
      tmp_11 = self[1, 1]
      tmp_12 = self[1, 2]
      tmp_13 = self[1, 3]

      tmp_20 = self[2, 0]
      tmp_21 = self[2, 1]
      tmp_22 = self[2, 2]
      tmp_23 = self[2, 3]

      tmp_30 = self[3, 0]
      tmp_31 = self[3, 1]
      tmp_32 = self[3, 2]
      tmp_33 = self[3, 3]

      self[0, 0] = tmp_00 * cos + tmp_01 * sin
      self[1, 0] = tmp_10 * cos + tmp_11 * sin
      self[2, 0] = tmp_20 * cos + tmp_21 * sin
      self[3, 0] = tmp_30 * cos + tmp_31 * sin

      self[0, 1] = -tmp_00 * sin + tmp_01 * cos
      self[1, 1] = -tmp_10 * sin + tmp_11 * cos
      self[2, 1] = -tmp_20 * sin + tmp_21 * cos
      self[3, 1] = -tmp_30 * sin + tmp_31 * cos

      self
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
    mat.identity
  end
  def self.identity!(mat : Mat4)
    mat.identity!
  end

  def self.translate(mat : Mat4, dx : Float32, dy : Float32)
    mat.translate(dx, dy)
  end
  def self.translate!(mat : Mat4, dx : Float32, dy : Float32)
    mat.translate!(dx, dy)
  end

  def self.scale(mat : Mat4, x : Float32, y : Float32)
    mat.scale(x, y)
  end
  def self.scale!(mat : Mat4, x : Float32, y : Float32)
    mat.scale!(x, y)
  end

  def self.rotate_z(mat : Mat4, angle : Float32)
    mat.rotate_z(angle)
  end
  def self.rotate_z!(mat : Mat4, angle : Float32)
    mat.rotate_z!(angle)
  end
end
