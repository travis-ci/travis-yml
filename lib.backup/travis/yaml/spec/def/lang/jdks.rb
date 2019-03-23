# frozen_string_literal: true
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        class Jdks < Type::Seq
          register :jdks

          def define
            type :jdk
            except os: :osx
          end
        end

        class Jdk < Type::Scalar
          register :jdk
        end
      end
    end
  end
end
