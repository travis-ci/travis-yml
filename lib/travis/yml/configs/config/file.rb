require 'travis/yml/configs/github/content'
require 'travis/yml/configs/config/base'

module Travis
  module Yml
    module Configs
      module Config
        class File < Struct.new(:ctx, :parent, :import)
          include Base

          attr_reader :path, :ref, :raw

          def load(&block)
            super
            _, @path, @ref = expand(source)
            return unless validate
            @raw = fetch
            @config = parse(raw)
            store
          rescue InvalidRef => e
            error :import, :invalid_ref, ref: e.message
          ensure
            loaded
          end

          def source
            import[:source]
          end

          def slug
            @slug ||= Ref.new(source).repo || parent.repo.slug
          end

          def mode
            import[:mode]&.to_sym
          end

          def to_s
            "#{repo.slug}:#{path}@#{ref}"
          end

          private

            def expand(source)
              ref = local? ? parent&.ref : repo.default_branch
              ref = Ref.new(source, repo: repo.slug, ref: ref, path: parent&.path)
              ref.parts
            end

            def fetch
              Github::Content.new(repo, path, ref).content
            rescue FileNotFound => e
              required? ? raise : nil
            end
        end
      end
    end
  end
end
