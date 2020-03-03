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
              map :username,           to: :secure, strict: false, alias: :user
              map :password,           to: :secure
              map :token,              to: :secure, alias: :api_key
              map :repo,               to: :str
              map :file,               to: :seq
              map :file_glob,          to: :bool
              map :overwrite,          to: :bool

              map :draft,              to: :bool
              map :name,               to: :str
              map :prerelease,         to: :bool
              map :release_number,     to: :str
              map :release_notes,      to: :str, alias: :body
              map :release_notes_file, to: :str
              map :tag_name,           to: :str
              map :target_commitish,   to: :str
            end
          end
        end
      end
    end
  end
end
