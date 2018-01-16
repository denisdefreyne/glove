require "spec"
require "../../src/glove"

describe Glove::Actions::ChangeColor do
  describe "#initialize" do
    it "sets reasonable defaults" do
      start_color = Glove::Color.new(1.0_f32, 1.0_f32, 1.0_f32, 1.0_f32)
      end_color = Glove::Color.new(1.0_f32, 1.0_f32, 1.0_f32, 1.0_f32)
      tween = Glove::Tween::Kind::Linear
      duration = 1.0_f32

      entity = Glove::Entity.new.tap do |e|
        e << Glove::Components::Color.new(start_color)
      end

      action = Glove::Actions::ChangeColor.new(entity, end_color, duration, tween)
      action.should be_truthy
    end
  end

  describe "#update" do
    start_color = Glove::Color.new(1.0_f32, 1.0_f32, 1.0_f32, 1.0_f32)
    mid_color = Glove::Color.new(0.5_f32, 0.5_f32, 0.5_f32, 0.5_f32)
    end_color = Glove::Color.new(0.0_f32, 0.0_f32, 0.0_f32, 0.0_f32)
    tween = Glove::Tween::Kind::Linear
    duration = 1.0_f32

    color_component = Glove::Components::Color.new(start_color)

    entity = Glove::Entity.new.tap do |e|
      e << color_component
    end

    it "should change the entity color" do
      action = Glove::Actions::ChangeColor.new(entity, end_color, duration, tween)
      action.update(duration)

      if component = entity[Glove::Components::Color]?
        color = component.color
        color.r.should eq(end_color.r)
        color.g.should eq(end_color.g)
        color.b.should eq(end_color.b)
        color.a.should eq(end_color.a)
      else
        raise "should have a color component"
      end
    end

    it "should continue from the last state" do
      action = Glove::Actions::ChangeColor.new(entity, start_color, duration, tween)
      action.update(0.5_f32)

      if component = entity[Glove::Components::Color]?
        color = component.color
        color.r.should eq(mid_color.r)
        color.g.should eq(mid_color.g)
        color.b.should eq(mid_color.b)
        color.a.should eq(mid_color.a)
      else
        raise "should have a color component"
      end
    end
  end
end
