# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class R < Type::Lang
          register :r

          def define
            title 'R'
            summary 'R language support'
            see 'Building an R Project': 'https://docs.travis-ci.com/user/languages/r/'
            matrix :r

            map :r_packages,          to: :seq
            map :r_binary_packages,   to: :seq
            map :r_github_packages,   to: :seq
            map :apt_packages,        to: :seq
            map :bioc_packages,       to: :seq
            map :brew_packages,       to: :seq

            map :bioc,                to: :str # test
            map :bioc_check,          to: :bool
            map :bioc_required,       to: :bool, alias: :use_bioc
            map :bioc_use_devel,      to: :bool
            map :cran,                to: :str
            map :disable_homebrew,    to: :bool
            map :latex,               to: :bool
            map :pandoc,              to: :bool
            map :pandoc_version,      to: :str
            map :r_build_args,        to: :str
            map :r_check_args,        to: :str
            map :r_check_revdep,      to: :bool
            map :warnings_are_errors, to: :bool
            map :remotes,             to: :str # this does not seem to be used in travis-build?
            map :repos,               to: :map, strict: false
            map :use_devtools,        to: :bool
          end
        end
      end
    end
  end
end
