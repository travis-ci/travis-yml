# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class OsCustom < Type::Str
          register :os_custom

          def define
            summary 'Use a custom LXD image'
            export
          end
        end
      end
    end
  end
end
