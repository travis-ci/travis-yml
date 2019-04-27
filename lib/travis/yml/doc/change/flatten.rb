# frozen_string_literal: true
require 'travis/yml/doc/change/base'

module Travis
  module Yml
    module Doc
      module Change
        class Flatten < Base
          def apply
            flatten? ? flatten : value
          end

          def flatten?
            schema.seq? && value.seq? && value.any?(&:seq?)
          end

          def flatten
            node = build(value.serialize.flatten)
            node
          end
        end
      end
    end
  end
end
