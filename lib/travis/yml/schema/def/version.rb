# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Version < Type::Str
          register :version

          VERSION = '^(~>|>|>=|=|<=|<) (\d+(?:\.\d+)?(?:\.\d+)?)$'

          def define
            summary 'Build config specification version'
            format VERSION
            internal
            export
          end
        end
      end
    end
  end
end
