require 'travis/yml/configs/fetch'

module Travis
  module Yml
    module Configs
      class Ctx < Struct.new(:data, :opts)
        def fetch
          @fetch ||= Fetch.new(self)
        end

        def repos
          @repos ||= Model::Repos.new
        end

        def internal?
          !!opts[:internal]
        end

        def user_token
          opts[:token]
        end

        def data
          super || {}
        end
      end
    end
  end
end
