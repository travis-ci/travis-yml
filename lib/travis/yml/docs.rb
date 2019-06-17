require 'travis/yml/docs/examples'
require 'travis/yml/docs/page'
require 'travis/yml/docs/schema'

module Travis
  module Yml
    module Docs
      extend self, Helper::Obj

      def menu(opts)
        Page::Menu.new(pages, opts).render
      end

      def pages(opts = {})
        @pages ||= begin
          pages = root(opts).pages.uniq(&:full_id)
          pages = pages + [static(:types, opts), static(:flags, opts)]
          pages = pages.map { |page| [page.full_id, page] }
          pages = pages.to_h.sort.to_h
          pages = pages.merge('index' => index(pages, opts))
          pages = only(pages, :root).merge(except(pages, :root))
          pages
        end
      end

      def index(pages, opts)
        Page::Index.new(pages.values.flatten, opts)
      end

      def static(name, opts)
        Page::Static.new(name, opts)
      end

      def root(opts = {})
        schema = Schema::Factory.build(nil, Yml.schema)
        Page.build(schema, opts)
      end
    end
  end
end
