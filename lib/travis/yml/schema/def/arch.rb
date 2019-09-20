# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Archs < Type::Seq
          register :archs

          def define
            title 'Architectures'

            summary 'Build environment architectures'

            description <<~str
              The architectures that will be selected for the build environments.
            str

            normal
            type :arch
            export
          end
        end

        class Arch < Type::Str
          register :arch

          def define
            title 'Architecture'

            summary 'Build environment architecture'

            description <<~str
              The architecture that will be selected for the build environment.
            str

            downcase

            supports :only, os: :linux
            value :amd64, alias: :x86_64
            value :ppc64le, alias: %i(power ppc ppc64)

            export
          end
        end
      end
    end
  end
end
