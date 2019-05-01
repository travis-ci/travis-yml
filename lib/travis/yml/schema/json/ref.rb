# frozen_string_literal: true
require 'travis/yml/schema/json/node'

module Travis
  module Yml
    module Schema
      module Json
        class Ref < Node
          register :ref

          def to_h
            { '$ref': "#/definitions/#{namespace}/#{id}" }.merge(opts)
          end
        end
      end
    end
  end
end
