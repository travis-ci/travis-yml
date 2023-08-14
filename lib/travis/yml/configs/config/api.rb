require 'travis/yml/configs/config/base'
require 'travis/yml/configs/config/travis_yml'

module Travis
  module Yml
    module Configs
      module Config
        class Api < Struct.new(:ctx, :parent, :slug, :ref, :defns, :mode, :provider, :vcs_id)
          include Base, Memoize

          attr_reader :defn, :path, :input

          def initialize(ctx, parent, slug, ref, defns, mode = nil, provider = nil, vcs_id = nil)
            super(ctx, parent, slug, ref, defns, mode, provider, vcs_id)
            @defn = defns.shift
            defn.update(source: source)
          end

          def raw
            defn[:config]
          end

          def api?
            true
          end

          def load(&block)
            @config = parse(raw)
            defn[:mode] ||= config.delete('merge_mode')
            super
            store
            loaded
          end

          def imports
            imports = super
            imports << child unless child.merge_modes[:lft] == 'replace'
            imports
          end
          memoize :imports

          def merge_modes
            { lft: mode }
          end

          def source
            ['api', child.api? || ix > 0 ? ix + 1 : nil].compact.join('.')
          end

          def part
            Parts::Part.new(raw, source, merge_modes)
          end

          def empty?
            raw.to_s.strip.empty?
          end

          def ix
            @ix ||= parents.select(&:api?).size
          end

          def to_s
            source
          end

          def serialize
            defn
          end

          private

            def child
              @child ||= defns&.any? ? api : travis_yml
            end

            def api
              Api.new(ctx, self, slug, ref, defns, defn[:mode], provider)
            end

            def travis_yml
              TravisYml.new(ctx, self, slug, ref, defn[:mode], provider)
            end
        end
      end
    end
  end
end
