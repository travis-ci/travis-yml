# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class BluemixCloudfoundry < Deploy
            register :bluemixcf

            def define
              super
              map :username,            to: :secure
              map :password,            to: :secure
              map :organization,        to: :str
              map :api,                 to: :str
              map :space,               to: :str
              map :region,              to: :str
              map :manifest,            to: :str
              map :skip_ssl_validation, to: :bool

              export
            end
          end
        end
      end
    end
  end
end
