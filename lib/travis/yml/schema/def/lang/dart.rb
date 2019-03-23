# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Dart < Lang
          register :dart

          def define
            matrix :dart
            map :with_content_shell, to: :bool
            super
          end
        end
      end
    end
  end
end
