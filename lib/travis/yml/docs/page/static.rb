module Travis
  module Yml
    module Docs
      module Page
        class Static < Base
          attr_reader :name

          def initialize(parent, name, opts)
            super(parent, nil, nil, opts)
            @name = name
          end

          def id
            name.to_s
          end

          def full_id
            name.to_s
          end

          def title
            titleize(name)
          end
          alias menu_title title

          def static?
            true
          end

          def publish?
            true
          end

          def render(opts = {})
            super("static/#{name}", opts.merge(layout: true))
          end
        end
      end
    end
  end
end
