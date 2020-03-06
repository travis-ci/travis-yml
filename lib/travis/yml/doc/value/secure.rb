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

          def given?
            value.is_a?(Hash) && value['secure']&.str?
          end

          def full_key
            [super, :secure].join('.').to_sym
          end
        end
      end
    end
  end
end
