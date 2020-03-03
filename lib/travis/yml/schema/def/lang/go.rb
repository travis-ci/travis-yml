# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Go < Type::Lang
          register :go

          def define
            title 'Go'
            summary 'Go language support'
            see 'Building a Go Project': 'https://docs.travis-ci.com/user/languages/go/'
            aliases :golang

            matrix :go

            map :gobuild_args,    to: :str
            map :go_import_path,  to: :str
            map :gimme_config,    to: :gimme_config
          end
        end

        class GimmeConfig < Type::Map
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
