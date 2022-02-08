# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module LxdBuildDefs
          class LxdBuild < Type::Map
            register :lxd_build

            def define
              summary 'Build an LXD image'

              description <<~str
                Build an LXD image
              str

              map :dist,         to: :lxd_dist, required: true
              map :name,         to: :lxd_name, required: true
              map :description,  to: :lxd_description
              map :commands,     to: :lxd_commands

              export
            end
          end
        end
      end
    end
  end
end

require 'travis/yml/schema/def/lxd_build_defs/lxd_dist'
require 'travis/yml/schema/def/lxd_build_defs/lxd_name'
require 'travis/yml/schema/def/lxd_build_defs/lxd_description'
require 'travis/yml/schema/def/lxd_build_defs/lxd_commands'
