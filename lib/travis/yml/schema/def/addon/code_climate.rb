# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class CodeClimate < Addon
            register :code_climate

            def define
              prefix :repo_token
              map :repo_token, to: :secure, summary: 'Code Climate repo token'
            end
          end
        end
      end
    end
  end
end
