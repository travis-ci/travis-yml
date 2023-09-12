require 'travis/yml/parts/parse'

module Travis
  module Yml
    module Parts
      class Part
        attr_reader :str, :data, :src, :merge_modes

        def initialize(str, src = nil, merge_modes = {})
          @str = normalize(str)
          @src = src
          self.merge_modes = merge_modes
          @data = Parse.new(self).apply
        end

        def merge_modes=(modes)
          @merge_modes = modes
        end

        def ==(other)
          str == other
        end

        def to_h
          Map.new(data, data.opts.merge(merge_modes: merge_modes))
        end

        def normalize(str)
          str = Oj.generate(str) if str.is_a?(Hash)
          str = str.to_s.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
          str = squiggle(str)
          str.strip
        end

        def squiggle(str)
          width = str =~ /( *)\S/ && $1.size
          str.lines.map { |line| line.gsub(/^ {#{width}}/, '') }.join
        end
      end
    end
  end
end
