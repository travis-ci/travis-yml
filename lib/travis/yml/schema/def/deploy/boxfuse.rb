# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Boxfuse < Deploy
            register :boxfuse

            def define
              map :user,        to: :secure, strict: false
              map :secret,      to: :secure
              map :config_file, to: :str, alias: :configfile
              map :payload,     to: :str
              map :app,         to: :str
              map :version,     to: :str
              map :env,         to: :str
              map :extra_args,  to: :str
            end
          end
        end
      end
    end
  end
end
