# frozen_string_literal: true
require 'travis/yml/schema/def/lang/jdks'

module Travis
  module Yml
    module Schema
      module Def
        class Clojure < Type::Lang
          register :clojure

          def define
            title 'Clojure'
            summary 'Clojure language support'
            see 'Building a Clojure Project': 'https://docs.travis-ci.com/user/languages/clojure/'
            matrix :jdk, to: :jdks
            map :lein, to: :str
          end
        end
      end
    end
  end
end
