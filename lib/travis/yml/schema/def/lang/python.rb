# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Python < Type::Lang
          register :python

          def define
            matrix :python
            map :virtualenv, to: :virtualenv
          end
        end

        class Virtualenv < Type::Map
          register :virtualenv

          def define
            strict false # why?
            aliases :virtual_env
            map :system_site_packages, to: :bool
          end
        end
      end
    end
  end
end
