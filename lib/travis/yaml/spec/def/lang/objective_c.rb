# frozen_string_literal: true
require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class ObjectiveC < Type::Lang
          register :objective_c

          def define
            name :'objective-c',  alias: %i(objc obj_c objective_c swift)

            matrix :rvm,          alias: :ruby
            matrix :gemfile
            matrix :xcode_scheme
            matrix :xcode_sdk

            map :podfile,         to: :str
            map :bundler_args,    to: :str
            map :xcode_project,   to: :str
            map :xcode_workspace, to: :str
            map :xctool_args,     to: :str
          end
        end
      end
    end
  end
end
