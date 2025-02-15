# frozen_string_literal: true
require 'travis/yml/schema/def/lang/jdks'

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
            matrix :jdk, to: :jdks
            
            map :composer_args, to: :str
          end
        end
      end
    end
  end
end
