require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class ObjectiveC < Type::Lang
          register :objective_c

          def define
            name :objective_c, alias: %i(objc obj_c objective-c swift)

            matrix :xcode_sdk
            matrix :xcode_scheme
            matrix :podfile

            map :xcode_project,   to: :scalar
            map :xcode_workspace, to: :scalar
            map :xctool_args,     to: :scalar
          end
        end
      end
    end
  end
end
