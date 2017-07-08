require "spec"
require "../src/glove"

class GloveSpaceSpecTestComponent < ::Glove::Component
  getter :updated

  def initialize
    @updated = false
  end

  def update(entity, delta_time, space, app)
    @updated = true
  end
end

class GloveSpaceSpecTestApp < Glove::AbstractApp
  def update(delta_time)
  end

  def render(delta_time)
  end

  def quit
  end

  def initialize(@width : Int32, @height : Int32, @title : String)
  end

  def handle_event(event : Glove::Event)
  end

  def cursor_position
    Glove::Point.new(0_f32, 0_f32)
  end

  def key_pressed?(key)
    false
  end

  def run
  end
end

describe Glove::Space do
  context "new space" do
    it "is empty" do
      space = Glove::Space.new

      space.entities.size.should eq(0)
      space.actions.size.should eq(0)
      space.systems.size.should eq(0)
    end
  end

  describe "#update" do
    context "one entity" do
      it "updates" do
        space = Glove::Space.new
        app = GloveSpaceSpecTestApp.new(800, 600, "hello world")

        parent_entity =
          Glove::Entity.new.tap do |e|
            e << GloveSpaceSpecTestComponent.new
          end
        space.entities << parent_entity

        parent_entity[GloveSpaceSpecTestComponent].updated.should eq(false)
        space.update(0.123, app)
        parent_entity[GloveSpaceSpecTestComponent].updated.should eq(true)
      end

      context "child entity" do
        it "updates" do
          space = Glove::Space.new
          app = GloveSpaceSpecTestApp.new(800, 600, "hello world")

          parent_entity =
            Glove::Entity.new.tap do |e|
              e << GloveSpaceSpecTestComponent.new
            end
          child_entity =
            Glove::Entity.new.tap do |e|
              e << GloveSpaceSpecTestComponent.new
            end
          parent_entity.children << child_entity
          space.entities << parent_entity

          parent_entity[GloveSpaceSpecTestComponent].updated.should eq(false)
          child_entity[GloveSpaceSpecTestComponent].updated.should eq(false)
          space.update(0.123, app)
          parent_entity[GloveSpaceSpecTestComponent].updated.should eq(true)
          child_entity[GloveSpaceSpecTestComponent].updated.should eq(true)
        end
      end
    end
  end
end
