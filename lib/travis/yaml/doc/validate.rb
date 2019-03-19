# frozen_string_literal: true
require 'travis/yaml/doc/validate/alert'
require 'travis/yaml/doc/validate/condition'
require 'travis/yaml/doc/validate/default'
require 'travis/yaml/doc/validate/duplicate_names'
require 'travis/yaml/doc/validate/empty'
require 'travis/yaml/doc/validate/flags'
require 'travis/yaml/doc/validate/format'
require 'travis/yaml/doc/validate/invalid_type'
require 'travis/yaml/doc/validate/required'
require 'travis/yaml/doc/validate/template'
require 'travis/yaml/doc/validate/unknown_keys'
require 'travis/yaml/doc/validate/unknown_value'
require 'travis/yaml/doc/validate/unsupported_key'
require 'travis/yaml/doc/validate/unsupported_value'
require 'travis/yaml/doc/validate/version'
require 'travis/yaml/doc/spec/types'

module Travis
  module Yaml
    module Doc
      module Validate
        VALIDATE = {
          map: [
            Alert, Flags, Version, InvalidType, UnknownKeys, UnsupportedKey,
            Required, Empty
          ],
          seq: [
            Flags, Version, InvalidType, UnsupportedKey, Default, Required,
            Empty, DuplicateNames
          ],
          fixed: [
            Format, Alert, Flags, Version, UnknownValue, InvalidType,
            UnsupportedKey, UnsupportedValue, Default, Required
          ],
          scalar: [
            Format, Condition, Alert, Flags, Version, InvalidType,
            UnsupportedKey, Default, Required
          ],
        }

        DEBUG = false

        class << self
          def apply(spec, node)
            validate(spec, node)
          end

          def validate(spec, node)
            send(:"validate_#{spec.type}", spec, node)
          end

          def validate_map(spec, node)
            node = validate_mappings(spec, node) if node.map?
            node = validate_node(spec, node)
            node
          end

          def validate_mappings(spec, node)
            node.keys.inject(node) do |parent, key|
              next parent unless node = parent[key]
              type = Spec.detect_type(spec, spec.map[key], node)
              node = validate(type, node)
              parent = node.parent.set(key, node)
              parent
            end
          end

          def validate_seq(spec, node)
            node = validate_children(spec, node) if node.seq?
            node = validate_node(spec, node)
            node
          end

          def validate_children(spec, node)
            node.map do |child|
              type = spec.seq? ? Spec.detect_type(spec, spec, child) : spec
              child = validate(type, child)
            end
          end

          def validate_node(spec, node)
            validators(spec).inject(node) do |node, opts|
              const = Validator[opts[:name]] if opts.is_a?(Hash)
              const, opts = opts, {} unless const
              puts msg('->', const, node) if DEBUG
              node = const.new(spec, node, opts).apply
              puts msg('<-', const, node) if DEBUG
              node
            end
          end
          alias validate_fixed  validate_node
          alias validate_scalar validate_node
          alias validate_secure validate_node

          def msg(head, const, node)
            [head, const.registry_key, node.key, node.type, node.raw.inspect].join(' ')
          end

          def validators(spec)
            VALIDATE[spec.type] + spec.validators
          end
        end
      end
    end
  end
end
