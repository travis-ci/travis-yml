# frozen_string_literal: true
require 'obj'
require 'memoize'
require 'travis/yml/helper/obj'

Obj.include Memoize, Travis::Yml::Helper::Obj

require 'json'
require 'yaml'
require 'travis/yml/errors'
require 'travis/yml/doc'
require 'travis/yml/docs'
require 'travis/yml/helper/deyaml'
require 'travis/yml/load'
require 'travis/yml/matrix'
require 'travis/yml/schema'
require 'travis/yml/support/less_yaml'

Integer = Fixnum unless defined?(Integer) # Ruby 2.4

module Travis
  module Yml
    DEFAULTS = {
      language: 'ruby',
      os:       'linux'
    }

    OPTS = {
      required: true,
      defaults: true
    }

    # These are meant as examples. Clients will want to determine their own
    # representations.
    MSGS = {
      alert:             'this string should probably be encrypted',
      alias:             '%{alias} is an alias for %{actual}, using %{actual}',
      cast:              'casting value %{given_value} (%{given_type}) to %{value} (%{type})',
      default:           'missing %{key}, using the default %{default}',
      deprecated:        '%{given} is deprecated', # Do we need to say stop using it? or?
      downcase:          'using lower case of %{value}',
      duplicate_names:   'duplicate job names: %{value}',
      edge:              '%{given} is experimental and might be removed or change', # is without notice accurate?
      flagged:           'please email support@travis-ci.com to enable %{given}',
      irrelevant:        'you used %{key}, but it is not relevant for the %{on_key} %{on_value}',
      unsupported:       '%{key} (%{value}) is not supported on the %{on_key} %{on_value}',
      required:          'you need to specify %{key}',
      empty:             'dropping empty section %{key}',
      find_key:          'key %{original} is not known, but %{key} is, using %{key}',
      find_value:        'value %{original} is not known, but %{value} is, using %{value}',
      clean_key:         'key %{original} contains unsupported characters, using %{key}',
      clean_value:       'value %{original} is not known, but %{value} is, using %{value}',
      underscore_key:    'key %{original} is camelcased, using %{key}',
      migrate:           'migrating %{key} to %{to} (value: %{value})', # does this need action? (answer: yes, it does [Sv])
      misplaced_key:     'dropping misplaced key %{key} (%{value})',
      unknown_key:       'dropping unknown key %{key} (%{value})',
      unknown_value:     'dropping unknown value: %{value}',
      unknown_default:   'dropping unknown value: %{value}, defaulting to %{default}',
      unknown_var:       'unknown template variable %{var}',
      invalid_key:       '%{key} is not a valid key',
      invalid_type:      'dropping unexpected %{actual}, expected %{expected} (%{value})',
      invalid_format:    'dropping invalid format %{value}',
      invalid_condition: 'invalid condition: %{condition}',
      invalid_seq:       'unexpected sequence, using the first value (%{value})',
      invalid_cond:      'unable to parse condition (%{value})',
    }

    class << self
      include Helper::Deyaml, Memoize

      def load(parts, opts = {})
        apply(Load.apply(parts), opts)
      end

      def expand
        bench { Doc::Schema.build(schema) }
      end
      memoize :expand

      def schema
        bench { Schema.json }
      end
      memoize :schema

      def write
        bench { File.write('schema.json', JSON.pretty_generate(schema)) }
      end

      def apply(input, opts = {})
        unexpected_format! unless input.is_a?(Hash)
        opts = OPTS.merge(opts) unless ENV['env'] == 'test'
        input = deyaml(input)
        node = Doc.build(input, opts)
        node = Doc.change(expand, node)
        node = Doc.validate(expand, node)
        node
      end

      def matrix(config)
        Matrix.new(config, expand_keys)
      end

      def msg(msg)
        level, key, code, args = msg
        msg = MSGS[code] || raise(UnknownMessage, 'Unknown message %p' % code)
        msg = msg % args.map { |key, value| [key, value.is_a?(Symbol) ? value.inspect : value] }.to_h if args
        msg = '[%s] on %s: %s' % [level, key, msg]
        msg
      end

      def keys
        @keys ||= expand.all_keys - R_KEYS
      end

      # R's known keys on root should definitely be reduced

      R_KEYS = %i(
        r_packages
        r_binary_packages
        r_github_packages
        apt_packages
        bioc_packages
        brew_packages
        bioc
        bioc_check
        bioc_required
        bioc_use_devel
        cran
        disable_homebrew
        latex
        pandoc
        pandoc_version
        r_build_args
        r_check_args
        r_check_revdep
        warnings_are_errors
        remotes
        repos
      )

      def expand_keys
        expand.expand_keys
      end

      def unexpected_format!
        raise UnexpectedConfigFormat, 'Input must be a hash'
      end

      def bench(key = nil)
        now = Time.now
        yield.tap do
          puts "Schema.#{(key || caller[2][/`(.*)'/] && $1).to_s.ljust(6)} took #{Time.now - now} sec"
        end
      end
    end
  end
end

