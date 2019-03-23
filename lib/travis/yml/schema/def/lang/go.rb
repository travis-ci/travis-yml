# frozen_string_literal: true
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Go < Lang
          register :go

          def define
            aliases :golang

            matrix :go

            map :gobuild_args,    to: :str
            map :go_import_path,  to: :str
            map :gimme_config,    to: :gimme_config

            super
          end
        end

        class GimmeConfig < Dsl::Map
          register :gimme_config

          def define
            map :url, to: :str
            map :force_reinstall, to: :bool
          end
        end
      end
    end
  end
end
