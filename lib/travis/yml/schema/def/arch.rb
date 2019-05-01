# frozen_string_literal: true
require 'travis/yml/schema/dsl/str'
require 'travis/yml/schema/dsl/seq'

module Travis
  module Yml
    module Schema
      module Def
        class Archs < Dsl::Seq
          register :archs

          def define
            title 'Architectures'

            description <<~str
              The architectures that will be selected for the build environments.
            str

            normal
            type Arch
            export
          end
        end

        class Arch < Dsl::Str
          register :arch

          def define
            title 'Architecture'

            description <<~str
              The architecture that will be selected for the build environment.
            str

            # examples <<~str
            #   arch: amd64
            # str

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
