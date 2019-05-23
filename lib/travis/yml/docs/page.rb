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
            "/ref/#{id}" if id
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

          def title
            root? ? 'Root' : node.title
          end

          def description
            node.description || "(describe #{id})"
          end

          def summary
            node.summary || "(summarize #{id})"
          end

          def walk(&block)
            yield self if id
          end

          def build(schema)
            Page.build(schema)
          end

          def inspect
            'page'
          end
        end

        class Any < Base
        end

        class Seq < Base
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

          def walk(&block)
            yield self
            mappings.each { |_, page| page.walk(&block) }
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
