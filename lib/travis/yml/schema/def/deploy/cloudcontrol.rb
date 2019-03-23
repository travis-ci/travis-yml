# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Cloudcontrol < Deploy
            register :cloudcontrol

            def define
              super
              map :email,      to: :secure
              map :password,   to: :secure
              map :deployment, to: :str

              export
            end
          end
        end
      end
    end
  end
end
