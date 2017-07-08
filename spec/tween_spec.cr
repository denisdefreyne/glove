require "spec"
require "../src/glove"

describe Glove::Tween do
  context "at start" do
    it "has progress 0%" do
      tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::Linear)

      tween.fraction.to_f64.should be_close(0.0, 0.001)
      tween.linear_fraction.to_f64.should be_close(0.0, 0.001)
      tween.complete?.should be_false
    end
  end

  context "25% through" do
    it "has progress 25%" do
      tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::Linear)
      tween.update(0.3f32)

      tween.linear_fraction.to_f64.should be_close(0.25, 0.001)
      tween.complete?.should be_false
    end

    context "linear" do
      it "has correct fraction" do
        tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::Linear)
        tween.update(0.3f32)

        tween.fraction.to_f64.should be_close(0.25, 0.001)
      end
    end

    context "ease in" do
      it "has correct fraction" do
        tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::EaseIn)
        tween.update(0.3f32)

        tween.fraction.to_f64.should be_close(0.015625, 0.001)
      end
    end

    context "ease out" do
      it "has correct fraction" do
        tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::EaseOut)
        tween.update(0.3f32)

        tween.fraction.to_f64.should be_close(0.578125, 0.001)
      end
    end

    context "ease in out" do
      it "has correct fraction" do
        tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::EaseInOut)
        tween.update(0.3f32)

        tween.fraction.to_f64.should be_close(0.0625, 0.001)
      end
    end
  end

  context "halfway" do
    it "has progress 50%" do
      tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::Linear)
      tween.update(0.6f32)

      tween.linear_fraction.to_f64.should be_close(0.5, 0.001)
      tween.complete?.should be_false
    end

    context "linear" do
      it "has proper fraction" do
        tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::Linear)
        tween.update(0.6f32)

        tween.fraction.to_f64.should be_close(0.5, 0.001)
      end
    end

    context "ease in" do
      it "has proper fraction" do
        tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::EaseIn)
        tween.update(0.6f32)

        tween.fraction.to_f64.should be_close(0.125, 0.001)
      end
    end

    context "ease out" do
      it "has proper fraction" do
        tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::EaseOut)
        tween.update(0.6f32)

        tween.fraction.to_f64.should be_close(0.875, 0.001)
      end
    end

    context "ease in out" do
      it "has proper fraction" do
        tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::EaseInOut)
        tween.update(0.6f32)

        tween.fraction.to_f64.should be_close(0.5, 0.001)
      end
    end
  end

  context "75% through" do
    it "has progress 75%" do
      tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::Linear)
      tween.update(0.9f32)

      tween.linear_fraction.to_f64.should be_close(0.75, 0.001)
      tween.complete?.should be_false
    end

    context "linear" do
      it "has proper fraction" do
        tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::Linear)
        tween.update(0.9f32)

        tween.fraction.to_f64.should be_close(0.75, 0.001)
      end
    end

    context "ease in" do
      it "has proper fraction" do
        tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::EaseIn)
        tween.update(0.9f32)

        tween.fraction.to_f64.should be_close(0.421875, 0.001)
      end
    end

    context "ease out" do
      it "has proper fraction" do
        tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::EaseOut)
        tween.update(0.9f32)

        tween.fraction.to_f64.should be_close(0.984375, 0.001)
      end
    end

    context "ease in out" do
      it "has proper fraction" do
        tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::EaseInOut)
        tween.update(0.9f32)

        tween.fraction.to_f64.should be_close(0.9375, 0.001)
      end
    end
  end

  context "at end" do
    it "has progress 100%" do
      tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::EaseInOut)
      tween.update(1.2f32)

      tween.fraction.should eq(1.0)
      tween.linear_fraction.should eq(1.0)
      tween.complete?.should be_true
    end
  end

  context "past end" do
    it "has progress 100%" do
      tween = Glove::Tween.new(1.2f32, Glove::Tween::Kind::EaseInOut)
      tween.update(1.3f32)

      tween.fraction.should eq(1.0)
      tween.linear_fraction.should eq(1.0)
      tween.complete?.should be_true
    end
  end
end
