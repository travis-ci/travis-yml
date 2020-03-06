# frozen_string_literal: true
require 'travis/yml/doc/validate/base'

module Travis
  module Yml
    module Doc
      module Validate
        class Empty < Base
          register :empty

          def apply
            apply? && empty? ? empty : value
          end

          def apply?
            schema.seq? || schema.map? || value.secure?
          end

          def empty?
            !value.given?
          end

          def empty
            value.msg :warn, :empty, key: value.full_key.to_s if warn?
            blank
          end

          def warn?
            value.secure? || !value.errored? && value.enabled?(:empty)
          end
        end
      end
    end
  end
end
