# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Haxe < Lang
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
