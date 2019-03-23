# frozen_string_literal: true
require 'travis/yml/schema/type/map'

module Travis
  module Yml
    module Schema
      module Type
        class Lang < Map
          # include Registry

          register :lang

          def schema
            { '$ref': "#/definitions/#{namespace}/#{id}" }
          end
        end
      end
    end
  end
end
