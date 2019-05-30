# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Haxe < Type::Lang
          register :haxe

          def define
            matrix :haxe
            map :hxml, to: :seq
            map :neko, to: :str
          end
        end
      end
    end
  end
end
