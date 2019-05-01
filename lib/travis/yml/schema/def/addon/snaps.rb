# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'
require 'travis/yml/schema/dsl/seq'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Snaps < Dsl::Seq
            registry :addon
            register :snaps

            def define
              normal
              type Snap
              export
            end

            class Snap < Dsl::Map
              def define
                prefix :name

                map :name,    to: :str
                map :classic, to: :bool
                map :channel, to: :str
              end
            end
          end
        end
      end
    end
  end
end
