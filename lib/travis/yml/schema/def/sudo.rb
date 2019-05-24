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
            example 'required'
            deprecated 'this key has no effect anymore'

            add :bool, normal: true
            add :str

            export
          end
        end
      end
    end
  end
end
