# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Branches < Type::Map
          register :branches

          def define
            summary 'Include or exclude branches from being built'

            description <<~str
              Include or exclude branches for your build to be run on.

              This is a legacy setting, use the more powerful condition (`if`) to define branches for your build to be run on.
            str

            normal
            prefix :only
            aliases :branch

            map :only,   to: :seq, summary: 'Branches to include', eg: 'master'
            map :except, to: :seq, alias: :exclude, summary: 'Branches to exclude', eg: 'develop'

            export
          end
        end
      end
    end
  end
end
