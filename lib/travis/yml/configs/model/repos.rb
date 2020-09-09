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

          def initialize(provider = 'github')
            @repos = {}
            @mutex = Mutex.new
            @mutexes = {}
            @provider = provider
          end

          def [](slug)
            mutex_for(slug).synchronize do
              return repos[slug] if repos.key?(slug)
              repo = repos[slug] = Repo.new(fetch(slug))
              repo
            end
          end

          def []=(slug, repo)
            repos[slug] = repo
          end

          def fetch(slug)
            Travis::Repo.new(slug, provider).fetch
          end

          def mutex_for(slug)
            mutexes[slug] ||= Mutex.new
          end
          synchronize :mutex
        end
      end
    end
  end
end
