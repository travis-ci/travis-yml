# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        class Git < Dsl::Map
          register :git

          def define
            map :strategy,         to: :enum, values: [:clone, :tarball]
            map :quiet,            to: :bool
            map :depth,            to: :num #, default: 50
            map :submodules,       to: :bool
            map :submodules_depth, to: :num

            export
          end
        end
      end
    end
  end
end
