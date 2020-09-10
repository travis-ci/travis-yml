# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class VirtSIze < Type::Str
          register :virt_size

          def define
            title 'Virtualization Size'
            summary 'Build environment compute type(CPU and memory)'
            # see 'Virtualization environments': 'https://docs.travis-ci.com/user/reference/overview/#virtualization-environments'

            aliases :virt_size
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