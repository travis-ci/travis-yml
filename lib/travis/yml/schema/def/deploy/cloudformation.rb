# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Cloudformation < Deploy
            register :cloudformation

            def define
              map :access_key_id,     to: :secure, strict: false
              map :secret_access_key, to: :secure
              map :region,            to: :str
              map :template,          to: :str
              map :stack_name,        to: :str
              map :stack_name_prefix, to: :str
              map :promote,           to: :bool
              map :role_arn,          to: :str
              map :sts_assume_role,   to: :str
              map :capabilities,      to: :strs
              map :wait,              to: :bool
              map :wait_timeout,      to: :num
              map :create_timeout,    to: :num
              map :session_token,     to: :str
              map :parameters,        to: :strs
              map :output_file,       to: :str
            end
          end
        end
      end
    end
  end
end
