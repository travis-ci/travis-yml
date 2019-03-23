# frozen_string_literal: true
require 'travis/yml/schema/dsl/any'

module Travis
  module Yml
    module Schema
      module Def
        class Sudo < Dsl::Any
          register :sudo

          def define
            add :bool, normal: true
            add :str
            export
          end
        end
      end
    end
  end
end
