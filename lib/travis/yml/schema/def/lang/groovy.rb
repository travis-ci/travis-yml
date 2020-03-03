# frozen_string_literal: true
require 'travis/yml/schema/def/lang/jdks'

module Travis
  module Yml
    module Schema
      module Def
        class Groovy < Type::Lang
          register :groovy

          def define
            title 'Groovy'
            summary 'Groovy language support'
            see 'Building a Groovy Project': 'https://docs.travis-ci.com/user/languages/groovy/'
            matrix :jdk, to: :jdks
          end
        end
      end
    end
  end
end
