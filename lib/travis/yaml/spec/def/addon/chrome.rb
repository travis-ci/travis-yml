require 'travis/yaml/spec/type/map'

module Travis
  module Yaml
    module Spec
      module Def
        module Addon
          class Chrome < Type::Fixed
            register :chrome

            def define
              downcase

              value :stable
              value :beta
            end
          end
        end
      end
    end
  end
end
