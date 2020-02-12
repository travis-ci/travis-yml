require 'forwardable'
require 'thwait'
require 'travis/yml/helper/condition'
# require 'travis/yml/helper/lock'
require 'travis/yml/helper/synchronize'
require 'travis/yml/configs/errors'
require 'travis/yml/configs/model/repos'

module Travis
  module Yml
    module Configs
      class Imports
        extend Forwardable
        include Errors, Synchronize

        def_delegators :config, :repo, :ref, :path

        attr_reader :ctx, :config, :sources, :mutex, :queue, :threads #, :lock

        def initialize(ctx)
          @ctx = ctx
          @sources = []
          # @lock = Lock.new
          @queue = Queue.new
          @mutex = Mutex.new
          @threads = []
        end

        def load(config)
          @config = config
          config.load(&method(:on_load))
          threads.each(&:join) && sleep(0.1) until config.loaded?
          # lock.wait unless config.loaded?
        end

        def configs
          config.flatten
        end

        def size
          sources.size
        end

        def msgs
          @msgs ||= []
        end

        def store(config)
          return unless import?(config)
          sources << config.to_s
          push(config)
        end
        synchronize :store

        private

          def push(config)
            config.imports.each do |config|
              threads << thread(&method(:process))
              queue << config
            end
          end

          def process
            config = queue.pop
            config.load
          end

          def on_load
            too_many_imports(size, max_imports) if limit?
            configs.each(&:validate)
            # lock.release
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
            Thread.new(&block).tap do |thread|
              thread.report_on_exception = false
              thread.abort_on_exception = false
            end
          end

          def max_imports
            Yml.config[:imports][:max]
          end
      end
    end
  end
end
