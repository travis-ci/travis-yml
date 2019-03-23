require 'optparse'

module Gen
  class Cli
    module Opts
      class Options < ::OptionParser
        attr_reader :opts

        def initialize(defs, args, opts = {})
          @opts = opts
          super { defs.each { |args, block| on(*args) { |*args| instance_exec(*args, &block) } } }
          parse!(args)
        end
      end

      def self.included(base)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods
        def on(*args, &block)
          opts << [args, block]
        end

        def opts
          @opts ||= []
        end
      end

      def parse_opts(args, defs = [])
        opts = self.class.const_defined?(:OPTS) ? self.class::OPTS.dup : {}
        Options.new(self.class.opts + defs, args, opts).opts
      end
    end
  end
end
