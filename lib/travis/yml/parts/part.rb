require 'travis/yml/parts/parse'

module Travis
  module Yml
    module Parts
      class Part
        MERGE_MODES = %i(merge deep_merge replace)

        attr_reader :str, :data, :src, :merge_mode

        def initialize(str, src = nil, merge_mode = nil)
          @str = str.strip
          @src = src
          self.merge_mode = merge_mode
          @data = Parse.new(self).apply
        end

        def merge_mode=(mode)
          mode = (mode || :merge).to_sym
          unknown_merge_mode!(mode) if mode && !MERGE_MODES.include?(mode)
          @merge_mode = mode
        end

        # def merge_mode
        #   opts = Array(data.opts[:merge])
        #   mode = opts.&(MERGE_MODES).first
        #   mode = [mode, :append].join('_').to_sym if opts.include?(:append)
        #   mode || @merge_mode
        # end

        def ==(other)
          str == other
        end

        def to_h
          data
        end

        def unknown_merge_mode!(mode)
          raise ArgumentError.new("Unknown merge mode #{mode}")
        end
      end
    end
  end
end
