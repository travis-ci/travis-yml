require 'travis/yml/docs/page/any'
require 'travis/yml/docs/page/deploy'
require 'travis/yml/docs/page/index'
require 'travis/yml/docs/page/lang'
require 'travis/yml/docs/page/map'
require 'travis/yml/docs/page/menu'
require 'travis/yml/docs/page/scalar'
require 'travis/yml/docs/page/seq'
require 'travis/yml/docs/page/static'
require 'travis/yml/docs/page/tree'

module Travis
  module Yml
    module Docs
      module Page
        extend self

        def build(parent, key, schema, opts = {})
          const = case schema.id
          when :language then Lang
          when :deploys  then Deploy
          else const_get(schema.class.name.split('::').last)
          end
          const.new(parent, key, schema, opts)
        end
      end
    end
  end
end
