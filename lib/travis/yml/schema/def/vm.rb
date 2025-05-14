# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class VM < Type::Map
          register :vm

          def define
            summary 'VM size and custom image settings'

            description <<~str
              These settings can be used in order to choose VM size and custom image
            str

            see 'Customizing the Build': 'https://docs.travis-ci.com/user/customizing-the-build/'

            map :size, to: :str, values: [:medium, :large, :'x-large', :'2x-large', :'gpu-medium', :'gpu-xlarge']
            map :create, to: :create, unique_value_globally: true
            map :use, to: :use

            export
          end

          class Create < Type::Map
            register :create

            def define
              example 'my_custom_name'
              summary 'The name of the custom image to create'
              map :name, to: :str
            end
          end

          class Use < Type::Any
            register :use

            def define
              type Class.new(Type::Map) {
                def define
                  example 'my_custom_name'
                  summary 'The name of the custom image to use'
                  map :name, to: :str
                end
              }
            type :str
            end
          end
        end
      end
    end
  end
end
