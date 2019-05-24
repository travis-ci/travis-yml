# # root
#
# language: one of [languages](/def/languages)
# os: [os](/def/os)
# dist: [dist](/def/dist)
# arch: [arch](/def/arch)
# matrix: [matrix](/def/matrix) alias jobs
#
#
# # matrix
#
# Alias: jobs
#
# Known on: root
#
# Types:
#
# * [matrix entries](/def/matrix_entries)
# * A map as defined below.
#
# If given a map the following keys are known:
#
# include: jobs to include to the matrix: [matrix entries](/def/matrix_entries)
# exclude: jobs to exclude from the matrix: ...
# allow_failures: jobs allowed to fail without failing the build ... (see [link to docs])
# fast_finish: whether to fast finish the build (see [link to docs])

require 'forwardable'
require 'yaml'
require 'travis/yml/schema'

module Travis
  module Yml
    module Docs
      module Page
        extend self

        def build(schema)
          const_get(schema.class.name.split('::').last).new(schema)
        end

        class Base < Obj.new(:node)
          extend Forwardable

          def_delegators :node, :id, :root?

          BASE_TYPES = %i(strs)

          def path
            "/v1/docs/#{id}" if id && !base_type?
          end

          def base_type?
            BASE_TYPES.include?(id)
          end

          def render(name = nil, opts = {})
            name ||= self.class.name.split('::').last.downcase
            scope = binding
            opts.each { |key, value| scope.local_variable_set(key, value) }
            ERB.new(tpl(name), nil, '-').result(scope)
          end

          def tpl(name)
            File.read(File.expand_path("../tpl/#{name}.erb.md", __FILE__))
          end

          def info
            info = [summary]
            info << '(deprecated)' if deprecated?
            info << "[details](#{path})" if path
            info.join(' ')
          end

          def title
            root? ? 'Root' : node.title
          end

          def description
            node.description || "(describe #{id})"
          end

          def summary
            node.summary || "(summarize #{id})"
          end

          def examples
            []
          end

          def flags
            node.flags
          end

          def deprecated?
            node.deprecated?
          end

          def internal?
            node.internal?
          end

          DISPLAY_TYPES = {
            seq: 'Sequence of %ss',
            map: 'Map',
            str: 'String',
            num: 'Number',
            bool: 'Boolean'
          }

          def display_type
            DISPLAY_TYPES[node.type]
          end

          def pages
            [self]
          end

          def walk(obj = nil, &block)
            yield *[obj].compact, self if id && !internal?
            obj
          end

          def build(schema)
            Page.build(schema)
          end

          def indent(str, width)
            strs = str.split("\n")
            [strs.shift, strs.map { |str| (' ' * width * 2) + str }].join("\n")
          end

          def yaml(obj)
            obj = stringify(obj)
            yml = YAML.dump(obj)
            yml = yml.sub(/^--- ?/, '')
            yml = yml.sub("...\n", '')
            yml = yml.sub("'on'", 'on')
            yml.strip
          end

          def inspect
            'page'
          end
        end

        class Any < Base
          def types
            node.schemas.map(&:types).flatten
          end

          def display_types
            types.map { |node| build(node).display_type }
          end

          def mappings
            return unless node = types.detect { |schema| schema.type == :map }
            node.mappings.map { |key, schema| [key, build(schema)] }.to_h
          end

          def examples
            Yml::Schema::Examples.build(node).examples.map do |example|
              # key = node.key || node.namespace
              node.key ? { node.key => example } : example
            end
          end
        end

        class Seq < Base
          def display_type
            DISPLAY_TYPES[:seq] % build(node.schema).display_type.downcase
          end
        end

        class Map < Base
          include Enumerable

          def_delegators :mappings, :each, :[]

          attr_reader :includes, :mappings

          def initialize(node)
            @mappings = node.map { |key, schema| [key, build(schema)] }.to_h
            @includes = node.includes.map { |schema| build(schema) }
            super
          end

          def render(name = :map, opts = {})
            super
          end

          def walk(obj = nil, &block)
            yield *[obj].compact, self
            mappings.each { |_, page| page.walk(*[obj].compact, &block) }
            obj
          end
        end

        class Secure < Base
        end

        class Scalar < Base
        end
      end
    end
  end
end
