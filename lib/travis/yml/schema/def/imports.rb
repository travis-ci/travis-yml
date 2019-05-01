# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'
require 'travis/yml/schema/dsl/seq'

module Travis
  module Yml
    module Schema
      module Def
        class Imports < Dsl::Seq
          register :imports

          def define
            normal
            type :import
            export
          end
        end

        class Import < Dsl::Map
          register :import

          def define
            normal
            prefix :source
            map :source, to: :str
            # map :mode, to: :enum, values: ['merge', 'deep_merge']
            export
          end
        end
      end
    end
  end
end
