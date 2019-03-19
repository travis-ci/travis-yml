# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # dpl readme does not mention image
          # dpl readme does not mention extra_args
          class Boxfuse < Deploy
            register :boxfuse

            def define
              super
              map :user,       to: :str, secure: true
              map :secret,     to: :str, secure: true
              map :configfile, to: :str
              map :payload,    to: :str
              map :app,        to: :str
              map :version,    to: :str
              map :env,        to: :str
              map :image,      to: :str
              map :extra_args, to: :str
            end
          end
        end
      end
    end
  end
end
