require 'json-schema'

module Spec
  module Support
    module Matchers
      class Validate
        include Support::Hash

        attr_reader :schema, :config, :error

        def initialize(config)
          @config = stringify(config)
        end

        def description
          ''
        end

        def matches?(schema)
          validate(schema)
          error.nil?
        end

        def failure_message
          "Expected the schema to validate the config\n\n#{config.inspect}\n\nbut it generated the error:\n\n#{error}"
        end

        def failure_message_when_negated
          "Expected the schema to not validate the config\n\n#{config.inspect}\n\nbut it did."
        end

        def validate(schema)
          JSON::Validator.validate!(stringify(schema), config)
        rescue JSON::Schema::SchemaError, JSON::Schema::ValidationError => e
          @error = e.message
        end

        def errors
          @errors ||= []
        end
      end

      def validate(schema)
        Validate.new(schema)
      end
    end
  end
end
