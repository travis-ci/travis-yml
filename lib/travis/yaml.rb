require 'yaml'
require 'travis/yaml/errors'
require 'travis/yaml/doc/change'
require 'travis/yaml/doc/validate'
require 'travis/yaml/doc/value'
require 'travis/yaml/doc/spec'
require 'travis/yaml/helper/deyaml'
require 'travis/yaml/helper/expand'
require 'travis/yaml/matrix'
require 'travis/yaml/spec/def/root'
require 'travis/yaml/support/less_yaml'

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
      alert:           'this string should probably be encrypted',
      alias:           '%{alias} is an alias for %{actual}, using %{actual}',
      cast:            'casting value %{given_value} (%{given_type}) to %{value} (%{type})',
      default:         'missing %{key}, using the default %{default}',
      deprecated:      '%{given} is deprecated', # Do we need to say stop using it? or?
      downcase:        'lowercasing %{value}',
      edge:            '%{given} is experimental and might be removed without notice', #is without notice accurate?
      flagged:         'please email support@travis-ci.org to enable %{given}',
      irrelevant:      'you used %{key}, but it is not relevant for the %{on_key} %{on_value}',
      unsupported:     '%{key} (%{value}) is not supported on the %{on_key} %{on_value}',
      required:        'you need to specify %{key}',
      empty:           'dropping empty section %{key}',
      find_key:        'key %{original} is not known, but %{key} is, using %{key}',
      find_value:      'value %{original} is not known, but %{value} is, using %{value}',
      clean_key:       'key %{original} contains unsupported characters, using %{key}',
      clean_value:     'value %{original} is not known, but %{value} is, using %{value}',
      underscore_key:  'key %{original} is camelcased, using %{key}',
      migrate:         'migrating %{key} to %{to} (value: %{value})', # does this need action?
      misplaced_key:   'dropping misplaced key %{key} (%{value})',
      unknown_key:     'dropping unknown key %{key} (%{value})',
      unknown_value:   'dropping unknown value: %{value}',
      unknown_default: 'dropping unknown value: %{value}, defaulting to %{default}',
      unknown_var:     'unknown template variable %{var}',
      invalid_key:     '%{key} is not a valid key',
      invalid_type:    'dropping unexpected %{actual}, expected %{expected} (%{value})',
      invalid_format:  'dropping invalid format %{value}',
      invalid_seq:     'unexpected sequence, using the first value (%{value})',
      invalid_cond:    'unable to parse condition (%{value})',
      # invalid_value:   '%{value} is not a valid value on this key',
    }

    class << self
      include Helper::Deyaml

      def load(yaml, opts = {})
        hash = YAML.load(yaml.strip, raise_on_unknown_tag: true) || {}
        apply(hash, opts)
      end

      def expanded
        @expanded ||= Doc::Spec::Map.new(nil, Expand.new(spec).apply)
      end

      def spec
        @spec ||= Spec::Def::Root.new.spec
      end

      def apply(input, opts = {})
        raise UnexpectedConfigFormat, 'Input must be a hash' unless input.is_a?(Hash)
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
        msg = MSGS[code] || raise(UnknownMessage, 'Unknown message %p' % code)
        msg = msg % args.map { |key, value| [key, value.is_a?(Symbol) ? value.inspect : value] }.to_h if args
        msg = '[%s] on %s: %s' % [level, key, msg]
        msg
      end
    end
  end
end
