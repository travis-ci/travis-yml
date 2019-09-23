# frozen_string_literal: true
require 'travis/yml/schema/def/lang/jdks'

module Travis
  module Yml
    module Schema
      module Def
        class Android < Type::Lang
          register :android

          def define
            title 'Android'
            summary 'Android support'
            see 'Building an Android Project': 'https://docs.travis-ci.com/user/languages/android/'

            matrix :jdk, to: :jdks
            map :android, to: AndroidConfig
          end
        end

        class AndroidConfig < Type::Map
          register :android_config

          def define
            map :components, to: :seq, summary: 'Android components to use'
            map :licenses,   to: :seq, summary: 'Android licenses to use'
          end
        end
      end
    end
  end
end
