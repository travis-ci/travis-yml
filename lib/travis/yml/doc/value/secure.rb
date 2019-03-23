# frozen_string_literal: true
require 'travis/yml/doc/value/map'

module Travis
  module Yml
    module Doc
      module Value
        class Secure < Map
          def type
            :secure
          end
        end
      end
    end
  end
end
