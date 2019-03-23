# frozen_string_literal: true
require 'travis/yml/schema/dsl/seq'
require 'travis/yml/schema/dsl/str'

module Travis
  module Yml
    module Schema
      module Def
        class Jdks < Dsl::Seq
          register :jdks

          def define
            type :jdk
            super
          end
        end

        class Jdk < Dsl::Str
          register :jdk

          def define
            supports :except, os: :osx
          end
        end
      end
    end
  end
end
