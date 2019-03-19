# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # docs do not mention dot_match
          class Cloudfiles < Deploy
            register :cloudfiles

            def define
              super
              map :username,  to: :str, secure: true
              map :api_key,   to: :str, secure: true
              map :region,    to: :str
              map :container, to: :str
              map :dot_match, to: :bool
            end
          end
        end
      end
    end
  end
end
