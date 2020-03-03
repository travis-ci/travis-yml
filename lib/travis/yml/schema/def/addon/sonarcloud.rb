# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Sonarcloud < Addon
            register :sonarcloud

            def define
              summary 'Sonarcloud settings'
              see 'Using SonarCloud with Travis CI': 'https://docs.travis-ci.com/user/sonarcloud/'

              map :enabled,      to: :bool
              map :organization, to: :str
              map :token,        to: :secure

              map :github_token, to: :secure, deprecated: 'setting a GitHub token is deprecated'
              map :branches,     to: :seq,    deprecated: 'setting a branch is deprecated'
            end
          end
        end
      end
    end
  end
end
