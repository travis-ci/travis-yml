require 'travis/yml/configs/errors'

module Travis
  module Yml
    module Configs
      class Ref < Struct.new(:str, :opts)
        include Errors

        REMOTE = %r(^([^/]+/[^/]+):(.+?.yml)(?:@(.+))?$)
        LOCAL  = %r(^(.+.yml)(?:@([^@]+))?$)

        attr_reader :parts, :repo, :path, :ref

        def initialize(str, opts = {})
          super(str, opts || {})
          parse
        end

        def to_s
          "#{repo}:#{path}@#{ref}"
        end

        private

          def parse
            repo, path, ref = remote || local || invalid_ref(str.to_s)
            @repo = repo || opts[:repo]
            @path = expand_path(path)
            @ref = ref || opts[:ref]
            @parts = [@repo, @path, @ref]
          end

          def local
            str =~ LOCAL && [nil, $1, $2]
          end

          def remote
            str =~ REMOTE && [$1, $2, $3]
          end

          PATH = "#{::File.expand_path('.')}/"

          def expand_path(path)
            return path unless path&.start_with?('./') && dir
            ::File.expand_path(path, dir).sub(PATH, '')
          end

          def dir
            ::File.dirname(opts[:path]) if opts[:path]
          end
      end
    end
  end
end
