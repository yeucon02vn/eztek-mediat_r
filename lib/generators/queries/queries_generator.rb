class QueriesGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    argument :model, type: :string
    argument :name, type: :string
    class_option :validator, type: :boolean, default: true, desc: "Generate validator."
    class_option :doc, type: :boolean, default: true, desc: "Include documentation."

    def generate_init
        generate_query
        generate_query_handler
    end

    def generate_validator
        generate_query_validator if options.validator?
    end

    private

    def generate_query
        template 'queries_template.template', "app/cqrs/#{model.underscore}/queries/#{name.underscore}_query.rb"
    end

    def generate_query_validator
        template 'queries_validator_template.template', "app/cqrs/#{model.underscore}/queries/validators/#{name.underscore}_query_validator.rb"
    end

    def generate_query_handler
        template 'queries_handler_template.template', "app/cqrs/#{model.underscore}/queries/handlers/#{name.underscore}_query_handler.rb"
    end
end
