module Travis
  module Yml
    module Docs
      module Page
        class Static < Base
          attr_reader :name

          def initialize(name, opts)
            super(nil, opts)
            @name = name
          end

          def id
            name.to_s
          end

          def full_id
            name.to_s
          end

          def title
            name.to_s.capitalize
          end

          def static?
            true
          end

          def render
            super("static/#{name}")
          end
        end
      end
    end
  end
end
