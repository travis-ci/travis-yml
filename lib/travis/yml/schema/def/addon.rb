# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Addon < Dsl::Map
            def define
              namespace :addon
              normal
              export
            end
          end
        end
      end
    end
  end
end

require 'travis/yml/schema/def/addon/apt'
require 'travis/yml/schema/def/addon/artifacts'
require 'travis/yml/schema/def/addon/browserstack'
require 'travis/yml/schema/def/addon/code_climate'
require 'travis/yml/schema/def/addon/coverity_scan'
require 'travis/yml/schema/def/addon/homebrew'
require 'travis/yml/schema/def/addon/jwts'
require 'travis/yml/schema/def/addon/sauce_connect'
require 'travis/yml/schema/def/addon/snaps'
