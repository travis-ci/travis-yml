# frozen_string_literal: true
require 'travis/yaml/spec/type/fixed'

module Travis
  module Yaml
    module Spec
      module Def
        class Stack < Type::Fixed
          VALUES = %i(connie amethyst garnet stevonnie opal sardonyx onion cookiecat)

          register :stack

          def define
            downcase
            edge

            VALUES.each do |stack|
              value stack
            end
          end
        end
      end
    end
  end
end
