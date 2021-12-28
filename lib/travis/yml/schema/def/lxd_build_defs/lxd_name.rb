# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        module LxdBuildDefs
          class LxdName < Type::Str
            register :lxd_name

            def define
              summary 'LXD image name'
              example 'my-custom-image'
              export
            end
          end
        end
      end
    end
  end
end
