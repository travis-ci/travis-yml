# frozen_string_literal: true
require 'travis/yml/schema/def/lang/jdks'
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        class Android < Lang
          register :android

          def define
            matrix :jdk, to: :jdks
            map :android, to: AndroidConfig
            super
          end
        end

        class AndroidConfig < Dsl::Map
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
