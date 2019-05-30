# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          class Pushover < Notification
            register :pushover

            def define
              map :enabled,  to: :bool
              map :disabled, to: :bool
              map :api_key,  to: :seq, type: :secure
              map :users,    to: :seq, type: :secure
              map :template, to: :templates
            end
          end
        end
      end
    end
  end
end
