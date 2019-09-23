# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Snaps < Type::Seq
            registry :addon
            register :snaps

            def define
              summary 'Ubuntu Snaps to install'
              see 'Snap Store': 'https://docs.travis-ci.com/user/deployment/snaps/'

              type Class.new(Type::Map) {
                def define
                  prefix :name
                  map :name,    to: :str
                  map :classic, to: :bool
                  map :channel, to: :str
                end
              }

              normal
              export
            end
          end
        end
      end
    end
  end
end
