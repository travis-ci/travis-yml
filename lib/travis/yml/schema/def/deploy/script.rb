# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Script < Deploy
            register :script

            def define
              super
              map :script, to: :str # TODO should be a seq?

              export
            end
          end
        end
      end
    end
  end
end
