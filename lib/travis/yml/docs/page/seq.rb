require 'travis/yml/docs/page/base'

module Travis
  module Yml
    module Docs
      module Page
        class Seq < Base
          def pages
            [self, *build(self, nil, node.schema).pages].flatten.select(&:publish?)
          end

          def display_type
            [DISPLAY_TYPES[:seq] % child.display_type, path_to('types')]
          end

          def child
            @child ||= build(self, nil, node.schema)
          end

          def base_type?
            super || child.base_type?
          end
        end
      end
    end
  end
end
