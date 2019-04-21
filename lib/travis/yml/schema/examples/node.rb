# frozen_string_literal: true
require 'registry'

module Travis
  module Yml
    module Schema
      module Examples
        def self.build(node, opts = {})
          Node[node.type].new(node, opts)
        end

        class Node < Obj.new(:node, opts: {})
          include Memoize, Registry

          def build(*args)
            Examples.build(*args)
          end

          def key
            opts[:key]
          end

          def examples
            raise
          end

          def expand
            self
          end

          def yaml
            examples.map do |example|
              to_yaml(example)
            end
          end

          def to_yaml(obj)
            obj = symbolize(obj)
            yml = YAML.dump(obj)
            yml = yml.sub(/^--- ?/, '')
            yml = yml.sub("...\n", '')
            yml = yml.sub("'on'", 'on')
            yml = yml.strip
          end
        end
      end
    end
  end
end
