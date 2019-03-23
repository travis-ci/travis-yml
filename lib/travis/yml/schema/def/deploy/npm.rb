# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Npm < Deploy
            register :npm

            def define
              super
              map :email,   to: :secure
              map :api_key, to: :secure

              export
            end
          end
        end
      end
    end
  end
end
