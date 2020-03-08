# frozen_string_literal: true
require 'base64'
require 'travis/yml/doc/value/map'

module Travis
  module Yml
    module Doc
      module Value
        class Secure < Map
          include Base64

          def type
            :secure
          end

          def given?
            value.is_a?(Hash) && value['secure']&.str?
          end

          def encoded?
            return unless given?
            str = value['secure'].value.to_s.gsub(/\s/, '')
            str == strict_encode64(decode64(str))
          end

          def full_key
            [super, :secure].join('.').to_sym
          end
        end
      end
    end
  end
end
