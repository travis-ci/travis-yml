require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Go < Type::Lang
          register :go

          def define
            name :go, alias: :golang

            matrix :go

            map :gobuild_args,    to: :str
            map :go_import_path,  to: :str
            map :gimme_config,    to: :gimme_config
          end
        end

        class GimmeConfig < Type::Map
          register :gimme_config

          def define
            map :url, to: :str
            map :force_reinstall, to: :bool
          end
        end
      end
    end
  end
end
