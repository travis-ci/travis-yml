require 'travis/yml/docs/examples'
require 'travis/yml/docs/page'
require 'travis/yml/docs/schema'

module Travis
  module Yml
    module Docs
      extend self, Helper::Obj

      HIDE = %i(
        arch
        env_var
        env_vars
        import
        matrix_entries
        matrix_entry
        os
        service
        stage
        tree
      )

      def menu(opts)
        Page::Menu.new(pages, opts).render
      end

      def pages(opts = {})
        @pages ||= begin
          root = self.root(opts)
          pages = root.pages.uniq(&:full_id)
          pages = pages + [static(:types, opts), static(:flags, opts)]
          pages = pages.map { |page| [page.full_id, page] }
          pages = pages.to_h.sort.to_h
          pages = pages.merge('index' => index(pages, opts), 'tree' => tree(root, opts))
          pages = only(pages, :root).merge(except(pages, :root))
          pages
        end
      end

      def index(pages, opts)
        Page::Index.new(pages.values.flatten, opts)
      end

      def tree(root, opts)
        Page::Tree.new(root, opts)
      end

      def static(name, opts)
        Page::Static.new(name, opts)
      end

      def root(opts = {})
        Page.build(schema, opts)
      end

      def schema
        @schema ||= Schema::Factory.build(nil, Yml.schema)
      end
    end
  end
end
