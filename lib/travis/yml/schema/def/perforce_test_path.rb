# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class PerforceTestPath < Type::Str
          register :perforce_test_path

          def define
            summary 'Perforce depot subpath'
            export
          end
        end
      end
    end
  end
end
