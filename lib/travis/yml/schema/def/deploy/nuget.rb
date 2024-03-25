# frozen_string_literal: true
module Travis
  module Yml
    module Schema
      module Def
        module Deploy
          class Nuget < Deploy
            register :nuget

            def define
              map :api_key,       to: :secure, strict: false
              map :registry,       to: :str
              map :src,            to: :str
              map :no_symbols,     to: :bool
              map :skip_duplicate, to: :bool
            end
          end
        end
      end
    end
  end
end
