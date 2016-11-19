require 'travis/yaml/doc/change/cache'
require 'travis/yaml/doc/change/cast'
require 'travis/yaml/doc/change/downcase'
require 'travis/yaml/doc/change/enable'
require 'travis/yaml/doc/change/env'
require 'travis/yaml/doc/change/inherit'
require 'travis/yaml/doc/change/keys'
require 'travis/yaml/doc/change/merge'
require 'travis/yaml/doc/change/repair'
require 'travis/yaml/doc/change/pick'
require 'travis/yaml/doc/change/prefix'
require 'travis/yaml/doc/change/value'
require 'travis/yaml/doc/change/wrap'
require 'travis/yaml/doc/spec/types'
require 'travis/yaml/support/obj'

module Travis
  module Yaml
    module Doc
      module Change
        def self.apply(spec, node)
          Changer.new(spec, node).apply
        end

        MAX_STACK = 100
        DEBUG = false
        DEBUG_CHANGES = false

        class Changer < Obj.new(:spec, :node)
          include Travis::Yaml::Helper::Common

          CHANGES = {
            map:    [Keys, Merge, Prefix, Pick],
            seq:    [Wrap],
            fixed:  [Repair, Pick, Cast, Downcase, Value],
            scalar: [Repair, Pick, Cast]
          }

          def apply
            changing(nil, spec, node) { |spec, node| change(spec, node) }
          end

          def change(spec, node)
            send(:"change_#{spec.type}", spec, node)
          end

          def change_seq(spec, node)
            changing(:seq, spec, node) do |spec, node|
              node = change_node(spec, node)
              node = node.replace(change_children(spec, node)) if node.seq? && spec.seq?
              node
            end
          end

          def change_children(spec, node)
            node.map do |child|
              type = Spec.detect_type(nil, spec, child)
              change(type, child)
            end
          end

          def change_map(spec, node)
            changing(:map, spec, node) do |spec, node|
              node = change_node(spec, node)
              change_mappings(spec, node) if node.map? && spec.map?
              node
            end
          end

          def change_mappings(spec, parent)
            parent.keys.each do |key|
              next parent unless spec.map[key]
              next parent unless node = parent[key]
              changing(:mapping, spec, node) do |spec, node|
                type = Spec.detect_type(spec, spec.map[key], node)
                node = change(type, node)
                parent.set(key, node)
                node
              end
            end
          end

          def change_scalar(spec, node)
            changing(:scalar, spec, node) do |spec, node|
              change_node(spec, node)
            end
          end
          alias change_fixed change_scalar
          alias change_secure change_scalar

          def change_node(spec, node)
            type = node.is?(:mapping) ? :mapping : spec.type
            changes(spec, type).inject(node) do |node, (const, opts)|
              puts msg("-> change :#{const.name.split('::').last.downcase}", nil, spec, node) if DEBUG_CHANGES
              node = const.new(spec, node, opts.merge(ids: stack)).apply
              puts msg("<- change :#{const.name.split('::').last.downcase}", nil, spec, node) if DEBUG_CHANGES
              node
            end
          end

          def changes(spec, type)
            changes = CHANGES[type] || []
            changes = changes.map { |const| [const, ids: stack] }
            changes = changes.insert(1, *changes_from(spec)).compact
          end

          def changes_from(spec)
            spec.changes.map do |opts|
              [Change.const_get(camelize(opts[:name])), opts]
            end
          end

          def changing(type, spec, node, &block)
            changed = true
            node, changed = catching(spec, node) do
              break node if node.completed?
              puts msg('-> changing', type, spec, node) if DEBUG
              node = yield spec, node
              node.completed = true
              puts msg('<- changing', type, spec, node) if DEBUG
              node
            end while changed
            node
          end

          def catching(spec, node, &block)
            stack << node.id
            raise "Stack size to high: #{stack.size}" if stack.size >= MAX_STACK
            node, changed = catch(stack.last, &block)
            changed ? reset(node) : stack.pop
            [node, changed]
          end

          def reset(node)
            ix = stack.index(node.id)
            stack.slice!(ix..-1) if ix && ix > 0
          end

          def stack
            @stack ||= []
          end

          def msg(head, type, spec, node)
            [head, node.object_id, node.completed?.inspect, type, node.id, "is:#{node.type}", "should:#{spec.type}", node.raw.inspect].compact.join(' ')
          end
        end
      end
    end
  end
end
