# frozen_string_literal: true
require 'travis/yml/doc/change/base'
require 'travis/yml/doc/value/cast'

module Travis
  module Yml
    module Doc
      module Change
        class Wrap < Base
          def apply
            # puts
            # p :WRAP
            # p wrap?
            # p value.serialize
            wrap? ? wrap : value
          end

          def wrap?
            schema.seq? && !value.seq?
          end

          def wrap
            node = build([value])
            # p [:wrap, node.serialize]
            node
          end
        end
      end
    end
  end
end
