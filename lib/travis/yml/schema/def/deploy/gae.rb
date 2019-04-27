# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # docs do not mention config
          # docs do not mention version
          # docs do not mention verbosity
          class Gae < Deploy
            register :gae

            def define
              map :project,                  to: :str
              map :keyfile,                  to: :str
              map :config,                   to: :str
              map :version,                  to: :str
              map :no_promote,               to: :bool
              map :no_stop_previous_version, to: :bool
              map :default,                  to: :bool
              map :verbosity,                to: :str
              map :docker_build,             to: :str
            end
          end
        end
      end
    end
  end
end
