require 'travis/yml/parts/merge'
require 'travis/yml/parts/parse'
require 'travis/yml/parts/part'

module Travis
  module Yml
    module Parts
      def self.load(parts)
        parts = Array(parts).map { |part| part.is_a?(Part) ? part : Part.new(part) }
        Merge.new(parts).apply.to_h
      end
    end
  end
end
