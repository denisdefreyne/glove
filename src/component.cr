abstract class Glove::Component
  # abstract def self.sym

  macro inherited
    def self.sym
      :{{ @type.name.id.stringify.camelcase.gsub(/:/, "_").id }}
    end

    class ::Glove::EntityCollection
      def all_with_component(klass : {{ @type.name.id.stringify.camelcase.id }}.class)
        @entities.select { |e| e[{{ @type.name.id.stringify.camelcase.id }}]? }
      end
    end

    class ::Glove::Entity
      def [](klass : {{ @type.name.id.stringify.camelcase.id }}.class)
        %component = self[{{ @type.name.id }}.sym]
        case %component
        when {{ @type.name.id }}
          %component
        else
          raise "???"
        end
      end

      def []?(klass : {{ @type.name.id.stringify.camelcase.id }}.class)
        %component = self[{{ @type.name.id }}.sym]?
        case %component
        when nil
          nil
        when {{ @type.name.id }}
          %component
        else
          raise "???"
        end
      end
    end
  end

  def update(entity, delta_time, space, app)
  end
end

module Glove::Components
end

require "./components/camera"
require "./components/cursor_tracking"
require "./components/transform"
