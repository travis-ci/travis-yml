module Spec
  module Support
    module Doc
      OPTS = [:alert, :defaults, :empty, :line]

      def self.included(const)
        const.let(:empty) { {} }
        const.let(:defaults) { { language: 'ruby', os: ['linux'] } }

        const.let(:opts) do |ctx|
          opts = ctx.metadata.select { |key, _| OPTS.include?(key) }.to_h
          opts.merge(alert: true)
        end
      end

      def build_schema(schema)
        Travis::Yml::Doc::Schema.build(schema)
      end

      def build_value(value, opts = {})
        Travis::Yml::Doc::Value.build(nil, nil, stringify(value), opts)
      end

      def build_part(str, src = nil, mode = nil)
        Travis::Yml::Parts::Part.new(str, src, mode)
      end

      def stringify(obj)
        Travis::Yml::Helper::Obj.stringify(obj)
      end
    end
  end
end
