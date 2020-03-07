require 'forwardable'
require 'thwait'
require 'travis/yml/helper/condition'
require 'travis/yml/helper/synchronize'
require 'travis/yml/configs/errors'
require 'travis/yml/configs/model/repos'

module Travis
  module Yml
    module Configs
      class Fetch
        extend Forwardable
        include Errors, Synchronize

        def_delegators :ctx, :error
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
