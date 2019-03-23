# frozen_string_literal: true
require 'travis/yml/doc/schema/node'

module Travis
  module Yml
    module Doc
      module Schema
        class None < Node

          def type
            :none
          end
        end
      end
    end
  end
end
