# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Php < Type::Lang
          register :php

          def define
            matrix :php
            map :composer_args, to: :str
          end
        end
      end
    end
  end
end
