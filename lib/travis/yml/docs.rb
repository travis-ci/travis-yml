require 'travis/yml/docs/page'
require 'travis/yml/docs/schema'

module Travis
  module Yml
    module Docs
      extend self

      def root
        schema = Schema::Factory.build(nil, Yml.schema)
        Page.build(schema)
      end
    end
  end
end
