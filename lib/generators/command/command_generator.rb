class CommandGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    argument :model, type: :string
    argument :name, type: :string
    class_option :validator, type: :boolean, default: true, desc: "Generate validator."
    class_option :doc, type: :boolean, default: true, desc: "Include documentation."

    def generate_init
        generate_command
        generate_command_handler
    end

    def generate_validator
        generate_command_validator if options.validator?
    end

    private

    def generate_command
        template 'command_template.template', "app/cqrs/#{model.underscore}/commands/#{name.underscore}_command.rb"
    end

    def generate_command_validator
        template 'command_validator_template.template', "app/cqrs/#{model.underscore}/commands/validators/#{name.underscore}_command_validator.rb"
    end

    def generate_command_handler
        template 'command_handler_template.template', "app/cqrs/#{model.underscore}/commands/handlers/#{name.underscore}_command_handler.rb"
    end
end
