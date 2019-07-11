# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class OsxImage < Type::Seq
          register :osx_image

          def define
            summary 'OSX image to use for the build environment'
            supports :only, os: :osx
          end
        end
      end
    end
  end
end
