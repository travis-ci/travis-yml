# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class Anynines < Deploy
            register :anynines

            def define
              super
              map :username,     to: :str, secure: true
              map :password,     to: :str, secure: true
              map :organization, to: :str
              map :space,        to: :str
            end
          end
        end
      end
    end
  end
end
