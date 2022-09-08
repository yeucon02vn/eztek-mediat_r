class CommandsGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    argument :model, type: :string
    argument :name, type: :string
    class_option :validator, type: :boolean, default: false, desc: "Generate validator."
    class_option :doc, type: :boolean, default: true, desc: "Include documentation."

    def generate_init
        generate_command
    end

    def generate_validator
        generate_validator if validator
    end

    def generate_handler
        generate_handler unless model == 'init'
    end

    private

    def generate_command
        template 'commands_template.template', "app/cqrs/#{model.underscore}/commands/#{{name.underscore}_command.rb}"
    end

    def generate_validator
        template 'commands_validator_template.template', "app/cqrs/#{model.underscore}/commands/validators/#{{name.underscore}_command_validator.rb}"
    end

    def generate_handler
        template 'commands_handler_template.template', "app/cqrs/#{model.underscore}/commands/handlers/#{{name.underscore}_command_handler.rb}"
    end
end
