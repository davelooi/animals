require 'commands/dog/sit'

module Commands
  module Dog
    def self.command_class_for(command_type)
      case command_type
      when 'sit'
        Commands::Dog::Sit
      end
    end
  end
end
