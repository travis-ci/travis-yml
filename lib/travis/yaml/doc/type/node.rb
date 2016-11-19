require 'travis/yaml/doc/helper/support'
require 'travis/yaml/helper/common'
require 'travis/yaml/helper/memoize'
require 'travis/yaml/support/registry'

module Travis
  module Yaml
    module Doc
      module Type
        class Node < Struct.new(:parent, :key, :value, :opts)
          include Helper::Common, Helper::Memoize, Registry

          MSGS = {
            alert:           'using a plain string as a secure',
            alias:           '%p is an alias for %p, using %p',
            cast:            'casting value %p to %p (%p)',
            default:         'missing %p, defaulting to %p',
            downcase:        'downcasing %p',
            edge:            '%p is experimental and might be removed in the future',
            flagged:         'your repository must be feature flagged for %p to be used',
            irrelevant:      'specified %p, but this setting is not relevant for the %s %p',
            unsupported:     '%s (%p) is not supported on %s %p',
            required:        'missing required key %p',
            empty:           'dropping empty section %p',
            unknown_key:     'dropping unknown key %p (%p)',
            unknown_default: 'dropping unknown value %p, defaulting to %p',
            unknown_value:   'dropping unknown value %p',
            unknown_var:     'unknown template variable %p',
            invalid_type:    'dropping unexpected %s (%p)',
            invalid_format:  'dropping invalid format %p',
            invalid_seq:     'unexpected sequence, using the first value (%p)',
          }

          def root
            parent ? parent.root : self
          end

          def root?
            self == root
          end

          def given?
            !!opts[:given]
          end

          def known?
            !!opts[:known]
          end

          def default?
            defaults.any?
          end

          def default
            @default ||= defaults.detect do |default|
              Support.new(self, default).supported?
            end
          end

          def defaults
            opts[:defaults] || []
          end

          def format
            opts[:format]
          end

          def alert?
            opts[:alert]
          end

          def relevant?
            support.supported?
          end
          memoize(:relevant?)

          def support
            @support ||= Support.new(self, opts)
          end

          def present?
            super(value) || value.is_a?(FalseClass)
          end

          def blank?
            !present?
          end

          def required?
            !!opts[:required]
          end

          def edge?
            !!opts[:edge]
          end

          def flagged?
            opts[:flagged]
          end

          def info(type, *args)
            msg(:info, type, *args)
          end

          def warn(type, *args)
            msg(:warn, type, *args)
          end

          def error(type, *args)
            msg(:error, type, *args)
          end

          def msg(level, code, *args)
            msg = msg_for(code) % args if code.is_a?(Symbol)
            root.msgs << [level, full_key, code, msg]
          end

          def msg_for(key)
            MSGS[key] || raise('Unknown msg %p' % key)
          end

          def full_key
            ancestors.uniq.join('.').sub('root.', '').to_sym
          end

          def ancestors
            @ancestors ||= begin
              keys = parent.respond_to?(:ancestors) ? parent.ancestors : []
              keys + [key]
            end
          end

          def serialize
            value.respond_to?(:serialize) ? value.serialize : value
          end

          def to_h
            serialize
          end

          def msgs
            @msgs ||= []
          end

          def opts
            super || {}
          end
        end
      end
    end
  end
end
