require 'travis/yaml/doc/conform/alert'
require 'travis/yaml/doc/conform/alias'
require 'travis/yaml/doc/conform/cast'
require 'travis/yaml/doc/conform/default'
require 'travis/yaml/doc/conform/downcase'
require 'travis/yaml/doc/conform/empty'
require 'travis/yaml/doc/conform/edge'
require 'travis/yaml/doc/conform/flagged'
require 'travis/yaml/doc/conform/format'
require 'travis/yaml/doc/conform/incompatible'
require 'travis/yaml/doc/conform/invalid_type'
require 'travis/yaml/doc/conform/matrix'
require 'travis/yaml/doc/conform/pick'
require 'travis/yaml/doc/conform/required'
require 'travis/yaml/doc/conform/template'
require 'travis/yaml/doc/conform/unknown_keys'
require 'travis/yaml/doc/conform/unknown_value'
require 'travis/yaml/doc/conform/unsupported'
require 'travis/yaml/helper/common'

module Travis
  module Yaml
    module Doc
      module Conform
        CONFORM = {
          normalize: {
            fixed: %i(
              downcase
              alias
            ),
            seq: %i(
              default
            )
          },
          prepare: {
            node: %i(
            ),
            scalar: %i(
              pick
              cast
              downcase
            ),
          },
          validate: {
            node: %i(
              required
              unsupported
              edge
              flagged
            ),
            scalar: %i(
              default
              invalid_type
              alert
              format
            ),
            fixed: %i(
              alias
              incompatible
              unknown_value
            ),
            map: %i(
              unknown_keys
              invalid_type
              empty
            ),
            seq: %i(
              default
              empty
            )
          },
        }

        STAGES = %i(normalize prepare validate)

        def self.apply(node)
          STAGES.each do |stage|
            Stage.new(stage, node).run
          end
        end

        $count = 0

        class Stage < Struct.new(:stage, :node)
          include Helper::Common

          def run
            apply_children if node.respond_to?(:children)
            apply
          end

          def apply_children
            node.children.each { |node| Stage.new(stage, node).run }
          end

          # $count = 0
          def apply
            conforms.each do |conform|
              # p $count += 1
              conform.apply if conform.apply?
            end
          end

          def conforms
            default + custom
          end

          def custom
            return [] unless opts = node.opts[:conform]
            opts = opts.select { |opts| opts[:stage] == stage }
            opts.map { |opts| Conform[opts[:name]].new(node, opts) }
          end

          def default
            names = self.names.map { |name| CONFORM[stage][name] }.compact.flatten
            names.map { |name| Conform[name].new(node) }
          end

          def names
            consts = node.class.ancestors
            consts = consts.select { |const| const.respond_to?(:registry_key) }
            consts.map(&:registry_key).compact << :node
          end
        end
      end
    end
  end
end
