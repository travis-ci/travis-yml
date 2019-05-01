# frozen_string_literal: true
require 'travis/yml/schema/type/map'

module Travis
  module Yml
    module Schema
      module Type
        class Lang < Map
          register :lang
        end
      end
    end
  end
end
