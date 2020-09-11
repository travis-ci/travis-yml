# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Vm < Type::Map
          register :vm

          def define
            title 'Virtualization Size'

            summary 'Build environment compute type(CPU and memory)'
            # see 'Build Config Imports': 'https://docs.travis-ci.com/user/build-config-imports/'

            description <<~str
              Compute type (CPU and memory) to use for Builds
            str

            normal
            map :size,        to: :sizes, summary: 'Compute size to use for build'

            export
          end
        end

        class Sizes < Type::Map
          register :sizes

          def define
            title 'Compute type size'
            type :size
            export
          end
        end

        class Size < Type::Str
          register :size

          def define

            internal
            downcase

            value :medium,        only: { virt: :vm }
            value :large,        only: { virt: :vm }
            value :'x-large',        only: { virt: :vm }
            value :'2x-large',        only: { virt: :vm }

            export
          end
        end
      end
    end
  end
end
