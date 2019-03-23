# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Rubygems < Deploy
            register :rubygems

            def define
              super
              # TODO according to the docs :gem can be a :str or a :map
              # https://docs.travis-ci.com/user/deployment/rubygems/#gem-to-release
              #
              #   gem:
              #     master: my-gem
              #     old: my-gem-old

              map :gem,     to: :str
              map :file,    to: :str
              map :gemspec, to: :str
              map :api_key, to: :secure

              export
            end
          end
        end
      end
    end
  end
end
