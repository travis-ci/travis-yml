# frozen_string_literal: true
require 'travis/yml/schema/dsl/seq'

module Travis
  module Yml
    module Schema
      module Def
        class OsxImage < Dsl::Str
          register :osx_image

          def define
            summary 'OSX image to use for the build environment'
            supports :only, os: :osx
            edge
          end
        end
      end
    end
  end
end
