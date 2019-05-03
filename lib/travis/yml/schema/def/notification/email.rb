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

              map :recipients, to: Recipients

              super
            end

            class Recipients < Dsl::Seq
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
