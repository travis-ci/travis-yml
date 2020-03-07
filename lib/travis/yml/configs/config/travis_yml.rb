require 'travis/yml/configs/config/file'

module Travis
  module Yml
    module Configs
      module Config
        class TravisYml < File
          def initialize(ctx, parent, slug, ref, mode)
            super(ctx, parent, source: "#{slug}:.travis.yml@#{ref}", mode: mode)
          end

          def travis_yml?
            true
          end
        end
      end
    end
  end
end
