# frozen_string_literal: true
require 'travis/yml/schema/dsl/group'

module Travis
  module Yml
    module Schema
      module Dsl
        class Ref < Node
          register :ref

          def self.type
            :ref
          end

          def id(id)
            node.set :id, id
          end

          def namespace(namespace)
            node.set :namespace, namespace
          end
        end
      end
    end
  end
end
