# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Ecr < Deploy
            register :ecr

            def define
              map :access_key_id,     to: :secure, strict: false
              map :secret_access_key, to: :secure
              map :account_id,        to: :str
              map :source,            to: :str
              map :target,            to: :str
              map :region,            to: :str
            end
          end
        end
      end
    end
  end
end
