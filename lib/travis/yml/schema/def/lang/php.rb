# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Php < Lang
          register :php

          def define
            matrix :php
            map :composer_args, to: :str

            super
          end
        end
      end
    end
  end
end
