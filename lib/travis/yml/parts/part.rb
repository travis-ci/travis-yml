require 'travis/yml/parts/parse'

module Travis
  module Yml
    module Parts
      class Part
        MERGE_MODES = %i(
          merge
          deep_merge
          deep_merge_append
          deep_merge_prepend
          deep_merge_patch
          replace
        )

        attr_reader :str, :data, :src, :merge_mode

        def initialize(str, src = nil, merge_mode = nil)
          @str = normalize(str.to_s)
          @src = src
          self.merge_mode = merge_mode
          @data = Parse.new(self).apply
        end

        def merge_mode=(mode)
          mode = Array(mode).flatten.first
          mode = mode.to_s.gsub('-', '_') if mode
          mode = mode&.to_sym
          unknown_merge_mode!(mode) if mode && !MERGE_MODES.include?(mode)
          @merge_mode = mode
        end

        def ==(other)
          str == other
        end

        def to_h
          data
        end

        def normalize(str)
          str = str.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
          str = squiggle(str)
          str.strip
        end

        def squiggle(str)
          width = str =~ /( *)\S/ && $1.size
          str.lines.map { |line| line.gsub(/^ {#{width}}/, '') }.join
        end

        def unknown_merge_mode!(mode)
          raise ArgumentError.new("Unknown merge mode #{mode}")
        end
      end
    end
  end
end
