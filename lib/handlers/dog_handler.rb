# frozen_string_literal: true

require 'repository/dog'

module Handlers
  class DogHandler
    def initialize(repository: default_repository)
      @repository = repository
    end

    def handle(command, repository: default_repository)

      send(:"handle_#{command.class.name.split('::').last.downcase}", command)
    end

    private

    attr_reader :repository

    def handle_sit(command)
      repository.adjust_aggregate(command.aggregate_id) do |dog|
        dog.sit
      end
    end

    def default_repository
      Repository::Dog.new(subscribers: [])
    end
  end
end
