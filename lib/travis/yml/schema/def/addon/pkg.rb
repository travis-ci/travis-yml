# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Pkg < Addon
            register :pkg

            def define
              prefix :packages

              map :packages, to: :seq, alias: :package, summary: 'Package names', eg: 'cmake'
              map :branch, to: :str, summary: 'Packages branch', eg: 'quarterly'
            end
          end
        end
      end
    end
  end
end
