# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Gleis < Deploy
            register :gleis

            def define
              map :app,      to: :str
              map :username, to: :str
              map :password, to: :secure
              map :key_name, to: :str
              map :verbose,  to: :bool
            end
          end
        end
      end
    end
  end
end
