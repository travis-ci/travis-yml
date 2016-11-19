module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # docs do not mention dot_match
          class Cloudfiles < Deploy
            register :cloudfiles

            def define
              super
              map :username,  to: :scalar, cast: :secure
              map :api_key,   to: :scalar, cast: :secure
              map :region,    to: :scalar
              map :container, to: :scalar
              map :dot_match, to: :scalar, cast: :bool
            end
          end
        end
      end
    end
  end
end
