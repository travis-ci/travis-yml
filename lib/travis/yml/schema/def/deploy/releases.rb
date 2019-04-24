# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # TODO Additionally, options can be passed to Octokit client. These are documented in
          # https://github.com/octokit/octokit.rb/blob/master/lib/octokit/client/releases.rb
          #
          # docs do not mention repo
          # docs do not mention file_glob
          # docs do not mention overwrite
          # docs do not mention release-number
          class Releases < Deploy
            register :releases

            def define
              map :user,           to: :secure
              map :password,       to: :secure
              map :api_key,        to: :secure
              map :repo,           to: :str
              map :file,           to: :seq
              map :file_glob,      to: :bool
              map :overwrite,      to: :bool
              map :release_number, to: :str
              map :prerelease,     to: :bool
            end
          end
        end
      end
    end
  end
end
