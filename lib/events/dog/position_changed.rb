# frozen_string_literal: true

module Events
  module Dog
    class PositionChanged < Value.new(:position)
      def serialize
        {
          'position' => position
        }
      end

      def self.deserialize(data)
        new(data.fetch('position'))
      end
    end
  end
end
