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

          attr_reader :repos, :mutex, :mutexes

          def initialize
            @repos = {}
            @mutex = Mutex.new
            @mutexes = {}
          end

          def [](vcs_id, provider = 'github')
            key = "#{provider}_#{vcs_id}"
            mutex_for(key).synchronize do
              return repos[key] if repos.key?(key)
              repo = repos[key] = Repo.new(fetch(vcs_id, provider))
              repo
            end
          end

          def []=(key, repo)
            repos[key] = repo
          end

          def fetch(vcs_id, provider)
            logger.info "Get Repo for #{vcs_id} #{provider}"
            Travis::Repo.new(vcs_id, provider).fetch
          end

          def mutex_for(key)
            mutexes[key] ||= Mutex.new
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
