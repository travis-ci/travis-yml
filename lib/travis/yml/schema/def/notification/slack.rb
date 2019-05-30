# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          class Slack < Notification
            register :slack

            def define
              prefix :rooms

              map :rooms,    to: :seq, type: :secure
              map :template, to: :templates
              map :on_pull_requests, to: :bool
            end
          end
        end
      end
    end
  end
end
