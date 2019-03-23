# frozen_string_literal: true
require 'travis/yml/schema/dsl/str'

module Travis
  module Yml
    module Schema
      module Def
        class Version < Dsl::Str
          register :version

          VERSION = '^(~>|>|>=|=|<=|<) (\d+(?:\.\d+)?(?:\.\d+)?)$'

          def define
            format VERSION
            export
          end
        end
      end
    end
  end
end
