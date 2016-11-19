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
            map :gobuild_args, to: :scalar
            map :go_import_path, to: :scalar
          end
        end
      end
    end
  end
end
