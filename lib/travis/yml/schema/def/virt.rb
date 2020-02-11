# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Virt < Type::Str
          register :virt

          def define
            title 'Virtualization'
            summary 'Build environment virtualization'
            # see 'Virtualization environments': 'https://docs.travis-ci.com/user/reference/overview/#virtualization-environments'

            aliases :virtualization

            downcase

            value :lxd
            value :vm

            export
          end
        end
      end
    end
  end
end
