require 'travis/yml/docs/page/scalar'

module Travis
  module Yml
    module Docs
      module Page
        class Lang < Scalar
          def pages
            [self, *children]
          end

          def children
            @children ||= Docs.languages.map { |schema| build(self, nil, schema) }.select(&:publish?)
          end
        end
      end
    end
  end
end
