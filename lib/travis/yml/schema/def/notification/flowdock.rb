# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          class Flowdock < Notification
            register :flowdock

            def define
              prefix :api_token

              map :api_token, to: :secure
              map :template,  to: :templates

              super
            end
          end
        end
      end
    end
  end
end
