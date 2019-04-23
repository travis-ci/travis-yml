# frozen_string_literal: true
# require 'travis/yml/doc/value/support'
require 'travis/yml/doc/value/factory'

module Travis
  module Yml
    module Doc
      module Value
        class Node < Obj.new(:parent, :key, :value, :opts)
          include Factory

          attr_writer :key, :value, :completed

          # def completed?
          #   !!@completed
          # end

          def root
            @root ||= root? ? self : parent.root
          end

          def root?
            parent.nil?
          end

          def parent=(parent)
            @id = nil
            @parent = parent
          end

          def key=(key)
            @id = nil
            @key = key
          end

          def type
            opts[:type]
          end

          def is?(type)
            self.type == type
          end

          def map?
            is?(:map)
          end

          def mapping?
            is?(:mapping)
          end

          def seq?
            is?(:seq)
          end

          def scalar?
            false
          end

          def secure?
            is?(:secure)
          end

          def str?
            is?(:str)
          end

          def num?
            is?(:num)
          end

          def bool?
            is?(:bool)
          end

          def none?
            is?(:none)
          end

          def given?
            present?(value) || false?(value)
          end

          def missing?
            blank?(value) && !false?(value)
          end

          # SUPPORTING = [:language, :os]
          #
          # def supporting
          #   parent ? parent.supporting : opts[:supporting] || {}
          # end

          def alert?
            enabled?(:alert)
          end

          def enabled?(key)
            !!opts[key]
          end

          def debug(code, *args)
            msg(:debug, code, *args)
          end

          def info(code, *args)
            msg(:info, code, *args)
          end

          def warn(code, *args)
            msg(:warn, code, *args)
          end

          def error(code, *args)
            @errored = true
            msg(:error, code, *args)
          end

          def alert(code, *args)
            msg(:alert, code, *args)
          end

          def errored?
            !!@errored
          end

          def msg(level, code, args = [])
            msg = [level, full_key, code]
            msg << args unless args.empty?
            root.msgs << msg unless root.msgs.include?(msg)
            self
          end

          def msgs
            opts[:msgs] ||= []
          end

          def full_key(ext = true)
            root? ? :root : full_keys.join('.').to_sym
          end

          def full_keys
            root? ? [] : [*parent.full_keys, key].uniq
          end

          def walk(level = 0)
            yield self, level
          end

          def opts
            @opts ||= {}
          end

          def supporting
            parent ? parent.supporting : {} # opts[:supporting] || ...
          end

          def serialize
            value
          end

          def id
            @id ||= ancestors.map { |node| node.key }.flatten.compact.join('.').to_sym
          end

          def inspect
            type = self.class.name.sub('Travis::Yml::Doc::', '')
            pairs = compact(
              parent: parent ? [parent.type, parent.key].compact.join(':') : nil,
              key: key,
              value: value.inspect,
              msgs: msgs.any? ? msgs.inspect : nil
            )
            '#<%s %s>' % [type, pairs.map { |pair| pair.join('=') }.join(' ')]
          end

          # def verify_parents
          #   walk do |node, level|
          #     case node.type
          #     when :map
          #       node.each { |key, child| puts "#{' ' * (level * 2)}#{child.key} #{[node.object_id, child.parent.object_id] unless node.object_id == child.parent.object_id}" }
          #     when :seq
          #       node.each { |child| puts "#{' ' * (level * 2)}#{child.key} #{[node.object_id, child.parent.object_id] unless node.object_id == child.parent.object_id}" }
          #     end
          #   end
          #   puts
          # end
        end
      end
    end
  end
end
