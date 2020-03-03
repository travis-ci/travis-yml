# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class GitPush < Deploy
            register :git_push

            def define
              map :token,              to: :secure, alias: :github_token
              map :deploy_key,         to: :str
              map :repo,               to: :str
              map :branch,             to: :str
              map :base_branch,        to: :str
              map :commit_message,     to: :str
              map :allow_empty_commit, to: :bool
              map :allow_same_branch,  to: :bool
              map :force,              to: :bool
              map :local_dir,          to: :str
              map :name,               to: :str
              map :email,              to: :str
              map :host,               to: :str
              map :enterprise,         to: :bool
            end
          end
        end
      end
    end
  end
end
