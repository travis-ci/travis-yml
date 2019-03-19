# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          class BluemixCloudfoundry < Deploy
            register :bluemixcf

            def define
              super
              map :username,            to: :str, secure: true
              map :password,            to: :str, secure: true
              map :organization,        to: :str
              map :api,                 to: :str
              map :space,               to: :str
              map :region,              to: :str
              map :manifest,            to: :str
              map :skip_ssl_validation, to: :bool
            end
          end
        end
      end
    end
  end
end
