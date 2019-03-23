require 'gen/cli/opts'

module Gen
  class Cli
    module Cmds
      class Cmd < Struct.new(:args)
        include Opts

        attr_reader :args, :cmd, :opts

        def initialize(args)
          @args = args
          @opts = parse_opts(args)
        end
      end
    end
  end
end
