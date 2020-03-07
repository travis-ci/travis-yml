require 'travis/yml/configs/config/base'
require 'travis/yml/configs/config/travis_yml'

module Travis
  module Yml
    module Configs
      module Config
        class Api < Struct.new(:ctx, :slug, :ref, :raw, :mode)
          include Base, Memoize

          attr_reader :parent, :path

          def api?
            true
          end

          def load(&block)
            super
            @config = parse(raw)
            store
            loaded
          end

          def imports
            return [] if mode == :replace
            imports = super
            imports.any? ? imports : [travis_yml]
          end
          memoize :imports

          def source
            'api'
          end

          def mode
            @mode ||= super || config.delete(:merge_mode) || config.delete(:mode)
          end

          def to_s
            source
          end

          private

            def import
              { source: source }
            end

            def travis_yml
              TravisYml.new(ctx, self, repo.slug, ref, mode)
            end
        end
      end
    end
  end
end
