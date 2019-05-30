# frozen_string_literal: true
require 'travis/yml/schema/def/stack'

module Travis
  module Yml
    module Schema
      module Def
        Stack::STACKS.each do |stack|
          const = Class.new(Type::Lang) do
            register :"__#{stack}__"

            def define
              internal
              deprecated 'experimental stack language'
            end
          end

          const_set(stack.capitalize, const)
        end
      end
    end
  end
end
