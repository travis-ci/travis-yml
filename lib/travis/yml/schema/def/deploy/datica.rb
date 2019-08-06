# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          # docs do not mention catalyze
          class Datica < Deploy
            register :datica

            def define
              map :target, to: :str
              map :path,   to: :str
            end
          end
        end
      end
    end
  end
end
