# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Smalltalk < Lang
          register :smalltalk

          def define
            matrix :smalltalk
            matrix :smalltalk_config, to: :seq
            matrix :smalltalk_vm,     to: :seq

            map :smalltalk_edge, to: Edge
          end

          # not mentioned in the docs
          class Edge < Dsl::Map
            def define
              map :source, to: :str
              map :branch, to: :str
            end
          end
        end
      end
    end
  end
end
