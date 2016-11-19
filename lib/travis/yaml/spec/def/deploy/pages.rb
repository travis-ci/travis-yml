module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # docs do not mention pages
          class Pages < Deploy
            register :pages

            def define
              super
              map :github_token,  to: :scalar, cast: :secure, alias: :'github-token'
              map :repo,          to: :scalar
              map :target_branch, to: :scalar, alias: :'target-branch'
              map :local_dir,     to: :scalar, alias: :'local-dir'
              map :fqdn,          to: :scalar
              map :project_name,  to: :scalar, alias: :'project-name'
              map :email,         to: :scalar, cast: :secure
              map :name,          to: :scalar
            end
          end
        end
      end
    end
  end
end
