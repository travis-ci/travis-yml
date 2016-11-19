require 'travis/yaml/doc/normalize/normalizer'

module Travis
  module Yaml
    module Doc
      module Normalize
        class Required < Normalizer
          register :required

          def apply
            value.to_s == 'required' ? true : value
          end
        end
      end
    end
  end
end
