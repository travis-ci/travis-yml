# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Perl6 < Type::Lang
          register :perl6

          def define
            title 'Perl 6'
            summary 'Perl 6 language support'
            see 'Building a Perl 6 Project': 'https://docs.travis-ci.com/user/languages/perl6/'
            matrix :perl6
          end
        end
      end
    end
  end
end
