# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'
require 'travis/yml/schema/dsl/seq'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Sonarcloud < Dsl::Map
            register :sonarcloud

            def define
              namespace :addon

              map :organization, to: :str
              map :token,        to: :secure

              map :github_token, to: :secure, deprecated: :deprecated_sonarcloud_github_token
              map :branches,     to: :seq,    deprecated: :deprecated_sonarcloud_branches
            end
          end
        end
      end
    end
  end
end
