# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # dpl readme does not mention key
          # docs do not mention manifest
          # docs do not mention skip_ssl_validation
          class Cloudfoundry < Deploy
            register :cloudfoundry

            def define
              map :username,            to: :secure, strict: false
              map :password,            to: :secure
              map :organization,        to: :str
              map :api,                 to: :str
              map :space,               to: :str
              map :buildpack,           to: :str
              map :manifest,            to: :str
              map :skip_ssl_validation, to: :bool
              map :app_name,            to: :str
              map :logout,              to: :bool
              map :v3,                  to: :bool
            end
          end
        end
      end
    end
  end
end
