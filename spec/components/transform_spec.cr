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
end
