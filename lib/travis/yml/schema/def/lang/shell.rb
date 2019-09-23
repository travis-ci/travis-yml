# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Shell < Type::Lang
          register :shell

          def define
            title 'Shell'
            summary 'Shell language support'
            see 'Minimal and Generic images': 'https://docs.travis-ci.com/user/languages/minimal-and-generic/'
            aliases *%i(bash generic minimal sh)
          end
        end
      end
    end
  end
end
