# frozen_string_literal: true
module Travis
  module Yaml
    module Spec
      module Def
        module Deploy
          # dpl readme does not mention key
          # docs do not mention manifest
          # docs do not mention skip_ssl_validation
          class Cloudfoundry < Deploy
            register :cloudfoundry

            def define
              super
              map :username,            to: :str, secure: true
              map :password,            to: :str, secure: true
              map :organization,        to: :str
              map :api,                 to: :str
              map :space,               to: :str
              map :key,                 to: :str
              map :manifest,            to: :str
              map :skip_ssl_validation, to: :bool
            end
          end
        end
      end
    end
  end
end
