# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Cloudcontrol < Deploy
            register :cloudcontrol

            def define
              map :email,      to: :secure, strict: false
              map :password,   to: :secure
              map :deployment, to: :str
            end
          end
        end
      end
    end
  end
end
