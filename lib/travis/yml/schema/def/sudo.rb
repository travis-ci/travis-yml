# frozen_string_literal: true
require 'travis/yml/schema/dsl/any'

module Travis
  module Yml
    module Schema
      module Def
        class Sudo < Dsl::Any
          register :sudo

          def define
            summary 'Whether to allow sudo access'
            add :bool, normal: true
            add :str
            export
            deprecated 'this key has no effect anymore'
          end
        end
      end
    end
  end
end
