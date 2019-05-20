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
              map :username,  to: :secure, strict: false
              map :api_key,   to: :secure
              map :region,    to: :str
              map :container, to: :str
              map :glob,      to: :str
              map :dot_match, to: :bool
            end
          end
        end
      end
    end
  end
end
