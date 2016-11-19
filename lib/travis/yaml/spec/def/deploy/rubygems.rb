module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Rubygems < Deploy
            register :rubygems

            def define
              super
              map :gem,     to: [:scalar, :map]
              map :file,    to: :scalar
              map :gemspec, to: :scalar
              map :api_key, to: [:scalar, :map], cast: :secure
            end
          end
        end
      end
    end
  end
end
