require 'travis/yml/configs/config/base'
require 'travis/yml/configs/config/travis_yml'

module Travis
  module Yml
    module Configs
      module Config
        class Api < Struct.new(:ctx, :parent, :slug, :ref, :raw, :mode, :inputs)
          include Base, Memoize

          attr_reader :path, :input

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
              @child ||= inputs&.any? ? api : travis_yml
            end

            def import
              { source: source }
            end

            def api
              input = inputs.shift
              raw, mode = input.values_at(:config, :mode) # merge_ ??
              Api.new(ctx, self, slug, ref, raw, mode, inputs)
            end

            def travis_yml
              TravisYml.new(ctx, self, slug, ref, mode)
            end
        end
      end
    end
  end
end
