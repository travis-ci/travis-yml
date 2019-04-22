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
            map :smalltalk_config, to: :seq
            map :smalltalk_edge,   to: :bool
          end
        end
      end
    end
  end
end
