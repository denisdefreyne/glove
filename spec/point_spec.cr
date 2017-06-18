require "spec2"
require "../src/glove"

Spec2.describe Glove::Point do
  subject { Glove::Point.new(x, y) }

  let(x) { 100_f32 }
  let(y) { 200_f32 }

  describe "#+ - add" do
    subject { super + other }

    let(other_dx) { 10_f32 }
    let(other_dy) { 20_f32 }

    let(other) { Glove::Vector.new(other_dx, other_dy) }

    it "adds" do
      expect(subject.x).to eq(110)
      expect(subject.y).to eq(220)
    end
  end

  describe "#- - subtract point" do
    subject { super - other }

    let(other_x) { 10_f32 }
    let(other_y) { 20_f32 }

    let(other) { Glove::Point.new(other_x, other_y) }

    it "subtracts" do
      expect(subject.dx).to eq(90)
      expect(subject.dy).to eq(180)
    end
  end

  describe "#- - subtract vector" do
    subject { super - other }

    let(other_dx) { 10_f32 }
    let(other_dy) { 20_f32 }

    let(other) { Glove::Vector.new(other_dx, other_dy) }

    it "subtracts" do
      expect(subject.x).to eq(90)
      expect(subject.y).to eq(180)
    end
  end
end
