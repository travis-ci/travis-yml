require 'travis/yaml/helper/common'
require 'travis/yaml/doc/value/support'
require 'travis/yaml/support/obj'

module Travis
  module Yaml
    module Doc
      module Value
        class Node < Obj.new(:parent, :key, :value, :opts)
          include Helper::Common

          attr_writer :parent, :key, :completed

          def completed?
            !!@completed
          end

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
            is?(:scalar)
          end

          def secure?
            is?(:secure)
          end

          def str?
            super(value)
          end

          def bool?
            super(value)
          end

          def blank?
            !present?
          end

          def alert?
            !!opts[:alert]
          end

          SUPPORTING = [:language, :os]

          def supporting
            parent ? parent.supporting : opts[:supporting] || {}
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
            msg(:error, code, *args)
            @errored = true
            node = drop
            node
          end

          def errored?
            !!@errored
          end

          def msg(level, code, args = [])
            msg = [level, full_key, code]
            msg << args unless args.empty?
            root.msgs << msg unless root.msgs.include?(msg)
          end

          def msgs
            opts[:msgs] ||= []
          end

          def full_key
            ancestors.map(&:key).uniq.join('.').sub('root.', '').to_sym
          end

          def id
            @id ||= ancestors.map { |node| node.key }.flatten.compact.join('.').to_sym
          end

          def ancestors
            ancestors = parent.respond_to?(:ancestors) ? parent.ancestors : []
            ancestors + [self]
          end

          def opts
            @opts ||= {}
          end

          def inspect
            "#<#{self.class.name} parent=#{parent ? [parent.type, parent.key].join(':') : 'nil' } key=#{key.inspect} value=#{value.inspect}>"
          end

          def walk(level = 0)
            yield self, level
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
