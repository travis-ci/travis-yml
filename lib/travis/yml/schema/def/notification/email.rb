# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          class Email < Notification
            register :email

            def define
              prefix :recipients

              map :recipients, to: :seq, type: :secure

              super
            end
          end
        end
      end
    end
  end
end
