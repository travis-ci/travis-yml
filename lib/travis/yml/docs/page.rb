require 'travis/yml/docs/page/any'
require 'travis/yml/docs/page/index'
require 'travis/yml/docs/page/map'
require 'travis/yml/docs/page/scalar'
require 'travis/yml/docs/page/seq'

module Travis
  module Yml
    module Docs
      module Page
        extend self

        def build(schema)
          const_get(schema.class.name.split('::').last).new(schema)
        end
      end
    end
  end
end
