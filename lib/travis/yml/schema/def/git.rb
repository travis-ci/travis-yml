# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        class Git < Dsl::Map
          register :git

          def define
            summary 'Git settings'

            map :strategy,         to: :str, values: [:clone, :tarball]
            map :quiet,            to: :bool
            map :depth,            to: :any, add: [:num, :bool]
            map :submodules,       to: :bool
            map :submodules_depth, to: :num
            map :lfs_skip_smudge,  to: :bool
            map :sparse_checkout,  to: :str

            export
          end
        end
      end
    end
  end
end
