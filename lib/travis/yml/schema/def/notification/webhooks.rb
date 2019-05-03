# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          class Webhooks < Notification
            register :webhooks

            def define
              aliases :webhook
              prefix :urls

              map :urls,      to: Urls
              map :on_start,  to: :frequency
              map :on_cancel, to: :frequency
              map :on_error,  to: :frequency

              super
            end

            class Urls < Dsl::Seq
              def define
                type :secure, strict: false
              end
            end
          end
        end
      end
    end
  end
end
