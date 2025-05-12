# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class KeepNetrc < Type::Any
          register :keep_netrc

          def define
            summary 'Whether to retain the `.netrc` file after the build'
            example 'true'
            type :bool, normal: true
            export
          end
        end
      end
    end
  end
end
