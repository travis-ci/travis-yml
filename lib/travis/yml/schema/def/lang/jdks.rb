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
            supports :except, os: :osx
            type :jdk
          end
        end

        class Jdk < Dsl::Str
          register :jdk

          def define
          end
        end
      end
    end
  end
end
