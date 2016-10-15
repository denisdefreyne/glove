require "spec2"
require "../src/glove"

Spec2.describe Glove::Tween do
  subject { Glove::Tween.new(duration) }

  let(duration) { 1.2_f32 }

  context "at start" do
    it "has progress 0%" do
      expect(subject.fraction).to eq(0.0)
      expect(subject.linear_fraction).to eq(0.0)
      expect(subject.complete?).to eq(false)
    end
  end

  context "halfway" do
    before do
      subject.update(0.6_f32)
    end

    it "has progress 100%" do
      # TODO: depend on type
      expect(subject.fraction).to eq(0.875)
      expect(subject.linear_fraction).to eq(0.5)
      expect(subject.complete?).to eq(false)
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
