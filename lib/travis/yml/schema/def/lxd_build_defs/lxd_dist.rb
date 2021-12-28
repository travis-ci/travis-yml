# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module LxdBuildDefs
          class LxdDist < Type::Str
            register :lxd_dist

            def define
              title 'Distribution'
              summary 'LXD image Ubuntu distribution'
              see 'Virtualization environments': 'https://docs.travis-ci.com/user/reference/overview/#virtualization-environments'
  
              downcase
  
              value :focal
              value :bionic

              export
            end
          end
        end
      end
    end
  end
end
