require "spec2"
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

Spec2.describe Glove::Space do
  let(space) { Glove::Space.new }
  subject { space }

  context "new space" do
    it "is empty" do
      expect(subject.entities.size).to eq(0)
      expect(subject.actions.size).to eq(0)
      expect(subject.systems.size).to eq(0)
    end
  end

  describe "#update" do
    subject { space.update(0.123, app) }

    let(app) { GloveSpaceSpecTestApp.new(800, 600, "hello world") }

    context "one entity" do
      before { space.entities << entity }

      let(entity) do
        Glove::Entity.new.tap do |e|
          e << GloveSpaceSpecTestComponent.new
        end
      end

      it "updates" do
        expect(entity[GloveSpaceSpecTestComponent].updated).to eq(false)
        subject
        expect(entity[GloveSpaceSpecTestComponent].updated).to eq(true)
      end

      context "child entity" do
        before { entity.children << child_entity }

        let(child_entity) do
          Glove::Entity.new.tap do |e|
            e << GloveSpaceSpecTestComponent.new
          end
        end

        it "updates" do
          expect(entity[GloveSpaceSpecTestComponent].updated).to eq(false)
          expect(child_entity[GloveSpaceSpecTestComponent].updated).to eq(false)
          subject
          expect(entity[GloveSpaceSpecTestComponent].updated).to eq(true)
          expect(child_entity[GloveSpaceSpecTestComponent].updated).to eq(true)
        end
      end
    end
  end
end
