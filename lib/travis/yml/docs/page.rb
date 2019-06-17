require 'travis/yml/docs/page/any'
require 'travis/yml/docs/page/index'
require 'travis/yml/docs/page/map'
require 'travis/yml/docs/page/menu'
require 'travis/yml/docs/page/scalar'
require 'travis/yml/docs/page/seq'
require 'travis/yml/docs/page/static'

module Travis
  module Yml
    module Docs
      module Page
        extend self

        def build(schema, opts = {})
          const_get(schema.class.name.split('::').last).new(schema, opts)
        end
      end
    end
  end
end
