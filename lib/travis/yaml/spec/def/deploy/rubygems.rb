# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Rubygems < Deploy
            register :rubygems

            def define
              super
              map :gem,     to: :scalar
              map :file,    to: :str
              map :gemspec, to: :str
              map :api_key, to: :scalar, secure: true
            end
          end
        end
      end
    end
  end
end
