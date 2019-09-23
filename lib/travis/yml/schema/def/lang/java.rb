# frozen_string_literal: true
require 'travis/yml/schema/def/lang/jdks'

module Travis
  module Yml
    module Schema
      module Def
        class Java < Type::Lang
          register :java

          def define
            title 'Java'
            summary 'Java language support'
            see 'Building a Java Project': 'https://docs.travis-ci.com/user/languages/java/'
            aliases :jvm
            matrix :jdk, to: :jdks
          end
        end
      end
    end
  end
end
