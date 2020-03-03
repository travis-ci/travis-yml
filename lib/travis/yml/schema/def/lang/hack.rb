# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Hack < Type::Lang
          register :hack

          def define
            title 'Hack'
            summary 'Hack support'
            # see 'Building a Hack Project': 'https://docs.travis-ci.com/user/languages/hack/'
            matrix :hhvm
            matrix :php
          end
        end
      end
    end
  end
end
