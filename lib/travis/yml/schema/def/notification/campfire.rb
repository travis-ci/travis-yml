# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          class Campfire < Notification
            register :campfire

            def define
              prefix :rooms

              map :rooms,    to: :seq, type: :secure
              map :template, to: :templates
            end
          end
        end
      end
    end
  end
end
