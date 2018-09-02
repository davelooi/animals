# frozen_string_literal: true
require 'values'

module Commands
  module Dog
    class Sit < Value.new(:aggregate_id)
      def self.deserialize(body)
        new(body.fetch('aggregateId'))
      end
    end
  end
end
