# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Deis < Deploy
            register :deis

            def define
              super
              map :controller,  to: :str
              map :username,    to: :secure
              map :password,    to: :secure
              map :app,         to: :str
              map :cli_version, to: :str

              export
            end
          end
        end
      end
    end
  end
end
