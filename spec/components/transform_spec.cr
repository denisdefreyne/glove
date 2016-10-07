require "spec2"
require "../src/glove"

Spec2.describe Glove::Components::Transform do
  subject { Glove::Components::Transform.new }

  describe "#initialize" do
    it "sets reasonable defaults" do
      expect(subject.width).to eq(0)
      expect(subject.height).to eq(0)
      expect(subject.translate_x).to eq(0)
      expect(subject.translate_y).to eq(0)
      expect(subject.angle).to eq(0)
      expect(subject.scale_x).to eq(1)
      expect(subject.scale_y).to eq(1)
      expect(subject.anchor_x).to eq(0.5)
      expect(subject.anchor_y).to eq(0.5)
    end
  end

  describe "#bounds" do
    context "by default" do
      it "returns the proper bounds" do
        expect(subject.bounds.width).to eq(0)
        expect(subject.bounds.height).to eq(0)

        expect(subject.bounds.top).to eq(0)
        expect(subject.bounds.bottom).to eq(0)

        expect(subject.bounds.left).to eq(0)
        expect(subject.bounds.right).to eq(0)
      end
    end

    context "with a width and height" do
      before do
        subject.width = 100_f32
        subject.height = 200_f32
      end

      it "returns the proper bounds" do
        expect(subject.bounds.width).to eq(100)
        expect(subject.bounds.height).to eq(200)

        expect(subject.bounds.top).to eq(100)
        expect(subject.bounds.bottom).to eq(-100)

        expect(subject.bounds.left).to eq(-50)
        expect(subject.bounds.right).to eq(50)
      end

      context "translated" do
        before do
          subject.translate_x = 10_f32
          subject.translate_y = 20_f32
        end

        it "returns the proper bounds" do
          expect(subject.bounds.width).to eq(100)
          expect(subject.bounds.height).to eq(200)

          expect(subject.bounds.top).to eq(100 + 20)
          expect(subject.bounds.bottom).to eq(-100 + 20)

          expect(subject.bounds.left).to eq(-50 + 10)
          expect(subject.bounds.right).to eq(50 + 10)
        end
      end

      context "rotated" do
        before do
          subject.angle = 0.174533_f32 # 10 degrees
        end

        it "returns the proper bounds" do
          expect(subject.bounds.width.to_f64).to be_close(133.21, 0.01)
          expect(subject.bounds.height.to_f64).to be_close(214.326, 0.01)

          expect(subject.bounds.top.to_f64).to be_close(214.326 / 2, 0.01)
          expect(subject.bounds.bottom.to_f64).to be_close(- 214.326 / 2, 0.01)

          expect(subject.bounds.left.to_f64).to be_close(- 133.21 / 2, 0.01)
          expect(subject.bounds.right.to_f64).to be_close(133.21 / 2, 0.01)
        end

        context "translated" do
          before do
            subject.translate_x = 10_f32
            subject.translate_y = 20_f32
          end

          it "returns the proper bounds" do
            expect(subject.bounds.width.to_f64).to be_close(133.21, 0.01)
            expect(subject.bounds.height.to_f64).to be_close(214.326, 0.01)

            expect(subject.bounds.top.to_f64).to be_close(214.326 / 2 + 20, 0.01)
            expect(subject.bounds.bottom.to_f64).to be_close(- 214.326 / 2 + 20, 0.01)

            expect(subject.bounds.left.to_f64).to be_close(- 133.21 / 2 + 10, 0.01)
            expect(subject.bounds.right.to_f64).to be_close(133.21 / 2 + 10, 0.01)
          end
        end
      end

      context "scaled" do
        before do
          subject.scale_x = 3.0_f32
          subject.scale_y = 0.5_f32
        end

        it "returns the proper bounds" do
          expect(subject.bounds.width).to eq(300)
          expect(subject.bounds.height).to eq(100)

          expect(subject.bounds.top).to eq(200 / 2 * 0.5)
          expect(subject.bounds.bottom).to eq(-200 / 2  * 0.5)

          expect(subject.bounds.left).to eq(- 100 / 2 * 3.0)
          expect(subject.bounds.right).to eq(100 / 2 * 3.0)
        end

        context "translated" do
          before do
            subject.translate_x = 10_f32
            subject.translate_y = 20_f32
          end

          it "returns the proper bounds" do
            expect(subject.bounds.width).to eq(300)
            expect(subject.bounds.height).to eq(100)

            expect(subject.bounds.top).to eq(200 / 2 * 0.5 + 20)
            expect(subject.bounds.bottom).to eq(-200 / 2  * 0.5 + 20)

            expect(subject.bounds.left).to eq(- 100 / 2 * 3.0 + 10)
            expect(subject.bounds.right).to eq(100 / 2 * 3.0 + 10)
          end
        end

        # TODO: scaled+rotated
        # TODO: scaled+rotated+translated
      end

      context "anchored" do
        before do
          subject.anchor_x = 0.25_f32
          subject.anchor_y = 1.0_f32
        end

        it "returns the proper bounds" do
          expect(subject.bounds.width).to eq(100)
          expect(subject.bounds.height).to eq(200)

          expect(subject.bounds.top).to eq(0)
          expect(subject.bounds.bottom).to eq(-200)

          expect(subject.bounds.left).to eq(-25)
          expect(subject.bounds.right).to eq(75)
        end

        context "translated" do
          before do
            subject.translate_x = 10_f32
            subject.translate_y = 20_f32
          end

          it "returns the proper bounds" do
            expect(subject.bounds.width).to eq(100)
            expect(subject.bounds.height).to eq(200)

            expect(subject.bounds.top).to eq(0 + 20)
            expect(subject.bounds.bottom).to eq(-200 + 20)

            expect(subject.bounds.left).to eq(-25 + 10)
            expect(subject.bounds.right).to eq(75 + 10)
          end
        end

        # TODO: anchored+rotated
        # TODO: anchored+rotated+translated

        context "scaled" do
          before do
            subject.scale_x = 3.0_f32
            subject.scale_y = 0.5_f32
          end

          it "returns the proper bounds" do
            expect(subject.bounds.width).to eq(300)
            expect(subject.bounds.height).to eq(100)

            expect(subject.bounds.top).to eq(0)
            expect(subject.bounds.bottom).to eq(-100)

            expect(subject.bounds.left).to eq(-25 * 3)
            expect(subject.bounds.right).to eq(75 * 3)
          end

          context "translated" do
            before do
              subject.translate_x = 10_f32
              subject.translate_y = 20_f32
            end

            it "returns the proper bounds" do
              expect(subject.bounds.width).to eq(300)
              expect(subject.bounds.height).to eq(100)

              expect(subject.bounds.top).to eq(0 + 20)
              expect(subject.bounds.bottom).to eq(-100 + 20)

              expect(subject.bounds.left).to eq(-25 * 3 + 10)
              expect(subject.bounds.right).to eq(75 * 3 + 10)
            end
          end

          # TODO: anchored+scaled+rotated
          # TODO: anchored+scaled+rotated+translated
        end
      end
    end
  end
end
