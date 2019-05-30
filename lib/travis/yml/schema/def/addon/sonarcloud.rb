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
              map :organization, to: :str
              map :token,        to: :secure

              map :github_token, to: :secure, deprecated: 'not supported any more'
              map :branches,     to: :seq,    deprecated: 'not supported any more'
            end
          end
        end
      end
    end
  end
end
