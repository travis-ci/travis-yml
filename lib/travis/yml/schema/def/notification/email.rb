# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Notification
          class Email < Notification
            register :email

            def define
              aliases :emails
              prefix :recipients

              map :recipients, to: :email_recipients
            end
          end

          class EmailRecipients < Type::Seq
            register :email_recipients

            def define
              type :secure, strict: false
            end
          end
        end
      end
    end
  end
end
