# frozen_string_literal: true

require 'aggregates/dog'

module Repository
  class Dog
    def initialize(subscribers:, logger: Logger.new(STDOUT))
      @subscribers = subscribers
      @logger = logger
    end

    def create_aggregate(id)
      dog = Aggregates::Dog.new(id)
      yield(dog)
      events = dog.uncommitted_changes
      commit_changes(id, events) # store the events
      publish(id, events) # publish event locally
    end

    def adjust_aggregate(id)
      dog = Aggregates::Dog.get(id)
      yield(dog)
      events = dog.uncommitted_changes
      commit_changes(id, events) # store the events
      publish(id, events) # publish event locally
    end

    private

    attr_reader :logger, :subscribers

    def publish(aggregate_id, events)
      logger.info "module=events action=publish aggregate_id=#{aggregate_id} events=#{events}"
      subscribers.product(events).each do |(sub, event)|
        sub.call(aggregate_id, event)
      end
    end

    def commit_changes(aggregate_id, events)
      # save to events table
      logger.info "module=events action=commit aggregate_id=#{aggregate_id} events=#{events}"
    end
  end
end
