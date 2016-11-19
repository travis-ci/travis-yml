require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class Erlang < Type::Lang
          register :erlang

          def define
            name :erlang
            matrix :otp_release
          end
        end
      end
    end
  end
end
