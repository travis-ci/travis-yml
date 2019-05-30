# frozen_string_literal: true
require 'travis/yml/schema/def/lang/jdks'

module Travis
  module Yml
    module Schema
      module Def
        class Clojure < Type::Lang
          register :clojure

          def define
            matrix :jdk, to: :jdks
            map :lein, to: :str
          end
        end
      end
    end
  end
end
