require 'travis/yml/doc/change'
require 'travis/yml/doc/validate'
require 'travis/yml/doc/value'
require 'travis/yml/doc/schema'

module Travis
  module Yml
    module Doc
      extend self

      def build(value, opts = {})
        Value.build(nil, nil, value, opts)
      end

      def change(schema, value)
        Change.apply(schema, value)
      end

      def validate(schema, value)
        Validate.apply(schema, value)
      end
    end
  end
end
