# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Transifex < Deploy
            register :transifex

            def define
              map :username,    to: :secure, strict: false
              map :password,    to: :secure
              map :hostname,    to: :str
              map :cli_version, to: :str
            end
          end
        end
      end
    end
  end
end
