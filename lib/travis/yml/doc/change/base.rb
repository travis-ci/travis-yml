# frozen_string_literal: true
require 'travis/yml/support/obj'
require 'travis/yml/support/memoize'

module Travis
  module Yml
    module Doc
      module Change
        class Base < Obj.new(:schema, :value, opts: {})
          include Memoize

          def build(*args)
            args = [value.parent, value.key, *args, value.opts] if args.size == 1
            Doc::Value.build(*args)
          end

          def none
            build(nil)
          end

          # def changed(value)
          #   value = throwable(value)
          #   puts msg(value) if Change::DEBUG
          #   throw value.id, [value, true]
          # end
          #
          # def throwable(value)
          #   until throwable?(value) || value.root?
          #     value.completed = false
          #     value = value.parent
          #   end
          #   value.completed = false
          #   value
          # end
          #
          # def throwable?(value)
          #   ids.include?(value.id)
          # end
          #
          # def msg(value)
          #   ['^^', :throw, source, value.id, value.type, value.raw.inschemat].join(' ')
          # end
          #
          # def source
          #   method = caller[2] =~ /`(.*)'/ && $1.sub('block in', '').strip
          #   const = self.class.name.split('::').last
          #   [const, method].join('#')
          # end
          #
          # def ids
          #   opts[:ids] || []
          # end
        end
      end
    end
  end
end

