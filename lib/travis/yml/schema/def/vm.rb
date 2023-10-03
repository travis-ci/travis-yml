# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class VM < Type::Map
          register :vm

          def define
            summary 'VM size settings'

            description <<~str
              These settings can be used in order to choose VM size
            str

            see 'Customizing the Build': 'https://docs.travis-ci.com/user/customizing-the-build/'

            map :size, to: :str, values: [:medium, :large, :'x-large', :'2x-large', :'gpu-medium', :'gpu-xlarge']
            export
          end
        end
      end
    end
  end
end
