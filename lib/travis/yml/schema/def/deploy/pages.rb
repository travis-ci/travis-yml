# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # docs do not mention pages
          class Pages < Deploy
            register :pages

            def define
              map :github_token,       to: :secure
              map :repo,               to: :str
              map :target_branch,      to: :str
              map :local_dir,          to: :str
              map :fqdn,               to: :str
              map :project_name,       to: :str
              map :email,              to: :str
              map :name,               to: :str
              map :github_url,         to: :str
              map :no_keep_history,    to: :bool
              map :verbose,            to: :bool
              map :allow_empty_commit, to: :bool
              map :committer_from_gh,  to: :bool
              map :deployment_file,    to: :bool
              map :detect_encoding,    to: :bool # TODO validate this, it's being used and Dpl::Provider has the method, not sure.
            end
          end
        end
      end
    end
  end
end
