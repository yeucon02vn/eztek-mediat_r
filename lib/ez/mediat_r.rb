require 'concurrent/map'

module EZ
  class MediatR
    UnregisteredHandler = Class.new(StandardError)
    MultipleHandlers = Class.new(StandardError)

    def initialize
      @handlers = Concurrent::Map.new
    end

    def register(klass, handler)
      raise MultipleHandlers.new("Not allowed multiple handlers for #{klass}") if handlers[klass]
      handlers[klass] = handler
    end

    def execute(command)
      handler = handlers.fetch(command.class) { raise UnregisteredHandler.new("Missing handler for #{command.class}")  }
      command.valid?
      handler.execute(command)
    end

    private
    attr_reader :handlers
  end
end
