require "spec2"
require "../src/glove"

Spec2.describe Glove::Tween do
  subject { Glove::Tween.new(duration, kind) }

  let(duration) { 1.2_f32 }
  let(kind) { Glove::Tween::Kind::Linear }

  context "at start" do
    it "has progress 0%" do
      expect(subject.fraction.to_f64).to be_close(0.0, 0.001)
      expect(subject.linear_fraction.to_f64).to be_close(0.0, 0.001)
      expect(subject.complete?).to eq(false)
    end
  end

  context "25% through" do
    before do
      subject.update(0.3_f32)
    end

    it "has progress 25%" do
      expect(subject.linear_fraction.to_f64).to be_close(0.25, 0.001)
      expect(subject.complete?).to eq(false)
    end

    context "linear" do
      let(kind) { Glove::Tween::Kind::Linear }
      it "" { expect(subject.fraction.to_f64).to be_close(0.25, 0.001) }
    end

    context "ease in" do
      let(kind) { Glove::Tween::Kind::EaseIn }
      it "" { expect(subject.fraction.to_f64).to be_close(0.015625, 0.001) }
    end

    context "ease out" do
      let(kind) { Glove::Tween::Kind::EaseOut }
      it "" { expect(subject.fraction.to_f64).to be_close(0.578125, 0.001) }
    end

    context "ease in out" do
      let(kind) { Glove::Tween::Kind::EaseInOut }
      it "" { expect(subject.fraction.to_f64).to be_close(0.0625, 0.001) }
    end
  end

  context "halfway" do
    before do
      subject.update(0.6_f32)
    end

    it "has progress 50%" do
      expect(subject.linear_fraction.to_f64).to be_close(0.5, 0.001)
      expect(subject.complete?).to eq(false)
    end

    context "linear" do
      let(kind) { Glove::Tween::Kind::Linear }
      it "" { expect(subject.fraction.to_f64).to be_close(0.5, 0.001) }
    end

    context "ease in" do
      let(kind) { Glove::Tween::Kind::EaseIn }
      it "" { expect(subject.fraction.to_f64).to be_close(0.125, 0.001) }
    end

    context "ease out" do
      let(kind) { Glove::Tween::Kind::EaseOut }
      it "" { expect(subject.fraction.to_f64).to be_close(0.875, 0.001) }
    end

    context "ease in out" do
      let(kind) { Glove::Tween::Kind::EaseInOut }
      it "" { expect(subject.fraction.to_f64).to be_close(0.5, 0.001) }
    end
  end

  context "75% through" do
    before do
      subject.update(0.9_f32)
    end

    it "has progress 75%" do
      expect(subject.linear_fraction.to_f64).to be_close(0.75, 0.001)
      expect(subject.complete?).to eq(false)
    end

    context "linear" do
      let(kind) { Glove::Tween::Kind::Linear }
      it "" { expect(subject.fraction.to_f64).to be_close(0.75, 0.001) }
    end

    context "ease in" do
      let(kind) { Glove::Tween::Kind::EaseIn }
      it "" { expect(subject.fraction.to_f64).to be_close(0.421875, 0.001) }
    end

    context "ease out" do
      let(kind) { Glove::Tween::Kind::EaseOut }
      it "" { expect(subject.fraction.to_f64).to be_close(0.984375, 0.001) }
    end

    context "ease in out" do
      let(kind) { Glove::Tween::Kind::EaseInOut }
      it "" { expect(subject.fraction.to_f64).to be_close(0.9375, 0.001) }
    end
  end

  context "at end" do
    before do
      subject.update(1.2_f32)
    end

    it "has progress 100%" do
      expect(subject.fraction).to eq(1.0)
      expect(subject.linear_fraction).to eq(1.0)
      expect(subject.complete?).to eq(true)
    end
  end

  context "past end" do
    before do
      subject.update(1.3_f32)
    end

    it "has progress 100%" do
      expect(subject.fraction).to eq(1.0)
      expect(subject.linear_fraction).to eq(1.0)
      expect(subject.complete?).to eq(true)
    end
  end
end
