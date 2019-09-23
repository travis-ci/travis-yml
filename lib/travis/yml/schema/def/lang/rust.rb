# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Rust < Type::Lang
          register :rust

          def define
            title 'Rust'
            summary 'Rust language support'
            see 'Building a Rust Project': 'https://docs.travis-ci.com/user/languages/rust/'
            matrix :rust
          end
        end
      end
    end
  end
end
