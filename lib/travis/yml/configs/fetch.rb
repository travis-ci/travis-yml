require 'forwardable'
require 'thwait'
require 'travis/yml/helper/condition'
require 'travis/yml/helper/synchronize'
require 'travis/yml/configs/errors'
require 'travis/yml/configs/model/repos'

module Travis
  module Yml
    module Configs
      # Fetches .travis.yml and all imported configs from GitHub asynchronously,
      # walking the tree depth-first.
      #
      # Authorization scenarios:
      #
      # * Full access to public configs for unauthenticated requests (e.g. from config.travis-ci.com)
      # * Authenticated access to private configs a user has access to (e.g. from the UI on travis-ci.com)
      # * Full access to private configs when authenticated internally (e.g. Gatekeeper)
      #
      # Access to private imports is protected by:
      #
      # * Only allowing to import private configs from the same repo owner
      # * Only allowing to import private configs if the setting :allow_config_imports is on
      #
      # Authorizing access to the main repo:
      #
      # * if we are authenticated internally it's ok to just fetch it
      # * if the repo is public it's ok to just fetch it
      # * if the repo is private it needs to be authenticated in a separate call using the user's token
      #
      class Fetch
        extend Forwardable
        include Errors, Synchronize

        def_delegators :ctx, :error, :internal?, :user_token
        def_delegators :config, :repo, :ref, :path

        attr_reader :ctx, :config, :sources, :msgs, :mutex, :queue, :threads

        def initialize(ctx)
          @ctx = ctx
          @sources = []
          @msgs = []
          @mutex = Mutex.new
          @queue = Queue.new
          @threads = []
        end

        def load(config)
          @config = config
          authorize if authorize?
          config.load(&method(:on_load))
          threads.each(&:join)
        end

        def configs
          config.flatten
        end

        def size
          sources.size
        end

        def store(config)
          return unless import?(config)
          sources << config.to_s
          sources.uniq!
          push(config)
        end
        synchronize :store

        private

          def authorize?
            repo.private? && !internal?
          end

          def authorize
            thread { repo.authorize(user_token) }
          end

          def push(config)
            config.imports.each do |config|
              thread(&method(:process))
              queue << config
            end
          end

          def process
            config = queue.pop
            config.load
          end

          def on_load
            error :import, :too_many_imports, max: max_imports if limit?
          end

          def import?(config)
            return true if unique?(config.to_s) && !limit? && config.matches?
            config.skip
            false
          end

          def limit?
            size >= max_imports
          end

          def unique?(source)
            !sources.include?(source)
          end

          def thread(&block)
            threads << Thread.new(&block).tap do |thread|
              thread.report_on_exception = false
              thread.abort_on_exception = false
            end
          end

          def max_imports
            Yml.config[:imports][:max]
          end

          # doesn't seem to need this anymore?
          #
          # def wait
          #   threads.each(&:join)
          #   sleep(0.1) && wait if busy?
          # end
          #
          # def busy?
          #   !config.loaded? || threads.any?(&:alive?)
          # end
      end
    end
  end
end
