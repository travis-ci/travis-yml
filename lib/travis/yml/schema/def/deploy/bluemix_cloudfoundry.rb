# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class BluemixCloudfoundry < Deploy
            # this seems to be called bluemixcf in dpl? https://www.rubydoc.info/gems/dpl/1.8.31#bluemix-cloud-foundry
            register :bluemixcloudfoundry

            def define
              map :username,            to: :secure, strict: false
              map :password,            to: :secure
              map :organization,        to: :str
              map :api,                 to: :str
              map :space,               to: :str
              map :region,              to: :str
              map :buildpack,           to: :str
              map :manifest,            to: :str
              map :skip_ssl_validation, to: :bool
              map :app_name,            to: :str
            end
          end
        end
      end
    end
  end
end
