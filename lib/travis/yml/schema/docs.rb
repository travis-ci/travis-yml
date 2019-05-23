require 'erb'
require 'fileutils'
require 'yaml'

module Travis
  module Yml
    module Schema
      TYPES = {
        seq:  'Array of: %s',
        map:  'Hash',
        enum: 'String (known)',
        str:  'String',
        num:  'Number',
        bool: 'Boolean'
      }

      FLAGS = {
        expand: 'This is a [matrix expansion key](/matrix_expansion).'
      }

      module Docs
        class Page < Obj.new(:node)
          TPL = ERB.new(<<~erb, nil, '-')
            # <%= node.title %>

            <%= node.description %>

            ## Types

            <% types.each do |name| -%>
            * <%= type(name) %>
            <% end -%>

            <% if values.any? -%>
            ## Values

            <% values.each do |value| -%>
            * `<%= value %>`
            <% end -%>
            <% end -%>

            <% if node.flags? -%>
            ## Flags

            <% node.flags.each do |flag| %>
            * <%= flag %>
            <% end -%>
            <% end -%>

            <% if examples.any? -%>
            ## Examples
            <% examples.each do |example| %>
            ```yaml
            <%= indent(yaml(example), 0) %>
            ```
            <% end -%>
            <% end -%>
          erb

          def render
            TPL.result(binding)
          end

          def type(node)
            node.seq? ? TYPES[:seq] % TYPES[node.types.first.type] : TYPES[node.type]
          end

          def values
            node = types.detect(&:enum?)
            node ? node.enum : []
          end

          def flag(flag)
            "#{flag.to_s.capitalize}: #{FLAGS[flag]}"
          end

          def types
            @expanded ||= Type.expand(node)
          end

          def examples
            return [] unless node.is?(:any)
            @examples ||= Schema::Examples.build(node).examples.map do |example|
              key = node.key || node.namespace
              key ? { key => example } : example
            end
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

          def write
            FileUtils.mkdir_p(dir)
            File.write(path, render)
          end

          def path
            @path ||= "#{dir}/#{node.id}.md"
          end

          def dir
            "public/docs/#{node.namespace}"
          end
        end

        class Index < Page
          def render
            node.map do |node|
              "* [#{node.title}](/v1/docs/#{node.namespace}/#{node.id})"
            end.join("\n")
          end

          def path
            "#{dir}/index.md"
          end

          def dir
            'public/docs/'
          end
        end

        extend self
        extend Helper::Obj

        def write
          pages.each(&:write)
          index.write
        end

        def print
          puts generate
        end

        def generate
          pages.map(&:render)
        end

        def pages
          nodes.map { |node| Page.new(node) }
        end

        def index
          Index.new(nodes)
        end

        def nodes
          nodes = Schema.exports
          # nodes = Schema::Type.exports.values.map(&:values).flatten
          nodes = nodes.reject(&:internal?)
          nodes = sort(nodes)
          nodes
        end

        ORDER = [:type, :addon, :deploy, :language, :notification]

        def sort(nodes)
          nodes = nodes.sort do |lft, rgt|
            order = ix(lft) <=> ix(rgt)
            order = lft.id <=> rgt.id if order == 0
            order || 0
          end
        end

        def ix(node)
          ORDER.index(node.namespace)
        end
      end
    end
  end
end
