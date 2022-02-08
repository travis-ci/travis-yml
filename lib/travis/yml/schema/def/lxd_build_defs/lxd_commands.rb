# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module LxdBuildDefs
          class LxdCommands < Type::Seq
            register :lxd_commands
  
            def define
              summary 'LXD image commands'
              description 'Run commands during LXD image setup'
              normal
              type :lxd_command
  
              export
            end
          end
  
          class LxdCommand < Type::Str
            register :lxd_command
  
            def define
              summary 'LXD command'
              example 'apt-get -y install python3.8'
              export
            end
          end
        end
      end
    end
  end
end
