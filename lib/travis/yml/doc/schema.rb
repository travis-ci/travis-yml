require 'travis/yml/doc/schema/any'
require 'travis/yml/doc/schema/bool'
require 'travis/yml/doc/schema/select'
require 'travis/yml/doc/schema/enum'
require 'travis/yml/doc/schema/factory'
require 'travis/yml/doc/schema/map'
require 'travis/yml/doc/schema/node'
require 'travis/yml/doc/schema/none'
require 'travis/yml/doc/schema/num'
require 'travis/yml/doc/schema/scalar'
require 'travis/yml/doc/schema/secure'
require 'travis/yml/doc/schema/seq'
require 'travis/yml/doc/schema/str'

module Travis
  module Yml
    module Doc
      module Schema
        extend self

        def build(schema)
          Factory.build(schema)
        end

        def detect(schema, value)
          Select.new(schema, value).apply.first
        end

        def select(schema, value)
          Select.new(schema, value).apply
        end
      end
    end
  end
end
