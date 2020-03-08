module Spec
  module Support
    module Node
      def self.included(base)
        base.let(:secure) { strict_encode64('secure') }
        base.let(:debug) { subject.msgs.select { |msg| msg[0] == :debug } }
        base.let(:info)  { subject.msgs.select { |msg| msg[0] == :info } }
        base.let(:msgs)  { subject.msgs.reject { |msg| msg[0] == :debug || msg[0] == :info } }

        base.after { Travis::Yml::Schema::Type::Node.cache.clear }

        base.instance_eval do
          def secure
            Base64.strict_encode64('secure')
          end
        end
      end

      def build(parent, key, value, opts = {})
        Travis::Yaml::Doc::Value.build(parent, key, value, opts)
      end

      def change(node)
        Travis::Yaml::Doc::Change.apply(Travis::Yaml.expanded, node)
      end
    end
  end
end
