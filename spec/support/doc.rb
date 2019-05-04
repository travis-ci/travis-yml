module Spec
  module Support
    module Doc
      KEYS = Travis::Yml::OPTS.keys
      OPTS = { alert: true, drop: false, fix: true, support: true }

      def self.included(const)
        const.let(:empty) { {} }
        const.let(:defaults) { { language: 'ruby', os: ['linux'] } }

        const.let(:opts) do |ctx|
          opts = ctx.metadata.select { |key, _| KEYS.include?(key) }.to_h
          OPTS.merge(opts)
        end
      end

      def build_schema(schema)
        Travis::Yml::Doc::Schema.build(schema)
      end

      def build_value(value, opts = {})
        Travis::Yml::Doc::Value.build(nil, nil, keyify(value), opts)
      end

      def build_part(str, src = nil, mode = nil)
        Travis::Yml::Parts::Part.new(str, src, mode)
      end

      def keyify(obj)
        case obj
        when ::Hash, ::Yaml::Hash
          ::Yaml::Hash.new(obj.map { |key, obj| [to_key(key), keyify(obj)] }.to_h)
        when Array
          obj.map { |obj| keyify(obj) }
        else
          obj
        end
      end

      def to_key(key)
        case key
        when String, Symbol
          ::Key.new(key.to_s)
        else
          raise
        end
      end
    end
  end
end
