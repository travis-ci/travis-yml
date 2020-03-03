# frozen_string_literal: true

module Travis
  module Yml
    module Schema
      module Def
        class Perl < Type::Lang
          register :perl

          def define
            title 'Perl'
            summary 'Perl language support'
            see 'Building a Perl Project': 'https://docs.travis-ci.com/user/languages/perl/'
            matrix :perl
          end
        end
      end
    end
  end
end
