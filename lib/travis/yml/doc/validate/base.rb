# frozen_string_literal: true
require 'registry'
require 'travis/yml/support/map'

module Travis
  module Yml
    module Doc
      module Validate
        class Base < Obj.new(:schema, :value, :opts)
          include Registry

          OBJS = {
            map:  ::Map.new,
            seq:  [],
          }

          def none
            build(nil)
          end

          def blank
            obj = OBJS[schema.type].dup if schema.seq? || schema.map?
            build(obj)
          end

          def build(obj)
            Doc::Value.build(value.parent, value.key, obj, value.opts)
          end
        end
      end
    end
  end
end
