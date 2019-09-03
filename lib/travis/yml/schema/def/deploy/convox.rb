# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Convox < Deploy
            register :convox

            def define
              map :host,        to: :str
              map :app,         to: :str, required: true
              map :rack,        to: :str, required: true
              map :password,    to: :secure, required: true
              map :install_url, to: :str
              map :update_cli,  to: :bool
              map :create,      to: :bool
              map :promote,     to: :bool
              map :env,         to: :strs
              map :env_file,    to: :str
              map :description, to: :str
              map :generation,  to: :num
            end
          end
        end
      end
    end
  end
end
