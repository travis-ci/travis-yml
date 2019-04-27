# frozen_string_literal: true
require 'travis/yml/schema/def/lang/jdks'
require 'travis/yml/schema/dsl/lang'

module Travis
  module Yml
    module Schema
      module Def
        class Ruby < Lang
          register :ruby

          def define
            matrix :rvm, alias: [:ruby, :rbenv]
            matrix :gemfile, alias: :gemfiles
            matrix :jdk, to: :jdks

            map :bundler_args, to: :str
          end
        end
      end
    end
  end
end
