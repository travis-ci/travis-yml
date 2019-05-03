# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Npm < Deploy
            register :npm

            def define
              map :email,   to: :secure, strict: false
              map :api_key, to: :secure
              map :tag,     to: :str
            end
          end
        end
      end
    end
  end
end
