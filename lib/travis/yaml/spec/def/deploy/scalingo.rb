# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Scalingo < Deploy
            register :scalingo

            def define
              super
              map :username, to: :str, secure: true
              map :password, to: :str, secure: true
              map :api_key,  to: :str, secure: true
              map :remote,   to: :str
              map :branch,   to: :str
              map :app,      to: :str
            end
          end
        end
      end
    end
  end
end
