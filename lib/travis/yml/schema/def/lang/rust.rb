# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Rust < Lang
          register :rust

          def define
            matrix :rust
            super
          end
        end
      end
    end
  end
end
