# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'
require 'travis/yml/schema/dsl/seq'

module Travis
  module Yml
    module Schema
      module Def
        class Stages < Dsl::Seq
          register :stages

          def define
            normal
            type :stage
            export
          end
        end

        class Stage < Dsl::Map
          register :stage

          def define
            prefix :name
            map :name, to: :str
            map :if,   to: :str
            export
          end
        end
      end
    end
  end
end
