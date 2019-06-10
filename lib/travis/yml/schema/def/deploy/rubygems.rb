# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Rubygems < Deploy
            register :rubygems

            def define
              map :api_key,      to: :map, type: :secure
              map :username,     to: :map, type: [:secure, strict: false], alias: :user
              map :password,     to: :map, type: :secure
              map :gem,          to: :map, type: :str
              map :file,         to: :str
              map :gemspec,      to: :str
              map :gemspec_glob, to: :str
              map :host,         to: :str
            end
          end
        end
      end
    end
  end
end
