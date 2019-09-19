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
              map :project,               to: :str
              map :keyfile,               to: :str
              map :config,                to: :str
              map :version,               to: :str
              map :verbosity,             to: :str
              map :promote,               to: :bool
              map :stop_previous_version, to: :bool
              map :install_sdk,           to: :bool
            end
          end
        end
      end
    end
  end
end
