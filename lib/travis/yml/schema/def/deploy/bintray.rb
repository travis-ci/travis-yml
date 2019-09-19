# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Bintray < Deploy
            register :bintray

            def define
              map :user,       to: :secure, strict: false
              map :key,        to: :secure
              map :file,       to: :str
              map :passphrase, to: :secure
              map :url,        to: :str
            end
          end
        end
      end
    end
  end
end
