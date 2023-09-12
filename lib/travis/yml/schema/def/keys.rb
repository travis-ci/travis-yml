# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Keys < Type::Seq
          register :keys

          def define
            summary 'Custom keys to use'
            type :key
            export
          end
        end

        class Key < Type::Str
          register :key

          def define
            summary 'Custom key'
          end
        end
      end
    end
  end
end
