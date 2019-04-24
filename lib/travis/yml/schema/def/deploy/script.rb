# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Script < Deploy
            register :script

            def define
              map :script, to: :str # TODO should be a seq?
            end
          end
        end
      end
    end
  end
end
