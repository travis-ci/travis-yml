# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Php < Type::Lang
          register :php

          def define
            title 'PHP'
            summary 'PHP language support'
            see 'Building a PHP Project': 'https://docs.travis-ci.com/user/languages/php/'
            matrix :php
            map :composer_args, to: :str
          end
        end
      end
    end
  end
end
