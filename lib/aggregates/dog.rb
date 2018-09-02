# frozen_string_literal: true

require 'events/dog'

module Aggregates
  class Dog
    class << self
      def get(aggregate_id)
        new(aggregate_id)
        # load the aggregate events and replay history
      end
    end

    def initialize(aggregate_id)
      @id = aggregate_id
      @changes = []
    end

    def sit
      emit_event(Events::Dog::PositionChanged, position: 'sit')
    end

    def uncommitted_changes
      changes
    end

    private

    attr_reader :id, :changes

    def emit_event(event_class, data)
      changes << event_class.with(data)
    end
  end
end
