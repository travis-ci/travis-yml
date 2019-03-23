# frozen_string_literal: true
require 'travis/yml/schema/def/lang/jdks'
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Clojure < Lang
          register :clojure

          def define
            matrix :jdk, to: :jdks
            map :lein, to: :str
            super
          end
        end
      end
    end
  end
end
