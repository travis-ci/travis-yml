# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'

module Travis
  module Yml
    module Schema
      module Def
        class Branches < Dsl::Map
          register :branches

          # deprecated in favor of :if

          def define
            description <<~str
              The branches your build will be run on.
            str

            # examples <<~str,
            #   branch: master
            # str
            # <<~str,
            #   branch:
            #     only: master
            #     except: unstable
            # str
            # <<~str,
            #   branch:
            #     only:
            #       - master
            #       - development
            #     except:
            #       - unstable
            #       - experiment
            # str

            normal
            prefix :only

            map :only,   to: :seq #, desc: 'Branches to include'
            map :except, to: :seq, alias: :exclude #, desc: 'Branches to exclude'

            export
          end
        end
      end
    end
  end
end
