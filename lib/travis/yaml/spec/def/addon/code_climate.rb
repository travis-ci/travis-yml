module Travis
  module Yaml
    module Spec
      module Def
        module Addon
          class CodeClimate < Type::Map
            register :code_climate

            def define
              prefix :repo_token, type: [:str, :secure]
              map :repo_token, to: :str, secure: true
            end
          end
        end
      end
    end
  end
end
