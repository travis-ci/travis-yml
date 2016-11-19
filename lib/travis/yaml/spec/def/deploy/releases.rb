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
              map :user,           to: :scalar, cast: :secure
              map :password,       to: :scalar, cast: :secure
              map :api_key,        to: :scalar, cast: :secure
              map :repo,           to: :scalar
              map :file,           to: [:seq, :scalar]
              map :file_glob,      to: :scalar
              map :overwrite,      to: :scalar
              map :release_number, to: :scalar, alias: :'release-number'
            end
          end
        end
      end
    end
  end
end
