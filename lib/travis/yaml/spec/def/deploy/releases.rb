# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
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
              super
              map :user,           to: :str, secure: true
              map :password,       to: :str, secure: true
              map :api_key,        to: :str, secure: true
              map :repo,           to: :str
              map :file,           to: [:seq, :scalar]
              map :file_glob,      to: :str
              map :overwrite,      to: :str
              map :release_number, to: :str
              map :prerelease,     to: :bool
            end
          end
        end
      end
    end
  end
end
