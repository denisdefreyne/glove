require "spec"
require "../src/glove"

describe Glove::Point do
  describe "#+ - add" do
    it "adds" do
      point = Glove::Point.new(100f32, 200f32)
      vector = Glove::Vector.new(10f32, 20f32)

      res = point + vector
      res.should be_a(Glove::Point)
      res.x.should eq(110)
      res.y.should eq(220)
    end
  end

  describe "#- - subtract point" do
    it "subtracts" do
      point = Glove::Point.new(100f32, 200f32)
      other_point = Glove::Point.new(10f32, 20f32)

      res = point - other_point
      res.should be_a(Glove::Vector)
      res.dx.should eq(90)
      res.dy.should eq(180)
    end
  end

  describe "#- - subtract vector" do
    it "subtracts" do
      point = Glove::Point.new(100f32, 200f32)
      vector = Glove::Vector.new(10f32, 20f32)

      res = point - vector
      res.should be_a(Glove::Point)
      res.x.should eq(90)
      res.y.should eq(180)
    end
  end
end
