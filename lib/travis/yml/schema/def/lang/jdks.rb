# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Jdks < Type::Seq
          register :jdks

          def define
            supports :except, os: :osx
            type :jdk
            export
          end
        end

        class Jdk < Type::Str
          register :jdk

          def define
          end
        end
      end
    end
  end
end
