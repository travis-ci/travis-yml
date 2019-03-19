# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # docs do not mention puppetforge
          class Puppetforge < Deploy
            register :puppetforge

            def define
              super
              map :user,     to: :str, required: true, secure: true
              map :password, to: :str, required: true, secure: true
              map :url,      to: :str
            end
          end
        end
      end
    end
  end
end
