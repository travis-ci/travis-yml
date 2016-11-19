require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        module Addon
          class Jwts < Type::Seq
            register :jwts

            def define
              type :scalar, cast: :secure
            end
          end
        end
      end
    end
  end
end
