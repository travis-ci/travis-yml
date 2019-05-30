# frozen_string_literal: true
require 'travis/yml/schema/def/lang/jdks'

module Travis
  module Yml
    module Schema
      module Def
        class Android < Type::Lang
          register :android

          def define
            matrix :jdk, to: :jdks
            map :android, to: AndroidConfig
          end
        end

        class AndroidConfig < Type::Map
          register :android_config

          def define
            map :components, to: :seq
            map :licenses,   to: :seq
          end
        end
      end
    end
  end
end
