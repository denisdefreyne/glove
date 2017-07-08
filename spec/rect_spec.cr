require "spec"
require "../src/glove"

describe Glove::Rect do
  it "has correct derived attributes" do
    origin_x = 100f32
    origin_y = 200f32
    origin = Glove::Point.new(origin_x, origin_y)
    width = 300f32
    height = 400f32
    size = Glove::Size.new(width, height)
    rect = Glove::Rect.new(origin, size)

    rect.width.should eq(300)
    rect.height.should eq(400)
    rect.left.should eq(100)
    rect.right.should eq(100 + 300)
    rect.top.should eq(200 + 400)
    rect.bottom.should eq(200)
  end

  describe "#grow" do
    it "grows properly" do
      origin_x = 100f32
      origin_y = 200f32
      origin = Glove::Point.new(origin_x, origin_y)
      width = 300f32
      height = 400f32
      size = Glove::Size.new(width, height)
      rect = Glove::Rect.new(origin, size)

      rect = rect.grow(1f32)

      rect.left.should eq(99)
      rect.right.should eq(401)
      rect.top.should eq(601)
      rect.bottom.should eq(199)
    end
  end

  describe "#grow_y" do
    it "grows Y, but keeps left/right unchanged" do
      origin_x = 100f32
      origin_y = 200f32
      origin = Glove::Point.new(origin_x, origin_y)
      width = 300f32
      height = 400f32
      size = Glove::Size.new(width, height)
      rect = Glove::Rect.new(origin, size)

      rect = rect.grow_y(1f32)

      rect.left.should eq(100)
      rect.right.should eq(400)
      rect.top.should eq(601)
      rect.bottom.should eq(199)
    end
  end

  # TODO: #contains?
  # TODO: overlaps_with?
  # TODO: overlaps_on_bottom_with?
end
