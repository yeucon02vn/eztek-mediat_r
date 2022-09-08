raise StandardError.new('MediatR has been already defined, giving up.') if defined?(::MediatR)
::MediatR = EZ::MediatR