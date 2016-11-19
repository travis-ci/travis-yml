module Travis
  module Yaml
    module Spec
      module Def
        module Addon
          class CodeClimate < Type::Map
            register :code_climate

            def define
              map :repo_token, to: :scalar, cast: :secure
            end
          end
        end
      end
    end
  end
end
