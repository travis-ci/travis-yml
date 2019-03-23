require 'gen/cli/cmds/cmd'
require 'gen/specs'

module Gen
  class Cli
    module Cmds
      class Gen < Cmd
        on '--pretend' do
          opts[:pretend] = true
        end

        def run
          puts(pretend? ? specs.render.join("\n") : specs.write)
        end

        def pretend?
          !!opts[:pretend]
        end

        def specs
          Specs.new(*args.map(&:to_sym))
        end
      end
    end
  end
end
