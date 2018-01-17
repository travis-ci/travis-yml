require 'travis/yaml/doc/change/base'
require 'travis/yaml/doc/helper/match'

module Travis
  module Yaml
    module Doc
      module Change
        class Value < Base
          include Helper::Memoize

          def apply
            node = self.node
            node = fix? ? fix(node) : node
            node = dealias(node) if alias?(node)
            node
          end

          private

            def fix?
              node.str? && unknown?(node)
            end

            def fix(node)
              node = split(node) if split?(node)
              node = find(node)  if unknown?(node)
              node = clean(node) if unknown?(node) && clean?(node)
              node = node.drop   if node.value.empty?
              node
            end

            def split?(node)
              node.value.include?("\n")
            end

            def split(node)
              node.set(node.value.split("\n").first)
            end

            def find(node)
              return node unless other = Match.new(values, node.value).run
              node.warn :find_value, original: node.value, value: other
              node.set(other)
            end

            def clean?(node)
              node.value && cleaned(node)
            end

            def clean(node)
              other = cleaned(node)
              node.warn :clean_value, original: node.value, value: other
              node.set(other)
            end

            def cleaned(node)
              value = node.value.gsub(/\W/, '').downcase
              part  = node.value.split(' ').first.to_s
              detect(part, value, part.gsub(/[^a-z]/, ''))
            end

            def dealias(node)
              node.info :alias, alias: node.value, actual: aliased(node)
              node.set(aliased(node))
            end

            def alias?(node)
              !!aliased(node)
            end

            def aliased(node)
              value = spec.values.detect { |v| v.alias_for?(node.value) }
              value && value.to_s
            end

            def unknown?(node)
              !values.include?(node.value)
            end

            def values
              spec.values.map(&:known).flatten
            end
            memoize :values

            def detect(*strs)
              strs.detect { |str| values.include?(str) }
            end
        end
      end
    end
  end
end

