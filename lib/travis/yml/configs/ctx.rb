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

        def data
          super || {}
        end

        def error(*msg)
          msg(:error, *msg)
        end

        def msg(*msg)
          msgs << msg
        end

        def msgs
          fetch.msgs
        end
      end
    end
  end
end
