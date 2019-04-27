# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Shell < Lang
          register :shell

          def define
            aliases *%i(bash generic minimal sh)
          end
        end
      end
    end
  end
end
