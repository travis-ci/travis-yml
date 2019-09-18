# frozen_string_literal: true
require 'obj'
require 'memoize'
require 'travis/yml/helper/obj'

Obj.include Memoize, Travis::Yml::Helper::Obj

require 'json'
require 'travis/yml/errors'
require 'travis/yml/doc'
require 'travis/yml/docs'
require 'travis/yml/parts'
require 'travis/yml/matrix'
require 'travis/yml/schema'
require 'travis/yml/support/yaml'

Integer = Fixnum unless defined?(Integer) # Ruby 2.4

module Travis
  module Yml
    DEFAULTS = {
      language: 'ruby',
      os:       'linux'
    }

    # These exist so we can parametrize things a little for testing (e.g. so
    # tests don't break elsewhere just because a default has changed here).

    OPTS = {
      alert:     true,   # alert on secures that accept a string
      defaults:  true,   # add defaults to required keys
      empty:     false,  # warn on empty keys
      fix:       true,   # try fixing unknown keys and values
      line:      true,   # add line numbers to messages
      support:   false,  # warn about features unsupported on the given language, os etc
      drop:      false,  # drop unknown keys and values, and values missing required keys
    }

    # These are meant as examples. Clients will want to determine their own
    # representations.

    MSGS = {
      alias:             '%{alias} is an alias for %{obj}, using %{obj} (%{type})',
      default:           'missing %{key}, using the default %<default>p',
      deprecated:        'deprecated: %{info}',
      deprecated_key:    'deprecated key: %<key>p (%{info})',
      deprecated_value:  'deprecated value: %<value>p (%{info})',
      downcase:          'using lower case of %{value}',
      duplicate:         'duplicate values: %{values}',
      edge:              'this key is experimental and might change or be removed',
      flagged:           'please email support@travis-ci.com to enable %<key>p',
      required:          'missing required key %<key>p',
      secure:            'expected an encrypted string',
      empty:             'dropping empty section %<key>p',
      find_key:          'key %{original} is not known, but %{key} is, using %{key}',
      find_value:        'value %{original} is not known, but %{value} is, using %{value}',
      clean_key:         'key %{original} contains unsupported characters, using %{key}',
      clean_value:       'value %{original} is not known, but %{value} is, using %{value}',
      strip_key:         'key %{original} contains whitespace, using %{key}',
      underscore_key:    'key %{original} is not underscored, using %{key}',
      unexpected_seq:    'unexpected sequence, using the first value (%{value})',
      unknown_key:       'unknown key %<key>p (%{value})',
      unknown_value:     'dropping unknown value: %{value}',
      unknown_default:   'dropping unknown value: %{value}, defaulting to %{default}',
      unknown_var:       'unknown template variable %<var>p',
      unsupported:       '%<key>p (%{value}) is not supported on the %<on_key>p %{on_value}',
      invalid_type:      'dropping unexpected %<actual>p, expected %<expected>p (%{value})',
      invalid_format:    'dropping invalid format %{value}',
      invalid_condition: 'invalid condition: %{condition}',
      invalid_env_var:   'invalid env var: %{var}',
    }

    class << self
      include Memoize

      def load(parts, opts = {})
        apply(Parts.load(parts), opts)
      end

      def expand
        bench { Doc::Schema.build(schema) }
      end
      memoize :expand

      def schema
        Schema.json
      end
      memoize :schema

      def write
        File.write('schema.json', JSON.pretty_generate(schema))
      end

      def apply(value, opts = {})
        unexpected_format! unless value.is_a?(Hash)
        opts = OPTS.merge(opts) unless ENV['env'] == 'test'
        node = Doc.apply(expand, value, opts)
        node
      end

      def matrix(config)
        Matrix.new(config)
      end

      def msg(msg)
        level, key, code, args = msg
        msg = MSGS[code] || raise(UnknownMessage, 'Unknown message %p' % code)
        msg = msg % args if args
        msg = '[%s] on %s: %s' % [level, key, msg]
        msg
      # rescue KeyError => e
      end

      def keys
        @keys ||= expand.all_keys - r_keys
      end

      # R's known keys on root should definitely be reduced
      def r_keys
        %w(
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
      end
      memoize :r_keys

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

