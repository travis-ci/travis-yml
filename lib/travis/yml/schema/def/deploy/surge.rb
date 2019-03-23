# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Surge < Deploy
            register :surge

            def define
              super
              map :project, to: :str
              map :domain,  to: :str

              export
            end
          end
        end
      end
    end
  end
end
