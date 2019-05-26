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
              summary 'Install APT packages and sources'

              description <<~str
                Install APT packages and sources without using apt-get commands in a before_install script manually.

                Please see [our documentation](/user/installing-dependencies/#installing-packages-with-the-apt-addon) for details.
              str

              prefix :packages
              map :packages, to: :seq, alias: :package, summary: 'Package names', eg: 'cmake'
              map :sources,  to: Sources, alias: :source, summary: 'Package sources', eg: 'ubuntu-toolchain-r-test'
              map :dist,     to: :str, summary: 'Distribution'
              map :update,   to: :bool, summary: 'Whether to run apt-get update'
              super
            end

            class Sources < Dsl::Seq
              def define
                type Source
              end
            end

            class Source < Dsl::Map
              def define
                prefix :name
                map :name,       to: :str
                map :sourceline, to: :str
                map :key_url,    to: :str
              end
            end
          end
        end
      end
    end
  end
end
