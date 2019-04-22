require 'erb'

module Travis
  module Yml
    TYPES = {
      any:  "Any of:\n\n%s",
      seq:  'Sequence (Array)',
      map:  'Map (Hash)',
      enum: 'Enum (known String)',
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

          ## Type

          <%= type(node) %>

          ## Flags

          <% if node.flags? -%>
          <% node.flags.each do |name| %>* <%= flag(name) %><% end %>
          <% else -%>
          None.
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

        # types would have to be expanded/flattened similar to what Examples does
        def type(node)
          node = node.lookup if node&.ref?
          return unless node # ??
          case node.type
          when :any then TYPES[:any] % node.map { |node| "* #{type(node)}" }.join("\n")
          else TYPES[node.type]
          end
        end

        def flag(flag)
          "#{flag.to_s.capitalize}: #{FLAGS[flag]}"
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
      end

      extend self
      extend Helper::Obj

      def write
        pages.map do |name, page|
          File.write(path(name), page)
        end
        File.write(path(:index), index)
      end

      def path(name)
        "public/#{name}.md"
      end

      def pages
        nodes.map do |node|
          [[node.namespace, node.id].join('/'), Page.new(node).render]
        end
      end

      def index
        nodes.map do |node|
          "* [#{node.title}](/#{node.namespace}/#{node.id}]"
        end.join("\n")
      end

      def nodes
        Schema.schema
        nodes = Schema::Type::Node.exports.values
        nodes = nodes.reject(&:internal?)
        # nodes = [Schema::Def::Stages.new.node.lookup]
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
