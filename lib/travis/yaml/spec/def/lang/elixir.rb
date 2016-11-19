require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Elixir < Type::Lang
          register :elixir

          def define
            name :elixir
            matrix :elixir
            matrix :otp_release, alias: :otp_release
          end
        end
      end
    end
  end
end
