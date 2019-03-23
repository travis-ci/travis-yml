# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          class Hipchat < Notification
            register :hipchat

            def define
              prefix :rooms

              map :rooms,            to: :seq, type: :secure
              map :format,           to: :enum, values: [:html, :text]
              map :notify,           to: :bool
              map :on_pull_requests, to: :bool
              map :template,         to: :templates

              super
            end
          end
        end
      end
    end
  end
end
