# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class OsxImages < Type::Seq
          register :osx_images

          def define
            type :osx_image
            export
          end
        end

        class OsxImage < Type::Str
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
