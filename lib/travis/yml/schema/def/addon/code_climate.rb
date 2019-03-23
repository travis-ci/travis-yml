# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class CodeClimate < Addon
            register :code_climate

            def define
              prefix :repo_token
              map :repo_token, to: :secure
              super
            end
          end
        end
      end
    end
  end
end
