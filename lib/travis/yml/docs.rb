require 'travis/yml/docs/examples'
require 'travis/yml/docs/page'
require 'travis/yml/docs/schema'
require 'fileutils'

module Travis
  module Yml
    module Docs
      extend self, Helper::Obj, Page::Render

      DIR = 'public/docs'

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

      STATIC = %i(
        matrix_expansion
        types
        explore
      )

      def generate
        pages.each { |path, page| write(path, page) }
        puts
      end

      def write(path, page)
        path = '/home' if path == '/'
        file = "#{DIR}#{path}.html"
        FileUtils.mkpath(File.dirname(file))
        File.write(file, page.render(current: path, format: :html))
        print '.'
      end

      def pages
        @pages ||= begin
          root = self.root
          pages = root.pages # .uniq(&:full_id)
          pages = pages + statics
          pages = pages + [index(pages)]
          pages = pages.select(&:path)
          pages = pages.map { |page| [page.path, page] }
          pages = pages.to_h.sort.to_h
          pages = only(pages, :root).merge(except(pages, :root))
          pages
        end
      end

      def index(pages, opts = {})
        Page::Index.new(root, pages, opts)
      end

      def statics(opts = {})
        STATIC.map { |name| Page::Static.new(root, name, opts) }
      end

      def root(opts = {})
        Page.build(nil, nil, schema, opts)
      end

      def languages
        parent = schema[:language]
        schemas = Yml.schema[:definitions][:language]
        langs = schemas.map { |key, schema| Schema::Factory.build(parent, schema) }
        langs.reject(&:internal?).sort_by(&:title)
      end

      def schema
        @schema ||= Schema::Factory.build(nil, Yml.schema)
      end
    end
  end
end
