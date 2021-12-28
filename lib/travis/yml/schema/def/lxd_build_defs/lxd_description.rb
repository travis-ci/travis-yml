# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module LxdBuildDefs
          class LxdDescription < Type::Str
            register :lxd_description

            def define
              summary 'LXD image description'
              example 'My custom image description'
              export
            end
          end
        end
      end
    end
  end
end
