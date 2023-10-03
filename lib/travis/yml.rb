# frozen_string_literal: true
require 'logger'
require 'memoize'
require 'obj'
require 'travis/yml/helper/obj'

Obj.include Memoize, Travis::Yml::Helper::Obj

require 'json'
require 'travis/yml/config'
require 'travis/yml/configs'
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
      alert:    true,   # alert on secures that accept a string
      defaults: true,   # add defaults to required keys
      empty:    false,  # warn on empty keys
      fix:      true,   # try fixing unknown keys and values
      line:     true,   # add line numbers to messages
      support:  false,  # warn about features unsupported on the given language, os etc
      drop:     false,  # drop unknown keys and values, invalid conditions, and values missing required keys
      merge_normalized: false # whether to normalize configs before merging
    }

    # These are meant as examples. Clients will want to determine their own
    # representations.

    MSGS = {
      alias_key:          'the key %{alias} is an alias for %{key}, using %{key}',
      alias_value:        'the value %{alias} is an alias for %{value}, using %{value}',
      overwrite:          'both %{key} and %{other} given. %{key} overwrites %{other}',
      default:            'missing %{key}, using the default %<default>p',
      deprecated:         'deprecated: %{info}',
      deprecated_key:     'deprecated key: %<key>p (%{info})',
      deprecated_value:   'deprecated value: %<value>p (%{info})',
      downcase:           'using lower case of %{value}',
      duplicate:          'duplicate values: %{values}',
      duplicate_key:      'duplicate key: %{key}',
      edge:               'this key is experimental and might change or be removed',
      flagged:            'please email support@travis-ci.com to enable %<key>p',
      required:           'missing required key: %{key}',
      secure:             'expected an encrypted string',
      empty:              'dropping empty key: %{key}',
      find_key:           'key %{original} is not known, but %{key} is, using %{key}',
      find_value:         'value %{original} is not known, but %{value} is, using %{value}',
      clean_key:          'key %{original} contains unsupported characters, using %{key}',
      clean_value:        'value %{original} is not known, but %{value} is, using %{value}',
      strip_key:          'key %{original} contains whitespace, using %{key}',
      underscore_key:     'key %{original} is not underscored, using %{key}',
      unexpected_seq:     'unexpected sequence, using the first value (%{value})',
      unknown_key:        'unknown key %<key>p (%{value})',
      unknown_value:      'dropping unknown value: %{value}',
      unknown_var:        'unknown template variable %<var>p',
      unsupported:        '%{key} (%{value}) is not supported on %{on_key} %{on_value}',
      invalid_type:       'dropping unexpected %{actual}, expected %{expected} (%{value})',
      invalid_secure:     'invalid value on secure string: %{value}',
      invalid_format:     'dropping invalid format %{value}',
      invalid_condition:  'invalid condition: %{condition} (%{message})',
      invalid_env_var:    'invalid env var: %{var}',
      invalid_ref:        'invalid import reference: %s',
      skip_allow_failure: 'skipping jobs allow failure rule #%{number} because its condition does not match: %{condition}',
      skip_exclude:       'skipping jobs exclude rule #%{number} because its condition does not match: %{condition}',
      skip_import:        'skipping import %{source} because its condition does not match: %{condition}',
      skip_job:           'skipping job #%{number} because its condition does not match: %{condition}',
      skip_notification:  'skipping notification %{type} #%{number}, condition does not match: %{condition}',
      skip_stage:         'skipping stage #%{number} because its condition does not match: %{condition}',
      invalid_ownership:  'Cannot import a private config file from another owner (%s)',
      invalid_visibility: 'Private repo %s referenced from a public repo',
      import_not_allowed: 'importing from private repo %{repo} is not allowed as per its settings',
      too_many_imports:   'Too many imports, max: %{max}',
      unknown_import:     'import not found: %{source}'
    }

    class << self
      include Memoize

      def metrics
        @metrics ||= Travis::Metrics.setup(config.metrics.to_h, logger)
      end

      def config
        @config ||= Config.load
      end

      def logger
        @logger ||= Logger.new($stdout)
        @logger.level = config.log_level
        @logger
      end

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
        invalid_format unless value.is_a?(Hash)
        opts = OPTS.merge(opts) unless ENV['ENV'] == 'test'
        node = Doc.apply(expand, value, opts)
        node
      end

      def matrix(config)
        config, data = config.values_at(:config, :data) if config[:config]
        Matrix.new(config, data)
      end

      def configs(*args)
        Configs.new(*args)
      end

      def msg(msg)
        level, key, code, args = msg
        msg = MSGS[code] || raise(UnknownMessage, 'Unknown message %p' % code)
        msg = msg % args if args
        msg = '[%s] on %s: %s' % [level, key, msg]
        msg = msg.sub('()', '')
        msg
      rescue KeyError => e
        msg = "unable to generate message (level: %s, key: %s, code: %s, args: %s)" % [level, key, code, args]
        Raven.capture_message(msg) if defined?(Raven)
        msg
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
          use_devtools
        )
      end
      memoize :r_keys

      def expand_keys
        expand.expand_keys - [:jobs] # TODO
      end

      def invalid_format
        raise InvalidConfigFormat, 'Input must parse into a hash'
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

