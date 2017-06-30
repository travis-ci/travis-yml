require 'yaml'
require 'travis/yaml/doc/change'
require 'travis/yaml/doc/validate'
require 'travis/yaml/doc/value'
require 'travis/yaml/doc/spec'
require 'travis/yaml/helper/deyaml'
require 'travis/yaml/helper/expand'
require 'travis/yaml/matrix'
require 'travis/yaml/spec/def/root'
require 'travis/yaml/support/safe_yaml'

Integer = Fixnum unless defined?(Integer) # Ruby 2.4

module Travis
  module Yaml
    DEFAULTS = {
      language: 'ruby',
      os:       'linux'
    }

    # these are meant as examples. we might want to determine the translation
    # in the client
    MSGS = {
      alert:           'using a plain string as a secure',
      alias:           '%{alias} is an alias for %{value}, using %{value}',
      cast:            'casting value %{given_value} (%{given_type}) to %{value} (%{type})',
      default:         'missing %{key}, defaulting to: %{default}',
      downcase:        'downcasing %{value}',
      edge:            '%{key} is experimental and might be removed in the future',
      flagged:         'your repository must be feature flagged for %{key} to be used',
      irrelevant:      'specified %{key}, but this setting is not relevant for the %{on_key} %{on_value}',
      unsupported:     '%{key} (%{value}) is not supported on the %{on_key} %{on_value}',
      required:        'missing required key %{key}',
      empty:           'dropping empty section %{key}',
      find_key:        'key %{original} is not known, but %{key} is, using %{key}',
      find_value:      'value %{original} is not known, but %{value} is, using %{value}',
      clean_key:       'key %{original} contains special characters, using %{key}',
      clean_value:     'value %{original} is not known, but %{value} is, using %{value}',
      underscore_key:  'key %{original} is camelcased, using %{key}',
      misplaced_key:   'dropping misplaced key %{key} (%{value})',
      unknown_key:     'dropping unknown key %{key} (%{value})',
      unknown_value:   'dropping unknown value: %{value}',
      unknown_default: 'dropping unknown value: %{value}, defaulting to: %{default}',
      unknown_var:     'unknown template variable %{var}',
      invalid_key:     '%{key} is not a valid key',
      invalid_type:    'dropping unexpected %{actual}, expected %{expected} (%{value})',
      invalid_format:  'dropping invalid format: %{value}',
      invalid_seq:     'unexpected sequence, using the first value (%{value})',
      # invalid_value:   '%{value} is not a valid value on this key',
    }

    class << self
      include Helper::Deyaml

      def load(yaml, opts = {})
        hash = YAML.load(yaml, raise_on_unknown_tag: true)
        apply(hash, opts)
      end

      def expanded
        @expanded ||= Doc::Spec::Map.new(nil, Expand.new(spec).apply)
      end

      def spec
        @spec ||= Spec::Def::Root.new.spec
      end

      def apply(input, opts = {})
        raise ArgumentError, 'input must be a Hash' unless input.is_a?(Hash)
        input = deyaml(input)
        node = build(input, opts)
        node = Doc::Change.apply(expanded, node)
        node = Doc::Validate.apply(expanded, node)
        node
      end

      def build(input, opts = {})
        Doc::Value.build(nil, :root, input, opts)
      end

      def matrix(config)
        Matrix.new(spec, config)
      end

      def support
        spec[:includes][:support]
      end

      def keys
        @keys ||= expanded.all_keys
      end

      def r_keys
        @r_keys ||= r_nodes.keys
      end

      # TODO R known keys on root should definitely be reduced
      def r_nodes
        support[:map].select do |key, node|
          node[:types].any? { |type| type.fetch(:only, {})[:language] == ['r'] }
        end
      end

      def msg(msg)
        level, key, code, args = msg
        msg = MSGS[code] || raise('Unknown msg %p' % code)
        msg = msg % args.map { |key, value| [key, value.is_a?(Symbol) ? value.inspect : value] }.to_h if args
        msg = '[%s] on %s: %s' % [level, key, msg]
        msg
      end
    end
  end
end
