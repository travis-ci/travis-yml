# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # docs do not mention dot_match
          class Cloudfiles < Deploy
            register :cloudfiles

            def define
              super
              map :username,  to: :secure
              map :api_key,   to: :secure
              map :region,    to: :str
              map :container, to: :str
              map :dot_match, to: :bool

              export
            end
          end
        end
      end
    end
  end
end
