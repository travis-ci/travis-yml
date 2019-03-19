# frozen_string_literal: true
require 'travis/yaml/doc/validate/validator'

module Travis
  module Yaml
    module Doc
      module Validate
        class DuplicateNames < Validator
          include Helper::Memoize

          register :duplicate_names

          def apply
            warn if apply? && duplicate_names.any?
            node
          end

          private

            def apply?
              node.full_key == :'matrix.include'
            end

            def duplicate_names
              names.select { |name| names.count(name) > 1 }.uniq
            end
            memoize :duplicate_names

            def names
              node.map { |node| node[:name] }.value.map(&:value)
            end
            memoize :names

            def warn
              node.warn :duplicate_names, value: duplicate_names
            end

            def msg?
              ![:sudo, :os, :dist].include?(node.key) # TODO
            end
        end
      end
    end
  end
end
