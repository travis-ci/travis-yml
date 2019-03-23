# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Python < Lang
          register :python

          def define
            matrix :python
            map :virtualenv, to: :virtualenv, strict: false, alias: :virtual_env

            super
          end
        end

        class Virtualenv < Dsl::Map
          register :virtualenv

          def define
            map :system_site_packages, to: :bool
          end
        end
      end
    end
  end
end
