# frozen_string_literal: true
require 'travis/yml/schema/type'

module Travis
  module Yml
    module Schema
      module Def
        class Git < Type::Map
          register :git

          def define
            summary 'Git settings'

            description <<~str
              These settings can be used in order to customize how the repository
              is cloned with Git.
            str

            see 'Customizing the Build': 'https://docs.travis-ci.com/user/customizing-the-build/'

            map :strategy,         to: :str, values: [:clone, :tarball], summary: 'Strategy to use for fetching commits'
            map :depth,            to: :any, types: [:num, :bool], summary: 'Number of commmits to fetch, or false to clone all commits'
            map :quiet,            to: :bool, summary: 'Silence git clone log output'
            map :submodules,       to: :bool, summary: 'Avoid cloning submodules if given false'
            map :submodules_depth, to: :num, summary: 'Number of commits to fetch for submodules'
            map :lfs_skip_smudge,  to: :bool, summary: 'Skip fetching the git-lfs files during the initial git clone'
            map :sparse_checkout,  to: :str, summary: 'Populate the working directory sparsely'
            map :autocrlf,         to: [:bool, :str], values: [true, false, 'input'], summary: 'Specify handling of line endings when cloning repository'

            export
          end
        end
      end
    end
  end
end
