module Travis
  module Yml
    module Meta
      MERGE_MODES = %i(merge deep_merge replace)
      ATTRS = %i(obj src merge_mode)

      attr_accessor *ATTRS

      def initialize(obj, src = nil, merge_mode = nil)
        self.obj = obj
        self.src = src
        self.merge_mode = merge_mode
      end

      def merge_mode=(mode)
        mode = (mode || :merge).to_sym
        unknown_merge_mode!(mode) if mode && !MERGE_MODES.include?(mode)
        @merge_mode = mode
      end

      def unknown_merge_mode!(mode)
        raise ArgumentError.new("Unknown merge mode #{mode}")
      end

      def ==(other)
        obj == other
      end
    end

    class Part < Object
      include Meta

      def initialize(str, *args)
        str.replace(str.strip)
        super
      end

      def to_s
        obj.to_s
      end

      def method_missing(name, *args, &block)
        obj = @obj.send(name, *args, &block)
        obj.is_a?(::String) ? Part.new(obj, src, merge_mode) : obj
      end
    end

    class Config < Object
      include Meta

      def to_h
        obj.to_h
      end

      def method_missing(name, *args, &block)
        obj = @obj.send(name, *args, &block)
        obj.is_a?(::Hash) ? Config.new(obj, src, merge_mode) : obj
      end
    end
  end
end
