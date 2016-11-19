require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Python < Type::Lang
          register :python

          def define
            name :python
            matrix :python
            map :virtualenv, to: :virtualenv, strict: false #, alias: :virtual_env
          end
        end

        class Virtualenv < Type::Map
          register :virtualenv

          def define
            map :system_site_packages, to: :scalar, cast: :bool
          end
        end
      end
    end
  end
end
