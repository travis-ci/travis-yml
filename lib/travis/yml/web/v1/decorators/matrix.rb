# frozen_string_literal: true
require 'travis/yml'

module Travis::Yml::Web::V1
  module Decorators
    class Matrix
      def initialize(rows)
        @rows = rows
      end

      def call
        {
          'version' => 'v1',
          'matrix' => @rows
        }
      end
    end
  end
end
