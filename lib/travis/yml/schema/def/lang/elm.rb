# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Elm < Lang
          register :elm

          def define
            matrix :elm
            map :elm_format, to: :str
            map :elm_test,   to: :str
          end
        end
      end
    end
  end
end
