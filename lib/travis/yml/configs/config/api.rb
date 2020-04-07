require 'travis/yml/configs/config/base'
require 'travis/yml/configs/config/travis_yml'

module Travis
  module Yml
    module Configs
      module Config
        class Api < Struct.new(:ctx, :parent, :slug, :ref, :raw, :mode, :defns)
          include Base, Memoize

          attr_reader :path, :input

          def initialize(ctx, parent, slug, ref, defns)
            defn = defns.shift
            raw, mode = defn.values_at(:config, :mode)
            super(ctx, parent, slug, ref, raw, mode, defns)
          end

          def api?
            true
          end

          def load(&block)
            @config = parse(raw)
            self.mode ||= config.delete('merge_mode') # || config.merge_mode
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
            ['api', ix > 0 ? ix : nil].compact.join('.')
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
            {
              source: to_s,
              config: raw,
              mode: mode
            }
          end

          private

            def child
              @child ||= defns&.any? ? api : travis_yml
            end

            def defn
              { source: source }
            end

            def api
              Api.new(ctx, self, slug, ref, defns)
            end

            def travis_yml
              TravisYml.new(ctx, self, slug, ref, mode)
            end
        end
      end
    end
  end
end
