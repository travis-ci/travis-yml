require 'erb'
require 'redcarpet'

module Travis
  module Yml
    module Docs
      module Page
        module Render
          def render(*args)
            opts = args.last.is_a?(Hash) ? args.pop : {}
            opts = self.opts.merge(opts)
            name = args.pop
            html = content(name, opts)
            html = layout(html, opts) if layout?(name, opts)
            html
          end

          def layout?(name, opts)
            opts[:format] == :html && (name.nil? || opts[:layout])
          end

          def layout(content, opts)
            ERB.new(tpl(:layout), nil, '-').result_with_hash(
              content: formatted(content, opts[:format]),
              menu: formatted(menu, opts[:format])
            )
          end

          def content(name, opts)
            name ||= self.class.name.split('::').last.downcase
            scope = binding
            opts.each { |key, value| scope.local_variable_set(key, value) }
            ERB.new(tpl(name), nil, '-').result(scope)
          end

          def menu
            Page::Menu.new(opts.merge(current: path)).render
          end

          def tpl(name)
            File.read(Dir[File.expand_path("../../tpl/#{name}.*", __FILE__)].first)
          end

          def formatted(str, format)
            case format
            when :html
              markdown.render(str)
            else
              str
            end
          end

          def markdown
            renderer = Redcarpet::Render::HTML.new(with_toc_data: true)
            Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
          end
        end
      end
    end
  end
end
