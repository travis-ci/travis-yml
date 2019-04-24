# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Rubygems < Deploy
            register :rubygems

            def define
              # TODO according to the docs :gem can be a :str or a :map
              # https://docs.travis-ci.com/user/deployment/rubygems/#gem-to-release
              #
              #   gem:
              #     master: my-gem
              #     old: my-gem-old

              map :api_key, to: :map, type: :secure
              map :gem,     to: :map, type: :str
              map :file,    to: :str
              map :gemspec, to: :str
            end
          end
        end
      end
    end
  end
end
