require 'travis/yml/docs/page'
require 'travis/yml/docs/schema'

module Travis
  module Yml
    module Docs
      extend self, Helper::Obj

      def index
        pages.map do |_, page|
          "* [#{page.title}](/v1/docs/#{page.id})" # #{page.namespace}/
        end.join("\n")
      end

      def pages
        @pages ||= begin
          pages = root.walk([]) { |pages, node| pages << node.pages }
          pages = pages.flatten.map { |page| [page.id.to_s, page] }
          pages = pages.sort.to_h
          only(pages, :root).merge(except(pages, :root))
        end
      end

      def root
        schema = Schema::Factory.build(nil, Yml.schema)
        Page.build(schema)
      end
    end
  end
end
