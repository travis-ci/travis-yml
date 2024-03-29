require 'travis/yml/configs/config/file'

module Travis
  module Yml
    module Configs
      module Config
        class TravisYml < File
          def initialize(ctx, parent, slug, ref, mode = nil, provider = nil, vcs_id = nil)
            super(ctx, parent, vcs_id, provider, source: "#{slug}:.travis.yml@#{ref}", mode: mode)
          end

          def travis_yml?
            true
          end

          def serialize
            {
              source: to_s,
              config: raw,
              mode: nil
            }
          end
        end
      end
    end
  end
end
