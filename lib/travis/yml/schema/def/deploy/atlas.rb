# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # docs do not mention debug
          # docs do not mention version
          class Atlas < Deploy
            register :atlas

            def define
              map :token,    to: :secure
              map :app,      to: :str
              map :exclude,  to: :seq
              map :include,  to: :seq
              map :address , to: :str
              map :metadata, to: :seq
              map :debug,    to: :bool
              map :vcs,      to: :bool
              map :version,  to: :bool
              map :paths,    to: :seq
              map :args,     to: :str
            end
          end
        end
      end
    end
  end
end
