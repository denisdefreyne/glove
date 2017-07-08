require "spec"
require "../src/glove"

describe Glove::Vector do
  describe "#+ - add" do
    it "adds" do
      vector = Glove::Vector.new(100f32, 200f32)
      other_vector = Glove::Vector.new(10f32, 20f32)

      res = vector + other_vector
      res.dx.should eq(110)
      res.dy.should eq(220)
    end
  end

  describe "#- - subtract" do
    it "subtracts" do
      vector = Glove::Vector.new(100f32, 200f32)
      other_vector = Glove::Vector.new(10f32, 20f32)

      res = vector - other_vector
      res.dx.should eq(90)
      res.dy.should eq(180)
    end
  end

  describe "#* - scalar multiply" do
    it "multiplies" do
      vector = Glove::Vector.new(100f32, 200f32)

      res = vector * 0.1
      res.dx.should eq(10)
      res.dy.should eq(20)
    end
  end

  describe "#* - scalar divide" do
    it "divides" do
      vector = Glove::Vector.new(100f32, 200f32)

      res = vector / 10
      res.dx.should eq(10)
      res.dy.should eq(20)
    end
  end
end
