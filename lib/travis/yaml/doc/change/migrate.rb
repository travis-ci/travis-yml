# frozen_string_literal: true
require 'travis/yaml/doc/change/base'
require 'travis/yaml/helper/memoize'

module Travis
  module Yaml
    module Doc
      module Change
        class Migrate < Base
          def apply
            Down.new(spec, node, opts).apply
            Up.new(spec, node, opts).apply
          end

          class Down < Base
            include Helper::Common

            def apply
              migrate if migrate?
            end

            def migrate?
              !targets.empty?
            end

            def migrate
              targets.each do |target|
                catch :unmergeable do
                  next unless other = migrateable(target)
                  parent = node.parent.delete(node)
                  parent.set(target, other)
                  parent.warn :migrate, key: node.key, to: target, value: node.raw
                  changed parent
                end
              end
              nil
            end

            def migrateable(target)
              value = with_given(node.parent[target], node.key => node.raw)
              other = build(nil, target, value, node.opts)
              other if verify(target, other) # it's odd that we cannot use the verified node
            end

            def with_given(node, value)
              case other = node && node.raw
              when Array then other.push(value)
              when Hash  then other.merge(value)
              else value
              end
            end

            def verify(target, node)
              value = node.raw
              value = required(spec, target).merge(value) if node.map?
              value = { target => value }
              opts = except(node.opts, :msgs, :ids).merge(supporting: supporting)
              node = build(nil, :down, value, opts)
              node = Change.apply(spec, node)
              node = Validate.apply(spec, node)
              msgs = node.msgs.slice!(0..-1)
              node unless msgs.any? { |msg| msg[0] == :error }
            end

            def targets
              @targets ||= spec.down_keys[node.key] || []
            end

            def required(spec, key)
              value = node.parent.raw[key]
              node  = build(nil, key, value, {})
              type  = Spec.detect_type(spec, spec.map[key], node)
              type  = Spec.detect_type(type, type, node ) if type.seq? # TODO move this to detect_type
              keys  = type.required_keys
              value = value.is_a?(Hash) ? only(value, *keys) : {}
              keys.map { |key| [key, nil] }.to_h.merge(value)
            end

            def supporting
              node.supporting
            end
          end

          class Up < Base
            include Helper::Common, Helper::Memoize

            def apply
              migrate if migrate?
            end

            def migrate?
              target && target_spec && known? && migrateable?
            end

            def maps?
              target[node.key].map? && node.map?
            end

            def known?
              target_spec.keys.include?(node.key)
            end

            def migrateable?
              return true unless other = target[node.key]
              value = other.raw
              value = except(value, node.key) if value.is_a?(Hash)
              blank?(value) || value.is_a?(Hash) && node.map?
            end

            def migrate
              return unless verify
              node.parent.warn :migrate, key: node.key, to: target.key, value: node.raw
              other = target[node.key]
              target[node.parent.key].delete(node) # TODO has parent come out of sync?
              target.set(node.key, node)
              target[node.key].merge(other) if other && other.map? && node.map?
              changed target
            end

            def target
              target = node.parent && node.parent.parent
              target = target.parent until target.nil? || target.map?
              target
            end
            memoize :target

            def target_spec
              parent = spec.parent && spec.parent.parent
              parent = parent.parent until parent.nil? || parent.map?
              parent
            end
            memoize :target_spec

            def verify
              value = required.merge(node.key => node.raw)
              opts = except(target.opts, :msgs, :ids).merge(supporting: node.supporting)
              node = build(nil, :up, value, opts)
              node = Change.apply(target_spec, node)
              node = Validate.apply(target_spec, node)
              msgs = node.msgs.slice!(0..-1)
              node unless msgs.any? { |msg| msg[0] == :error }
            end

            def required
              keys = target_spec.required_keys
              keys.map { |key| [key, target[key] && target[key].raw] }.to_h
            end

            def keys
              spec.keys
            end

            def supporting
              node.supporting
            end
          end
        end
      end
    end
  end
end
