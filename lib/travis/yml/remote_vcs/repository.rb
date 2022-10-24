require 'travis/yml/remote_vcs/client'

module Travis
  module Yml
    module RemoteVcs
      class Repository < Client
        def content(id:, path:, ref:)
          logger.info("RemoteVcs Repository #{id}, #{path}")
          request(:get, __method__) do |req|
            req.url "repos/#{id}/contents/#{path}"
            req.params['ref'] = ref
          end
        end
      end
    end
  end
end
