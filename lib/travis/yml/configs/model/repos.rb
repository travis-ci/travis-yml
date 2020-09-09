require 'travis/yml/helper/obj'
require 'travis/yml/helper/synchronize'
require 'travis/yml/configs/errors'
require 'travis/yml/configs/model/repo'
require 'travis/yml/configs/travis/repo'

module Travis
  module Yml
    module Configs
      module Model
        class Repos
          include Synchronize

          attr_reader :repos, :mutex, :mutexes, :provider

          def initialize
            @repos = {}
            @mutex = Mutex.new
            @mutexes = {}
          end

          def [](slug, provider = 'github')
            mutex_for(slug).synchronize do
              return repos[slug] if repos.key?(slug)
              repo = repos[slug] = Repo.new(fetch(slug, provider))
              repo
            end
          end

          def []=(slug, repo)
            repos[slug] = repo
          end

          def fetch(slug, provider)
            logger.info "Get Repo for #{slug} #{provider}"
            Travis::Repo.new(slug, provider).fetch
          end

          def mutex_for(slug)
            mutexes[slug] ||= Mutex.new
          end
          synchronize :mutex

          def logger
            Yml.logger
          end
        end
      end
    end
  end
end
