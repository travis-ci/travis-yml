require 'cgi'
require 'travis/yml/configs/content'
require 'travis/yml/configs/config/base'

module Travis
  module Yml
    module Configs
      module Config
        class File < Obj.new(:ctx, :parent, :provider, :defn)
          include Base

          attr_reader :path, :ref, :raw

          PERMITTED_KEYS = %w(commit_message).freeze

          def initialize(ctx, parent, provider, defn)
            defn = stringify(defn)
            super
          end

          def load(&block)
            super
            _, @path, @ref = expand(source)
            return unless validate
            @raw = fetch
            @config = parse(raw)
            store
          rescue ApiError
            raise
          rescue InvalidRef => e
            error :import, :invalid_ref, ref: e.message
          rescue Error => e
            raise e.class.new(e.message, e.data.merge(source: to_s))
          ensure
            loaded
          end

          def source
            defn['source']
          end

          def slug
            @slug ||= Ref.new(source).repo || parent.repo.slug
          end

          def merge_modes
            { lft: defn['mode'] || :deep_merge_append }
          end

          def part
            Parts::Part.new(raw, source, merge_modes)
          end

          def empty?
            raw.to_s.strip.empty?
          end

          def to_s
            "#{repo.slug}:#{interpolated_path}@#{ref}"
          end

          def serialize
            {
              source: to_s,
              config: raw,
              mode: defn['mode']
            }
          end

          private

            def expand(source)
              ref = local? ? parent&.ref : repo.default_branch
              ref = Ref.new(source, repo: repo.slug, ref: ref, path: parent&.path)
              ref.parts
            end

            def fetch
              Content.new(repo, interpolated_path, ref).content
            rescue FileNotFound => e
              required? ? raise : nil
            end

            def interpolated_path
              path.gsub(/%{(#{PERMITTED_KEYS.join('|')}|.*)}/) { CGI.escape(ctx.data[$1.to_sym]) }
            end
        end
      end
    end
  end
end
