# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # docs do not mention puppetforge
          class Puppetforge < Deploy
            register :puppetforge

            def define
              map :user,     to: :secure, required: true, strict: false
              map :password, to: :secure, required: true
              map :url,      to: :str
            end
          end
        end
      end
    end
  end
end
