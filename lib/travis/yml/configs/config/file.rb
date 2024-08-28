require 'cgi'
require 'travis/yml/configs/content'
require 'travis/yml/configs/config/base'

module Travis
  module Yml
    module Configs
      module Config
        class File < Obj.new(:ctx, :parent, :vcs_id, :provider, :defn)
          include Base

          attr_reader :path, :ref, :raw

          PERMITTED_KEYS = %w(commit_message).freeze

          def initialize(ctx, parent, vcs_id, provider, defn)
            defn = stringify(defn)
            @vcs_id = vcs_id
            super
          end

          def vcs_id
            if parent.nil? || (!parent.nil? && parent.repo.slug == slug)
              @vcs_id
            else
              slug
            end
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
            "#{repo.slug}:#{path}@#{ref}"
          end

          def serialize
            {
              source: to_s,
              config: raw,
              mode: defn['mode']
            }
          end

          private

            def path_suffix
              return '' if repo.vcs_type != 'AssemblaRepository'

              branch_name = ctx.data[:branch] || repo.default_branch

              case ctx.data[:server_type]
              when 'subversion'
                if branch_name == 'trunk'
                  "#{branch_name}/"
                elsif !ctx.data[:tag].nil?
                  "tags/#{branch_name}/"
                else
                  "branches/#{branch_name}/"
                end
              when 'perforce'
                "//depot/#{branch_name}/"
              end
            end

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
              new_path = path.gsub(/%{(#{PERMITTED_KEYS.join('|')}|.*)}/) { CGI.escape(ctx.data[$1.to_sym]) }

              "#{path_suffix}#{new_path}"
            end
        end
      end
    end
  end
end
