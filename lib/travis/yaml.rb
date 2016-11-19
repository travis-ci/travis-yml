require 'yaml'
require 'travis/yaml/doc/conform'
require 'travis/yaml/doc/factory/node'
require 'travis/yaml/matrix'
require 'travis/yaml/spec/def/root'
require 'travis/yaml/support/safe_yaml'

module Travis
  module Yaml
    class << self
      def load(yaml, opts = {})
        hash = YAML.load(yaml, raise_on_unknown_tag: true)
        apply(hash, opts)
      end

      def apply(hash, opts = {})
        node = build(hash, opts)
        conform(node)
        node
      end

      def build(hash, opts = {})
        Doc::Factory::Node.new(spec.merge(opts), nil, :root, hash).build
      end

      def conform(node)
        Doc::Conform.apply(node)
      end

      def matrix(config)
        Matrix.new(spec, config)
      end

      def spec
        @spec ||= Spec::Def::Root.new.spec
      end
    end
  end
end
