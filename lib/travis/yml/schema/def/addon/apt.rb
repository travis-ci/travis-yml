# frozen_string_literal: true
require 'travis/yml/schema/type'

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
              str

              see 'Installing Packages with the APT Addon': 'https://docs.travis-ci.com/user/installing-dependencies/#installing-packages-with-the-apt-addon'

              prefix :packages
              map :packages, to: :seq, alias: :package, summary: 'Package names', eg: 'cmake'
              map :sources,  to: :apt_sources, alias: :source, summary: 'Package sources', eg: 'ubuntu-toolchain-r-test'
              map :dist,     to: :str, summary: 'Distribution'
              map :update,   to: :bool, summary: 'Whether to run apt-get update'
              map :config,   to: :apt_config
            end
          end

          class AptSources < Type::Seq
            register :apt_sources

            def define
              type :apt_source
            end
          end

          class AptSource < Type::Map
            register :apt_source

            def define
              prefix :name
              map :name,       to: :str
              map :sourceline, to: :str
              map :key_url,    to: :str
            end
          end

          class AptConfig < Type::Map
            register :apt_config

            def define
              map :retries, to: :bool
            end
          end
        end
      end
    end
  end
end
