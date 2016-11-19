require 'travis/yaml/spec/type/lang'

module Travis
  module Yaml
    module Spec
      module Def
        class R < Type::Lang
          register :r

          def define
            name :r

            matrix :r

            map :apt_packages,        to: :seq
            map :bioc_packages,       to: :seq
            map :bioc_required,       to: :scalar, cast: :bool
            map :bioc_use_devel,      to: :scalar, cast: :bool
            map :brew_packages,       to: :scalar
            map :cran,                to: :scalar
            map :disable_homebrew,    to: :scalar, cast: :bool
            map :latex,               to: :scalar
            map :pandoc,              to: :scalar
            map :pandoc_version,      to: :scalar
            map :r_binary_packages,   to: :seq
            map :r_build_args,        to: :scalar
            map :r_check_args,        to: :scalar
            map :r_check_revdep,      to: :scalar
            map :r_github_packages,   to: :seq
            map :r_packages,          to: :seq
            map :warnings_are_errors, to: :scalar, cast: :bool
            map :Remotes,             to: :scalar
            map :repos,               to: :map
          end
        end
      end
    end
  end
end
