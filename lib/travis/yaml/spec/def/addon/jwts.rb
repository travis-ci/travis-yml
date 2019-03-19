# frozen_string_literal: true
require 'travis/yaml/spec/type/seq'

module Travis
  module Yaml
    module Spec
      module Def
        module Addon
          class Jwts < Type::Seq
            register :jwts

            def define
              type :scalar, secure: true
            end
          end
        end
      end
    end
  end
end
