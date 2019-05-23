# frozen_string_literal: true
require 'travis/yml/schema/dsl/str'

module Travis
  module Yml
    module Schema
      module Def
        class Group < Dsl::Str
          register :group

          def define
            summary 'Build environment group'
            downcase
            internal
            export
          end
        end
      end
    end
  end
end

