require 'spec_helper'
require 'ez/mediat_r'

module EZ
  RSpec.describe CommandBus do
    ::FooCommand = Class.new

    specify do
      bus = MediatR.new
      command_handler =
        double(:handler, call: nil)
      bus.register(::FooCommand, command_handler)
      bus.(command = ::FooCommand.new)

      expect(command_handler)
        .to(have_received(:call).with(command))
    end

    specify 'no handler' do
      bus = MediatR.new
      expect{ bus.(command = ::FooCommand.new) }
        .to(raise_error(MediatR::UnregisteredHandler) { |err|
          expect(err.message)
            .to(eq('Missing handler for FooCommand')) })
    end

    specify 'one command, one handler' do
      bus = MediatR.new
      bus.register(::FooCommand, ->{})
      expect{bus.register(::FooCommand, ->{})}
        .to(raise_error(MediatR::MultipleHandlers) { |err|
          expect(err.message)
            .to(eq('Not allowed multiple handlers for FooCommand')) })
    end
  end
end