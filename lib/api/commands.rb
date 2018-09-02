# frozen_string_literal: true
require 'commands'

module Api
  module Commands
    class << self
      # Given ::Commands::Dog, 'sit', uuid, {}
      # Generates a command ::Commands::Dog::Sit.with(aggregate_id: uuid)
      # Invoke the handler to handle the command
      def execute(namespace, command_type, aggregate_id, body)
        command_class = namespace.command_class_for(command_type)
        raise 'unknown command_type' if command_class.nil?

        command = command_class.deserialize(body.merge('aggregateId' => aggregate_id))
        handler = handler_for_command(command)
        handler.handle(command)
      end

      private

      def handler_for_command(command)
        case command
        when ::Commands::Dog::Sit
          ::Handlers::DogHandler.new
        else
          raise 'unknown command'
        end
      end
    end
  end
end
