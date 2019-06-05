require 'travis/yml/docs/page/render'

module Travis
  module Yml
    module Docs
      module Page
        class Static < Obj.new(:name)
          include Render

          def id
            name.to_s
          end

          def full_id
            name.to_s
          end

          def render
            super("static/#{name}")
          end
        end
      end
    end
  end
end
