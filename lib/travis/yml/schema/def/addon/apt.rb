# frozen_string_literal: true
require 'travis/yml/schema/dsl/map'
require 'travis/yml/schema/dsl/seq'

module Travis
  module Yml
    module Schema
      module Def
        module Addon
          class Apt < Addon
            register :apt

            def define
              prefix :packages
              map :packages, to: :seq, alias: :package
              map :sources,  to: Sources, alias: :source
              map :dist,     to: :str
              super
            end

            class Sources < Dsl::Seq
              def define
                # normal
                type Source
              end
            end

            class Source < Dsl::Map
              def define
                prefix :name
                map :name, to: :str
              end
            end
          end
        end
      end
    end
  end
end
