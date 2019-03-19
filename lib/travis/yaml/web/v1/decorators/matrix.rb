# frozen_string_literal: true
require 'travis/yaml'

module Travis::Yaml::Web::V1
  module Decorators
    class Matrix
      def initialize(rows)
        @rows = rows
      end

      def call
        {
          'version'.freeze => 'v1',
          'matrix'.freeze => @rows
        }
      end
    end
  end
end
