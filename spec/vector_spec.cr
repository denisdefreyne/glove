require "spec2"
require "../src/glove"

Spec2.describe Glove::Vector do
  subject { Glove::Vector.new(dx, dy) }

  let(dx) { 100_f32 }
  let(dy) { 200_f32 }

  describe "#+ - add" do
    subject { super + other }

    let(other_dx) { 10_f32 }
    let(other_dy) { 20_f32 }

    let(other) { Glove::Vector.new(other_dx, other_dy) }

    it "adds" do
      expect(subject.dx).to eq(110)
      expect(subject.dy).to eq(220)
    end
  end

  describe "#- - subtract" do
    subject { super - other }

    let(other_dx) { 10_f32 }
    let(other_dy) { 20_f32 }

    let(other) { Glove::Vector.new(other_dx, other_dy) }

    it "subtracts" do
      expect(subject.dx).to eq(90)
      expect(subject.dy).to eq(180)
    end
  end

  describe "#* - scalar multiply" do
    subject { super * other }

    let(other) { 0.1 }

    it "multiplies" do
      expect(subject.dx).to eq(10)
      expect(subject.dy).to eq(20)
    end
  end

  describe "#* - scalar divide" do
    subject { super / other }

    let(other) { 10 }

    it "divides" do
      expect(subject.dx).to eq(10)
      expect(subject.dy).to eq(20)
    end
  end
end
