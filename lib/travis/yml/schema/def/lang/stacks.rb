# frozen_string_literal: true
require 'travis/yml/schema/def/stack'
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        Stack::NAMES.each do |stack|
          const = Class.new(Lang) do
            register :"__#{stack}__"

            def define
              internal
              deprecated
              super
            end
          end

          const_set(stack.capitalize, const)
        end
      end
    end
  end
end
