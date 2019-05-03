# frozen_string_literal: true
module Travis
  module Yml
    module Doc
      module Change
        class Base < Obj.new(:schema, :value, opts: {})
          def build(*args)
            args = [value.parent, value.key, *args, value.opts] if args.size == 1
            Doc::Value.build(*args)
          end

          def none
            build(nil)
          end
        end
      end
    end
  end
end

