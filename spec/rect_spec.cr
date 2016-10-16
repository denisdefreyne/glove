require "spec2"
require "../src/glove"

Spec2.describe Glove::Rect do
  subject { Glove::Rect.new(origin, size) }

  let(origin) { Glove::Point.new(origin_x, origin_y) }
  let(size) { Glove::Size.new(width, height) }

  let(origin_x) { 100_f32 }
  let(origin_y) { 200_f32 }
  let(width) { 300_f32 }
  let(height) { 400_f32 }

  it "has correct derived attributes" do
    expect(subject.width).to eq(300)
    expect(subject.height).to eq(400)
    expect(subject.left).to eq(100)
    expect(subject.right).to eq(100 + 300)
    expect(subject.top).to eq(200 + 400)
    expect(subject.bottom).to eq(200)
  end

  describe "#grow" do
    subject { super.grow(1_f32) }

    it "grows properly" do
      expect(subject.left).to eq(99)
      expect(subject.right).to eq(401)
      expect(subject.top).to eq(601)
      expect(subject.bottom).to eq(199)
    end
  end

  describe "#grow_y" do
    subject { super.grow_y(1_f32) }

    it "keeps left/right unchanged" do
      expect(subject.left).to eq(100)
      expect(subject.right).to eq(400)
    end

    it "grows properly" do
      expect(subject.top).to eq(601)
      expect(subject.bottom).to eq(199)
    end
  end

  # TODO: #contains?
  # TODO: overlaps_with?
  # TODO: overlaps_on_bottom_with?
end
