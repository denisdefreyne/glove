require "spec"
require "../src/glove"

describe Glove::Components::Transform do
  describe "#initialize" do
    it "sets reasonable defaults" do
      transform = Glove::Components::Transform.new

      transform.width.should eq(0)
      transform.height.should eq(0)
      transform.translate_x.should eq(0)
      transform.translate_y.should eq(0)
      transform.angle.should eq(0)
      transform.scale_x.should eq(1)
      transform.scale_y.should eq(1)
      transform.anchor_x.should eq(0.5)
      transform.anchor_y.should eq(0.5)
    end
  end

  describe "#bounds" do
    context "by default" do
      it "returns the proper bounds" do
        transform = Glove::Components::Transform.new

        transform.bounds.width.should eq(0)
        transform.bounds.height.should eq(0)

        transform.bounds.top.should eq(0)
        transform.bounds.bottom.should eq(0)

        transform.bounds.left.should eq(0)
        transform.bounds.right.should eq(0)
      end
    end

    context "with a width and height" do
      it "returns the proper bounds" do
        transform = Glove::Components::Transform.new
        transform.width = 100_f32
        transform.height = 200_f32

        transform.bounds.width.should eq(100)
        transform.bounds.height.should eq(200)

        transform.bounds.top.should eq(100)
        transform.bounds.bottom.should eq(-100)

        transform.bounds.left.should eq(-50)
        transform.bounds.right.should eq(50)
      end

      context "translated" do
        it "returns the proper bounds" do
          transform = Glove::Components::Transform.new
          transform.width = 100_f32
          transform.height = 200_f32
          transform.translate_x = 10_f32
          transform.translate_y = 20_f32

          transform.bounds.width.should eq(100)
          transform.bounds.height.should eq(200)

          transform.bounds.top.should eq(100 + 20)
          transform.bounds.bottom.should eq(-100 + 20)

          transform.bounds.left.should eq(-50 + 10)
          transform.bounds.right.should eq(50 + 10)
        end
      end

      context "rotated" do
        it "returns the proper bounds" do
          transform = Glove::Components::Transform.new
          transform.width = 100_f32
          transform.height = 200_f32
          transform.angle = 0.174533_f32 # 10 degrees

          transform.bounds.width.to_f64.should be_close(133.21, 0.01)
          transform.bounds.height.to_f64.should be_close(214.326, 0.01)

          transform.bounds.top.to_f64.should be_close(214.326 / 2, 0.01)
          transform.bounds.bottom.to_f64.should be_close(- 214.326 / 2, 0.01)

          transform.bounds.left.to_f64.should be_close(- 133.21 / 2, 0.01)
          transform.bounds.right.to_f64.should be_close(133.21 / 2, 0.01)
        end

        context "translated" do
          it "returns the proper bounds" do
            transform = Glove::Components::Transform.new
            transform.width = 100_f32
            transform.height = 200_f32
            transform.angle = 0.174533_f32 # 10 degrees
            transform.translate_x = 10_f32
            transform.translate_y = 20_f32

            transform.bounds.width.to_f64.should be_close(133.21, 0.01)
            transform.bounds.height.to_f64.should be_close(214.326, 0.01)

            transform.bounds.top.to_f64.should be_close(214.326 / 2 + 20, 0.01)
            transform.bounds.bottom.to_f64.should be_close(- 214.326 / 2 + 20, 0.01)

            transform.bounds.left.to_f64.should be_close(- 133.21 / 2 + 10, 0.01)
            transform.bounds.right.to_f64.should be_close(133.21 / 2 + 10, 0.01)
          end
        end
      end

      context "scaled" do
        it "returns the proper bounds" do
          transform = Glove::Components::Transform.new
          transform.scale_x = 3.0_f32
          transform.scale_y = 0.5_f32
          transform.width = 100_f32
          transform.height = 200_f32

          transform.bounds.width.should eq(300)
          transform.bounds.height.should eq(100)

          transform.bounds.top.should eq(200 / 2 * 0.5)
          transform.bounds.bottom.should eq(-200 / 2  * 0.5)

          transform.bounds.left.should eq(- 100 / 2 * 3.0)
          transform.bounds.right.should eq(100 / 2 * 3.0)
        end

        context "translated" do
          it "returns the proper bounds" do
            transform = Glove::Components::Transform.new
            transform.translate_x = 10_f32
            transform.translate_y = 20_f32
            transform.scale_x = 3.0_f32
            transform.scale_y = 0.5_f32
            transform.width = 100_f32
            transform.height = 200_f32

            transform.bounds.width.should eq(300)
            transform.bounds.height.should eq(100)

            transform.bounds.top.should eq(200 / 2 * 0.5 + 20)
            transform.bounds.bottom.should eq(-200 / 2  * 0.5 + 20)

            transform.bounds.left.should eq(- 100 / 2 * 3.0 + 10)
            transform.bounds.right.should eq(100 / 2 * 3.0 + 10)
          end
        end

        # TODO: scaled+rotated
        # TODO: scaled+rotated+translated
      end

      context "anchored" do
        it "returns the proper bounds" do
          transform = Glove::Components::Transform.new
          transform.anchor_x = 0.25_f32
          transform.anchor_y = 1.0_f32
          transform.width = 100_f32
          transform.height = 200_f32

          transform.bounds.width.should eq(100)
          transform.bounds.height.should eq(200)

          transform.bounds.top.should eq(0)
          transform.bounds.bottom.should eq(-200)

          transform.bounds.left.should eq(-25)
          transform.bounds.right.should eq(75)
        end

        context "translated" do
          it "returns the proper bounds" do
            transform = Glove::Components::Transform.new
            transform.translate_x = 10_f32
            transform.translate_y = 20_f32
            transform.anchor_x = 0.25_f32
            transform.anchor_y = 1.0_f32
            transform.width = 100_f32
            transform.height = 200_f32

            transform.bounds.width.should eq(100)
            transform.bounds.height.should eq(200)

            transform.bounds.top.should eq(0 + 20)
            transform.bounds.bottom.should eq(-200 + 20)

            transform.bounds.left.should eq(-25 + 10)
            transform.bounds.right.should eq(75 + 10)
          end
        end

        # TODO: anchored+rotated
        # TODO: anchored+rotated+translated

        context "scaled" do
          it "returns the proper bounds" do
            transform = Glove::Components::Transform.new
            transform.scale_x = 3.0_f32
            transform.scale_y = 0.5_f32
            transform.anchor_x = 0.25_f32
            transform.anchor_y = 1.0_f32
            transform.width = 100_f32
            transform.height = 200_f32

            transform.bounds.width.should eq(300)
            transform.bounds.height.should eq(100)

            transform.bounds.top.should eq(0)
            transform.bounds.bottom.should eq(-100)

            transform.bounds.left.should eq(-25 * 3)
            transform.bounds.right.should eq(75 * 3)
          end

          context "translated" do
            it "returns the proper bounds" do
              transform = Glove::Components::Transform.new
              transform.translate_x = 10_f32
              transform.translate_y = 20_f32
              transform.anchor_x = 0.25_f32
              transform.anchor_y = 1.0_f32
              transform.scale_x = 3.0_f32
              transform.scale_y = 0.5_f32
              transform.width = 100_f32
              transform.height = 200_f32

              transform.bounds.width.should eq(300)
              transform.bounds.height.should eq(100)

              transform.bounds.top.should eq(0 + 20)
              transform.bounds.bottom.should eq(-100 + 20)

              transform.bounds.left.should eq(-25 * 3 + 10)
              transform.bounds.right.should eq(75 * 3 + 10)
            end
          end

          # TODO: anchored+scaled+rotated
          # TODO: anchored+scaled+rotated+translated
        end
      end
    end
  end
end
