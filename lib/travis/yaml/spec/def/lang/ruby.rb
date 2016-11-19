require 'travis/yaml/spec/def/jdks'
require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Ruby < Type::Lang
          register :ruby

          def define
            name :ruby

            matrix :rvm, alias: :ruby
            matrix :gemfile, alias: :gemfiles
            matrix :jdk, to: :jdks

            map :bundler_args, to: :str
          end
        end
      end
    end
  end
end
