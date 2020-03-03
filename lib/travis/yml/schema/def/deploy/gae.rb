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
              map :config,                   to: :strs
              map :version,                  to: :str
              map :verbosity,                to: :str
              map :promote,                  to: :bool
              map :no_promote,               to: :bool, deprecated: 'use promote: false'
              map :stop_previous_version,    to: :bool
              map :no_stop_previous_version, to: :bool, deprecated: 'use stop_previous_version: false'
              map :install_sdk,              to: :bool
            end
          end
        end
      end
    end
  end
end
