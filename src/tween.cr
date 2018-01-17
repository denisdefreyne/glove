class Glove::Tween
  abstract class Kind
    abstract def calc(lf)

    class Linear < Kind
      def calc(lf)
        lf
      end
    end

    class EaseIn < Kind
      def calc(lf)
        lf * lf * lf
      end
    end

    class EaseOut < Kind
      @@ease_in = EaseIn.new
      def calc(lf)
        1_f32 - @@ease_in.calc(1_f32 - lf)
      end
    end

    class EaseInOut < Kind
      @@ease_in = EaseIn.new
      def calc(lf)
        if lf < 0.5
          @@ease_in.calc(lf * 2) / 2
        else
          1 - @@ease_in.calc((1 - lf) * 2) / 2
        end
      end
    end
  end

  def initialize(duration : Float32, kind : Kind.class)
    initialize(duration, kind.new)
  end

  def initialize(@duration : Float32, @kind : Kind)
    @time_spent = 0_f32
  end

  def linear_fraction
    raw_fraction = @time_spent / @duration
    raw_fraction > 1_f32 ? 1_f32 : raw_fraction
  end

  def fraction
    @kind.calc(linear_fraction)
  end

  def complete?
    linear_fraction == 1_f32
  end

  def update(delta_time)
    @time_spent += delta_time
  end
end
