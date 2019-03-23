require 'gen/cli/cmds/gen'
require 'gen/cli/opts'

module Gen
  class Cli
    include Opts

    attr_reader :args, :cmd, :opts

    def initialize(*args)
      @cmd = Cmds.const_get(args.shift.capitalize)
      @args = args
    end

    def run
      cmd.new(args).run
    end
  end
end
