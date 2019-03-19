# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # docs do not mention config
          # docs do not mention version
          # docs do not mention verbosity
          class Gae < Deploy
            register :gae

            def define
              super
              map :project,                  to: :str
              map :keyfile,                  to: :str
              map :config,                   to: :str
              map :version,                  to: :str
              map :no_promote,               to: :bool
              map :no_stop_previous_version, to: :bool
              map :verbosity,                to: :str
            end
          end
        end
      end
    end
  end
end
