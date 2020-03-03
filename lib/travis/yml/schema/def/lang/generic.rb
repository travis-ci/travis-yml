# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Generic < Type::Lang
          register :generic

          def define
            title 'Generic'
            summary 'Generic language support'
            see 'Minimal and Generic images': 'https://docs.travis-ci.com/user/languages/minimal-and-generic/'
          end
        end
      end
    end
  end
end
